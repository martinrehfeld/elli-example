-module(elli_example).
-behaviour(application).

-export([start/0, start/2, stop/1]).

start() ->
    application:start(elli_example).

start(_StartType, _StartArgs) ->
    case elli_example_sup:start_link() of
        {ok, Pid} -> {ok, Pid};
        Other ->     {error, Other}
    end.

stop(_State) ->
    ok.
