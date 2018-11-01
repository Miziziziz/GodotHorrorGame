shader_type spatial;
render_mode unshaded;

uniform vec4 color : hint_color;

void fragment() {
	ALBEDO = color.xyz;
}