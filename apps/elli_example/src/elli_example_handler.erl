-module(elli_example_handler).
-behaviour(elli_handler).

-export([handle/2, handle_event/3]).

handle(Req, _Args) ->
    Method = elli_request:method(Req),
    Path   = elli_request:path(Req),

    case {Method, Path} of
        {'GET', []} -> index();

        _           -> not_found()
    end.

handle_event(_, _, _) ->
    ok.


%%
%% HTTP Responses
%%

index() ->
    {200, [{<<"Content-Type">>, <<"application/json">>}],
          <<"{\"msg\":\"JSON, Motherfucker -- Do you speak it?\"">>}.

not_found() ->
    {404, [{<<"Content-Type">>, <<"text/plain">>}],
          <<"Not Found">>}.
