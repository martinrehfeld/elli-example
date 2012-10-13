-module(elli_example_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type, Args), {I, {I, start_link, Args}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, {{one_for_all, 0, 1}, [webserver()]}}.


%% ===================================================================
%% Internal functions
%% ===================================================================

webserver() ->
    MiddlewareConfig =
        [{mods, [{elli_access_log,      []},
                 {elli_example_handler, []}]}],

    {webserver,
     {elli, start_link, [[{port, 8080},
                          {callback, elli_middleware},
                          {callback_args, MiddlewareConfig},
                          {name, {local, elli}}]]},
     permanent, 5000, worker, [elli]}.
