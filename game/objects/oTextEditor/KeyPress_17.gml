// After the code where you build up notepad_text
show_debug_message(notepad_text); // Print the text in the output console
show_message("Text printed to console!"); // Optionally notify the user

new_thread_msg = {from: "vim", answer:notepad_text, title:global.title, question:global.question, examples:global.examples};
send_to_server(new_thread_msg);
