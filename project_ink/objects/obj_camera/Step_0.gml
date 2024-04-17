camera_set_view_pos(view_camera[0],x,y);

/// Step Event of obj_camera
// Get the player's position
var player_x = obj_player.x;
var player_y = obj_player.y;

// Calculate the position for the camera to move towards
var target_x = player_x;
var target_y = player_y;

// Move the camera towards the target position
x += (target_x - x -600) / cam_speed;
y += (target_y - y -500) / cam_speed;