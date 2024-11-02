
// Calculate the direction from the object to the mouse
var direction_to_mouse = point_direction(x, y, mouse_x, mouse_y);

// Set the speed at which the object should move
var spd = 4; // Adjust this value as needed for faster or slower movement

// Move the object towards the mouse position
x += lengthdir_x(spd, direction_to_mouse);
y += lengthdir_y(spd, direction_to_mouse);


part_system_position(_ps, x, y);