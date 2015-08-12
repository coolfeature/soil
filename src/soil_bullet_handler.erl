-module(soil_bullet_handler).

-export([init/4]).
-export([stream/3]).
-export([info/3]).
-export([terminate/2]).

-export([sessions/0]).

-record(state,{sid}).

-define(GPROC_KEY(Sid),{n,l,Sid}).

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

init(_Transport, Req, _Opts, Active) ->
  {[Sid],Req1} = cowboy_req:path_info(Req),
  %% ensure registered
  case gproc:where(?GPROC_KEY(Sid)) of
    undefined ->
      io:fwrite("Sid ~p undefined -> REGISTERING ~n",[Sid]),
      gproc:reg(?GPROC_KEY(Sid),self(),[{map,#{ active => Active }}]);
    Pid -> 
      if Pid =:= self() -> 
        io:fwrite("Registered Pid the same as self() -> OK ~n",[]),
        ok; 
      true -> 
        io:fwrite("Registered Pid different from self() -> REGISTERING ~n",[]),
        gproc:reg(?GPROC_KEY(Sid),self()) 
      end
  end,
  {ok, Req1, #state{ sid = Sid }}.

stream(Data, Req, #state{sid=_Sid}=State) ->  
  JsonMap = jsx:decode(Data,[return_maps]),
  io:fwrite("Web Socket stream ~p ~n",[JsonMap]),
  HeaderMap = maps:get(<<"header">>,JsonMap,#{}),
  Action = maps:get(<<"action">>,HeaderMap,undefined), 
  dispatch(Action,JsonMap),
  {ok, Req, State}.

info(Map, Req, State) ->
  Json = jsx:encode(Map),
  io:fwrite("RESPONSE JSON IN BULLET HANDLER: ~p ~n",[Json]),
  {reply, Json, Req, State}.

terminate(_Req,#state{sid=Sid}=_State) ->
  %% ensure unregistered
  case gproc:where(?GPROC_KEY(Sid)) of
    undefined -> 
      io:fwrite("~p ALREADY UNREGISTERED ~n",[Sid]),
      ok;
    _Pid ->
      io:fwrite("UNREGISTERING ~p~n",[Sid]),
      gproc:unreg(?GPROC_KEY(Sid)) 
  end,
  ok.

%% ------------------------------------------------------------------
%% @private API
dispatch(<<"view">>,JsonMap) ->
  % Let the client know there is a new conection
  self() ! #{ 
    header => #{ type => view, cbid => get_cbid(JsonMap) }
    ,body => sessions() 
  };
dispatch(undefined,JsonMap) ->
  io:fwrite("UNDEFINED ACTION: ~p~n",[JsonMap]),
  ok.
%% ------------------------------------------------------------------
%% @private API

sessions() ->
  List = gproc:select([{{'_', '_', '_'},[],['$$']}]),
  lists:foldl(fun(Elem,Acc) ->
    [Key,_Pid1,_Pid2] = Elem,
    {_,_,Sid} = Key,
    Acc ++ [[{sid,Sid},{properties,gproc:get_attribute(Key,map)}]]
  end,[],List).

get_cbid(JsonMap) ->
  HeaderMap = maps:get(<<"header">>,JsonMap,#{}),
  maps:get(<<"cbid">>,HeaderMap,0). 


