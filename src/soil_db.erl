-module(soil_db).

-export([
  init/0
]).

init() ->
  application:start(mnesia).
