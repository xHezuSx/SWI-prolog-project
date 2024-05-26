:- use_module(library(csv)).
:- use_module(library(random)).

% Mapowanie nazwy kolumny na numer kolumny
column_name_to_number('Nazwa rzezby', 1).
column_name_to_number('Material', 2).
column_name_to_number('Wymiar X (cm)', 3).
column_name_to_number('Wymiar Y (cm)', 4).
column_name_to_number('Wymiar Z (cm)', 5).
column_name_to_number('Technika rzezbienia', 6).
column_name_to_number('Temat', 7).
column_name_to_number('Styl', 8).
column_name_to_number('Kolor', 9).

% Wczytanie rzeüb z pliku CSV
load_sculptures(Sculptures) :-
    csv_read_file('C:/Users/filip/Desktop/data.csv', Rows, [functor(row)]),
    Rows = [_Header | Sculptures]. % Pomijamy nag≥Ûwek

% Wylosowanie wartoúci z okreúlonej kolumny
random_value(Column, Value) :-
    load_sculptures(Sculptures),
    length(Sculptures, Len),
    random_between(1, Len, Index), % Losujemy indeks wiersza
    nth1(Index, Sculptures, Sculpture),
    Sculpture =.. [_|Values], % Konwersja row na listÍ wartoúci
    nth1(Column, Values, Value). % Pobieramy wartoúÊ z okreúlonej kolumny

% Generowanie losowej rzeüby
generate_random_sculpture(SculptureName) :-
    random_value(2, Material),
    random_value(3, XDimension),
    random_value(4, YDimension),
    random_value(5, ZDimension),
    random_value(6, Technique),
    random_value(7, Topic),
    random_value(8, Style),
    random_value(9, Color),
    format("Nazwa rzeüby: ~w\n", [SculptureName]),
    format("Materia≥: ~w\n", [Material]),
    format("Wymiary: ~w x ~w x ~w cm\n", [XDimension, YDimension, ZDimension]),
    format("Technika rzeübienia: ~w\n", [Technique]),
    format("Temat: ~w\n", [Topic]),
    format("Styl: ~w\n", [Style]),
    format("Kolor: ~w\n", [Color]).

% Wypisanie podanej kolumny na podstawie jej nazwy
print_column(ColumnHeader) :-
    column_name_to_number(ColumnHeader, Column),
    load_sculptures(Sculptures),
    maplist(arg(Column), Sculptures, Values),
    writeln(Values).

% Wypisanie podanego wiersza
print_row(Index) :-
    load_sculptures(Sculptures),
    nth1(Index, Sculptures, Row),
    writeln(Row).
%---------------


% Wyszukiwanie rzeüb wed≥ug wartoúci w podanej kolumnie
search_sculptures_by_column(ColumnHeader, Value) :-
    column_name_to_number(ColumnHeader, Column),
    load_sculptures(Sculptures),
    include(has_value(Column, Value), Sculptures, FilteredSculptures),
    maplist(print_sculpture, FilteredSculptures).

% Pomocniczy predykat sprawdzajπcy wartoúÊ w danej kolumnie
has_value(Column, Value, Sculpture) :-
    Sculpture =.. [row|Values],
    nth1(Column, Values, Value).

% Pomocniczy predykat do wypisania szczegÛ≥Ûw rzeüby
print_sculpture(Sculpture) :-
    Sculpture =.. [row|Values],
    nth1(1, Values, SculptureName),
    nth1(2, Values, Material),
    nth1(3, Values, XDimension),
    nth1(4, Values, YDimension),
    nth1(5, Values, ZDimension),
    nth1(6, Values, Technique),
    nth1(7, Values, Topic),
    nth1(8, Values, Style),
    nth1(9, Values, Color),
    format("Nazwa rzeüby: ~w\n", [SculptureName]),
    format("Materia≥: ~w\n", [Material]),
    format("Wymiary: ~w x ~w x ~w cm\n", [XDimension, YDimension, ZDimension]),
    format("Technika rzeübienia: ~w\n", [Technique]),
    format("Temat: ~w\n", [Topic]),
    format("Styl: ~w\n", [Style]),
    format("Kolor: ~w\n", [Color]), nl.
