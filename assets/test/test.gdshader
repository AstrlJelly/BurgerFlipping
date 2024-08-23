shader_type canvas_item;

uniform vec2 cookedPercentages = vec2(1, 0.5);

uniform sampler2D rawBurgers[5];
uniform sampler2D cookedBurgers[3];

void vertex() {
	//VERTEX.x += 50.0;
}

void fragment() {
	COLOR = vec4(1, 1, 1, 1);
	vec4 new_color = vec4(0.85, 1, 0, 0.7);
	//vec3 new_color = vec3(abs((mod(TIME / 2.0, 2) - 1.0)), 0.0, 0.0);

	COLOR *= new_color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
