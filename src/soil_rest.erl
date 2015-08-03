-module(soil_rest).

-export([init/3]).
-export([
  rest_init/2
  ,content_types_provided/2
  ,hello_to_html/2
  ,hello_to_json/2
  ,hello_to_text/2
  ,rest_terminate/2
]).

-record(state,{templates_path,sid}).

init(_Transport, Req, Opts) ->
  {upgrade, protocol, cowboy_rest}.

rest_init(Req, Opts) ->
  {ok, Req, #'state'{}}.

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, hello_to_html},
    {<<"application/json">>, hello_to_json},
    {<<"text/plain">>, hello_to_text}
  ], Req, State}.

hello_to_html(Req, State) ->
  {<<"Hello HTML">>, Req, State}.

hello_to_json(Req, State) ->
  Body = <<"{\"rest\": \"Hello World!\"}">>,
  {Body, Req, State}.

hello_to_text(Req, State) ->
  {<<"REST Hello World as text!">>, Req, State}.

rest_terminate(_Req,_State) ->
  ok.
