-module(concurrency).
-compile(export_all).

% initialize the nodes
init_chat() ->
	User1 = io:get_line("Enter your name: "),
	register(chat, spawn(concurrency, chat, [User1])).

init_chat2(Chat_node) ->
	User2 = io:get_line("Enter your name: "),
	spawn(concurrency, chat2, [Chat_node, User2]).

% theoretical flow
% might split into at least two more methods
% one for receiving messages
% the other for sending

% chat(User1) ->
% 	Send = io:get_line("You: "),
% 	{chat2} ! {chat, self(), User1, Send},
% 	receive 
% 		{chat2, Chat2_id, Name, Message} ->
% 			case Message of
% 				"bye\n" ->
% 					io:format("~s: ~s~n", [Name, Message]),
% 					{chat2, Chat2_id} ! {chat, User1, ""};
% 				"" ->
% 					io:format("Chat ended~n");
% 				_ ->
% 					io:format("~s: ~s~n", [Name, Message]),
% 					chat(User1)
% 			end
% 	end.

% chat2(Chat_node, User2) ->
% 	Send = io:get_line("You: "),
% 	{chat, Chat_node} ! {chat2, self(), User2, Send},
% 	receive
% 		{chat, Name, Message} ->
% 			case Message of
% 				"bye\n" ->
% 					io:format("~s: ~s~n", [Name, Message]),
% 					{chat, Chat_node} ! {chat2, self(), User2, ""};
% 				"" ->
% 					io:format("Chat ended~n");
% 				_ ->
% 					io:format("~s: ~s~n", [Name, Message]),
% 					chat2(Chat_node, User2)
% 			end
% 	end.

% end of codes to translate

% main method for chatting (node 1)
chat(User1) ->
	Input = io:get_line("You: "),
	{rec2} ! {User1, Input},
	case Input of
		"bye\n" ->
			io:format("You ended the chat~n");
		_ ->
			chat(User1)
	end.

% method that prints the response/message of the other person
rec() ->
	receive
		{chat2, Name, Message} ->
			case Message of
				"bye\n" ->
					io:format("~s: ~s", [Name, Message]),
					io:format("Chat ended~n");
				_ ->
					io:format("~s: ~s", [Name, Message]),
					rec()
			end
	end.

chat2(Chat_node, User2) ->
	Input = io:get_line("You: "),
	{rec, Chat_node} ! {chat2, User2, Input},
	case Input of
		"bye\n" ->
			io:format("You ended the chat~n");
		_ ->
			chat2(Chat_node, User2)
	end.

rec2() ->
	receive
		{Name, Message} ->
			case Message of
				"bye\n" ->
					io:format("~s: ~s~n", [Name, Message]),
					io:format("Chat ended~n");
				_ ->
					io:format("~s: ~s~n", [Name, Message]),
					rec2()
			end
	end.


% test code for input
% username input
user_name() ->
	Name = io:get_line("Enter name: "),
	message_input(Name).

% text prompt
message_input(Name) ->
	io:format("~s: ", ["You"]),
	Message = io:get_line(""),
	case Message of
		"bye\n" ->
			io:format("Goodbye ~s~n", [Name]);
		_ ->
			message_input(Name)
	end.