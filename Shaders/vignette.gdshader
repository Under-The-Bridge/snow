shader_type canvas_item;
render_mode unshaded;

uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float strength : hint_range(0.0, 1.0) = 0.7;
uniform float radius : hint_range(0.0, 1.0) = 0.35;
uniform float softness : hint_range(0.01, 0.5) = 0.3;

void fragment() {
	float distance_to_center = length(UV - vec2(0.5));
	float vignette = smoothstep(
		radius, radius + softness, distance_to_center
	);

	COLOR = vec4(
		vignette_color.rgb,
		vignette * strength * vignette_color.a
	);
}
