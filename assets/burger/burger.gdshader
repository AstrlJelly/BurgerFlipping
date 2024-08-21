shader_type canvas_item;

uniform vec2 cookedPercentages = vec2(0, 0);

uniform sampler2D rawBurgers[5];
uniform sampler2D cookedBurgers[3];

void vertex() {
	//VERTEX.x += 50.0;
}

void fragment() {
	//vec4 new_color = vec4(1, 0, 0, 1);
	//vec3 new_color = vec3(abs((mod(TIME / 2.0, 2) - 1.0)), 0.0, 0.0);
	
	vec4 rawColor = textureLod(rawBurgers[0], vec2(UV.x, UV.y / 5.0), 0.0);
	vec2 rawPercentages = 1.0 - cookedPercentages;
	rawColor.rgb *= rawPercentages.x * (1.0 - UV.y) + (rawPercentages.y * UV.y);
	vec4 cookedColor = textureLod(cookedBurgers[0], vec2(UV.x, UV.y / 5.0), 0.0);
	cookedColor.rgb *= cookedPercentages.x * (1.0 - UV.y) + (cookedPercentages.y * UV.y);
	COLOR.rgb *= rawColor.rgb + cookedColor.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
