/// @description Insert description here
// You can write your code in this editor

mouth_step += 1;
if(mouth_step == 10){
	mouth_open = !mouth_open;
	mouth_step = 0;
}

if(instance_exists(oInterviewVisualiser)){
	if(mouth_open){mouth = sprMouthOpen;}
	else{mouth = sprMouth};
	brow_target = 30;
	
} else {
	mouth = sprMouth;	
	brow_target = -10;
}

if(brow_offset < brow_target){
	brow_offset += 0.5;
} else if (brow_offset > brow_target) {
	brow_offset -= 0.5;	
}