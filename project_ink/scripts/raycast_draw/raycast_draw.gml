///@desc raycast_draw(ray)
///@arg ray
function raycast_draw() {

	/*
		This is for debugging purposes.
		Draw a line from the start of the ray, to the end of the ray.
	*/

	var _ray = argument[0];

	switch(_ray[? "obj"] == noone)
	{
		case true: draw_set_colour(c_red); break;
		case false: draw_set_colour(c_lime); break;
	}

	draw_line_width(_ray[? "x_origin"], _ray[? "y_origin"], _ray[? "x"], _ray[? "y"], 2);

	draw_set_colour(c_white);

	//	don't destroy the map, as it would just destroy the array from the argument
	//	- not the local variable
	_ray = undefined;


}
