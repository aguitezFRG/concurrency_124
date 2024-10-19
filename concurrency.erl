-module(concurrency).
-compile(export_all).

% start_pong() ->
% 	register (pong, spawn(pingpong,pong,[])).

% pong() ->
% 	receive
% 		finished ->
% 			io:format("Pong finished ~n");
% 		{ping, Ping_Pid} ->
% 			io:format("Pong got ping ~n"),
% 			Ping_Pid ! pong,
% 			pong()
% 	end.

% start_ping(Pong_Node) ->
% 	spawn(pingpong, ping, [3,Pong_Node]).

% ping(0, Pong_Node) ->
% 	{pong, Pong_Node} ! finished,
% 	io:format("Ping finished");
% ping(N, Pong_Node) ->
% 	{pong, Pong_Node} ! {ping, self()},
% 	receive
% 		pong ->
% 			io:format("Ping got pong~n")
% 	end,
% 	ping(N-1,Pong_Node).

% init_chat() ->
% 	User1 = io:get_line("Enter your name: "),
% 	register(chat, spawn(concurrency, chat, [])).

% chat() ->
% 	receive 
% 		{chat2, Chat2_id, Name, "bye\n"} ->
% 			io:format("~s: ~s", [Name, "bye\n"]),
% 			exit(normal);
% 		{chat2, Chat2_id, Name, Incoming} ->
% 			io:format("~s: ~s", [Name, Incoming])
% 			chat()
% 	end,
% 	Message = io:get_line("You: ").

% init_chat2(Chat_node) ->
% 	User2 = io:get_line("Enter your name: "),
% 	spawn(concurrency, chat2, [Chat_node]).

% chat2(Chat_node) ->
% 	Message = io:get_line("You: "),
% 	receive

% 	end.
	

% chat(Name, Message, Chat_node) ->
% 	io:format("Name: ~s~n", [Name]),
% 	io:format("Message: ~s~n", [Message]),
% 	io:format("Chat node: ~p~n", [Chat_node]).

% username input
user_name() ->
	Name = io:get_line("Enter name: "),
	message_input(Name).

% text prompt
message_input(Name) ->
	io:format("~s: ", [string:trim(Name)]),
	Message = io:get_line(""),
	case Message of
		"bye\n" ->
			io:format("Goodbye~n");
		_ ->
			message_input(Name)
	end.