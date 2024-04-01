var ray, dir, obj;
dir = point_direction(x, y, mouse_x, mouse_y);
ray = raycast(x, y, dir, 400, all);
obj = ray[? "obj"];

draw_set_colour(c_black);
draw_text(0, 0, string(fps))
draw_text(0, 16, string(fps_real))
if (obj != noone)
	draw_text(0, 32, object_get_name(obj.object_index))

draw_text(0, 16, string(fps_real))

switch(obj == noone)
{
	case true: draw_set_colour(c_red); break;
	case false: draw_set_colour(c_lime); break;
}
raycast_draw(ray);

draw_set_colour(c_white);

ds_map_destroy(ray);
