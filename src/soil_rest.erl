-module(soil_rest).

-export([init/3]).
-export([
  rest_init/2
  ,content_types_provided/2
  ,to_html/2
  ,to_json/2
  ,to_text/2
  ,rest_terminate/2
]).

-record(state,{templates_path,sid}).

init(_Transport, _Req, _Opts) ->
  {upgrade, protocol, cowboy_rest}.

rest_init(Req, _Opts) ->
  {ok, Req, #'state'{}}.

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, to_html},
    {<<"application/json">>, to_json},
    {<<"text/plain">>, to_text}
  ], Req, State}.

to_html(Req, State) ->
  Template = soil_utls:priv_dir() ++ "/app/templates/index.tpl",
  {ok,_Module} = erlydtl:compile_file(Template,index_dtl),
  Sid = 123,
  Host = "dev-esb-2",
  ClientTimeout = 5000,
  {ok,Body} = index_dtl:render([
    {sid,Sid}
    ,{hostname,Host}
    ,{client_timeout,ClientTimeout}
    ,{authenticated,false}
  ]),
  {Body, Req, State}.

to_json(Req, State) ->
  Body = <<"{\"rest\": \"Hello World!\"}">>,
  {Body, Req, State}.

to_text(Req, State) ->
  {<<"REST Hello World as text!">>, Req, State}.

rest_terminate(_Req,_State) ->
  ok.
