extends KinematicBody

onready var grid_map = get_parent().get_node("GridMap")
onready var player = get_parent().get_node("Player")
onready var rc = $RayCast

const MOVE_SPEED = 2

var cur_path = []
var cur_goal = null

func _physics_process(delta):
	cur_path = get_path()
	if cur_path.size() <= 0:
		return
	
	var g = grid_map.map_to_world(cur_path[0].x, cur_path[0].y, cur_path[0].z)
	var offset = g - translation
	if offset.length_squared() < 0.1:
		cur_path.pop_front()
		#print("reached: ", cur_path.pop_front())
	offset = offset.normalized()
	move_and_collide(offset * MOVE_SPEED * delta)
	
	rc.cast_to = (player.translation - translation).normalized()
	if rc.is_colliding() and rc.get_collider().has_method("die"):
		rc.get_collider().die()
	

func get_path():
	var goal = grid_map.world_to_map(player.translation)
	if cur_goal != null and cur_goal == goal:
		return cur_path
	cur_goal = goal
	var cur = grid_map.world_to_map(translation)
	var path = backtrace(calc_path(goal, cur, 0, null))
	visited = {}
	queue = []
	return path

var visited = {}
var queue = []
func calc_path(goal_coord, cur_coord, depth, parent):
	if cur_coord == goal_coord:
		visited[str(cur_coord)] = parent
		return cur_coord
	if visited.has(str(cur_coord)):
		return null
	if depth > 500:
		print("depth")
		return null
	if grid_map.get_cell_item(cur_coord.x, cur_coord.y, cur_coord.z) >= 0:
		return null
	#print(cur_coord)
	depth += 1
	visited[str(cur_coord)] = parent
	queue.push_back([cur_coord + Vector3(1, 0, 0), cur_coord])
	queue.push_back([cur_coord + Vector3(-1, 0, 0), cur_coord])
	queue.push_back([cur_coord + Vector3(0, 0, -1), cur_coord])
	queue.push_back([cur_coord + Vector3(0, 0, 1), cur_coord])
	while queue.size() > 0:
		var cur = queue.pop_front()
		var res = calc_path(goal_coord, cur[0], depth, cur[1])
		if res != null:
			return res

func backtrace(coord):
	var path = []
	var cur_coord = coord
	while(visited.has(str(cur_coord)) and visited[str(cur_coord)] != null):
		if cur_coord != null:
			path.push_front(cur_coord)
		cur_coord = visited[str(cur_coord)]
	return path
	