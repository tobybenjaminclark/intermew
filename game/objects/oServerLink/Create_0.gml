
originalString = ""
global.client_socket = network_create_socket(network_socket_tcp);
global.received_sprite = -1;

server_socket = network_connect_raw_async(global.client_socket, "127.0.0.1", 36042);

if(server_socket < 0) show_message("Could not connect! Try turning on the server?");
else
{
	show_debug_message("connected to server!")
	// send reply to server
	dir_msg = {from: "client_stream", status:"hello"};
	send_to_server(dir_msg);
}