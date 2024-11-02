/// @description Insert description here
// You can write your code in this editor

// Increment the Current Step
current_step = current_step + 1;

// Grow the pie chart over the first 100 steps.
if(current_radius < upper_radius) {
	current_radius = lerp(start_radius, upper_radius, current_step / PIE_CHART_TIME)
}