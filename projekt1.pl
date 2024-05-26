:- use_module(library(csv)).
:- use_module(library(random)).
:- use_module(library(lists)).

load_sculptures(Sculptures) :-
    csv_read_file("C:/Users/User/Desktop/data.csv", Sculptures).


random_value(Column, Value) :-
    load_sculptures(Sculptures),
    random_between(2, 10, Index),
    nth1(Index, Sculptures, Sculpture),
    term_to_atom(Sculpture, Atom),
    atomic_list_concat(List, ',', Atom),
    nth1(Column, List, Value).


generate_random_sculpture(SculptureName) :-
    random_value(1, Material),
    random_value(2, XDimension),
    random_value(3, YDimension),
    random_value(4, ZDimension),
    random_value(5, Technique),
    random_value(6, Topic),
    random_value(7, Style),
    random_value(8, Color),
    format("Nazwa rzezby: ~w\n", [SculptureName]),
    format("Material: ~w\n", [Material]),
    format("Wymiary: ~w x ~w x ~w cm\n", [XDimension, YDimension, ZDimension]),
    format("Technika rzezbienia: ~w\n", [Technique]),
    format("Temat: ~w\n", [Topic]),
    format("Styl: ~w\n", [Style]),
    format("Kolor: ~w\n", [Color]).

