// load

if (file_exists("notepad_text.txt")) {
    var file = file_text_open_read("notepad_text.txt");
    text = file_text_read_string(file);
    file_text_close(file);
}
