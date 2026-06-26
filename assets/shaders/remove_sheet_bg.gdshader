shader_type canvas_item;

uniform float brightness_cutoff : hint_range(0.0, 1.0) = 0.82;
uniform float saturation_cutoff : hint_range(0.0, 1.0) = 0.18;
uniform float alpha_cutoff : hint_range(0.0, 1.0) = 0.05;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float max_channel = max(color.r, max(color.g, color.b));
	float min_channel = min(color.r, min(color.g, color.b));
	float saturation = max_channel - min_channel;

	if (color.a <= alpha_cutoff) {
		discard;
	}

	if (max_channel >= brightness_cutoff && saturation <= saturation_cutoff) {
		discard;
	}

	COLOR = color;
}
