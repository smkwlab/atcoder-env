#!/usr/bin/env escript

main(_) ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [A, B]} = io:fread("", "~d ~d"),

    Result = solve(N),
    io:format("~w~n", [Result]).

solve(N) ->
    ok.
