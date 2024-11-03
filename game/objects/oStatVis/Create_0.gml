/// @description Insert description here
// You can write your code in this editor

// Update Score
update_score(interview_path, interview_index, 95);

var emotion_data = global.emotion_stats;

// Initialize sums
var sum_surprise = 0;
var sum_neutral = 0;
var sum_angry = 0;
var sum_disgust = 0;
var sum_fear = 0;
var sum_happy = 0;
var sum_sad = 0;
var sum_center_closeness = 0;

// Iterate through the keys and accumulate values
for (var i = 1; i < 51; i++) {
    var portion_name = "portion_" + string(i);
    var portion = struct_get(emotion_data, portion_name);
    
    sum_surprise += portion.surprise;
    sum_neutral += portion.neutral;
    sum_angry += portion.angry;
    sum_disgust += portion.disgust;
    sum_fear += portion.fear;
    sum_happy += portion.happy;
    sum_sad += portion.sad;
    sum_center_closeness += portion.center_closeness;
}

// Average the sum values
var avg_surprise = sum_surprise / 50;
var avg_neutral = sum_neutral / 50;
var avg_angry = sum_angry / 50;
var avg_disgust = sum_disgust / 50;
var avg_fear = sum_fear / 50;
var avg_happy = sum_happy / 50;
var avg_sad = sum_sad / 50;
var avg_center_closeness = sum_center_closeness / 50;

// Create the pie chart instance
pie_chart = instance_create_layer(x + 300, y, "Instances", oPieChart, {
    data: [
        avg_surprise, 
        avg_neutral, 
        avg_angry, 
        avg_disgust, 
        avg_fear, 
        avg_happy, 
        avg_sad, 
    ],
    labels: [
        "Surprise", 
        "Neutral", 
        "Angry", 
        "Disgust", 
        "Fear", 
        "Happy", 
        "Sad", 
    ]
});

fdd = instance_create_layer(room_width div 2,
	(room_height div 3) * 2,
	"Instances",
	oLLMFeedback, {description: global.fdback});