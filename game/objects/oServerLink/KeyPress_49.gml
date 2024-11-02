// start emotion
new_thread_msg = {from: "emotion_stream", status:"create"};
send_to_server(new_thread_msg);

// start interview
new_thread_msg = {action: "start_interview", job_chosen: "Graduate_Software_Developer_2.json"};
send_to_server(new_thread_msg);