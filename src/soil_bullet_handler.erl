-module(soil_bullet_handler).

-export([init/4]).
-export([stream/3]).
-export([info/3]).
-export([terminate/2]).

-record(state,{sid}).

%% ------------------------------------------------------------------
%% 
%% Bullet handlers should only contain transport related code, 
%% logic should be done in your session process if any, 
%% or other parts of your application. 
%% 
%% Bullet processes should be considered temporary as you never know 
%% when a connection is going to close and therefore lose your State.
%%
%% This code is invoked by the client-side JavaScipt. The client code
%% has already been provided with the SessionId which was generated 
%% and embeded in the shell page served from the static REST handler.
%% 
%% SessionId is a COOKIE.
%% ------------------------------------------------------------------
%% @private API
%%

init(_Transport, Req, _Opts, _Active) ->
  {ok, Req, #state{sid=undefined}}.

stream(Data, Req, #state{sid=Sid}=State) ->  
  send(Sid,Data),
  {ok, Req, State}.

info(Json, Req, State) ->
  io:fwrite("RESPONSE JSON IN BULLET HANDLER: ~p ~n",[Json]),
  {reply, Json, Req, State}.

terminate(_Req,#state{sid=_Sid}=_State) ->
  ok.

%% ------------------------------------------------------------------
%% @doc Sends a message to the session process in an asynchronous manner.
%%

send(Sid,Msg) ->
  gproc:send(Sid,Msg).


