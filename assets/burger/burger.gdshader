shader_type canvas_item;

uniform vec2 cookedPercentages = vec2(0, 0);

uniform sampler2D rawBurgers[5];
uniform sampler2D cookedBurgers[3];

uniform int whichRaw;
uniform int whichCooked;

void vertex() {
	// body
}

void fragment() {
	// preserve resolution of burger texture
	vec2 size = vec2(textureSize(TEXTURE, 0));
	bool xGreater = size.x > size.y;
	float equalizer = xGreater ? (size.x / size.y) : (size.y / size.x);
	vec2 textureUv = UV;
	if (xGreater) {
		textureUv.y /= equalizer;
	} else {
		textureUv.x /= equalizer;
	}

	// use the original texture to map to red and green
	vec4 colorMap = COLOR;
	vec2 rawPercentages = 1.0 - cookedPercentages;
	
	// raw
	vec4 rawColor = textureLod(rawBurgers[whichRaw], textureUv, 0.0);
	rawColor.rgb *= rawPercentages.x * (1.0 - UV.x) + (rawPercentages.y * colorMap.g);
	
	// cooked
	vec4 cookedColor = textureLod(cookedBurgers[whichCooked], textureUv, 0.0);
	cookedColor.rgb *= cookedPercentages.x * (1.0 - UV.x) + (cookedPercentages.y * colorMap.g);
	
	// modify color
	COLOR.rgb = rawColor.rgb + cookedColor.rgb;
}
