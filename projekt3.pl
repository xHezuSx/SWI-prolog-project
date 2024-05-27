/*
Program: System Informacji o Rze�bach

Tematyka - Rze�by:
Program ten jest systemem informacyjnym dotycz�cym rze�b. Umo�liwia
wczytywanie danych o rze�bach z pliku CSV, przegl�danie danych,
generowanie losowych rze�b oraz wyszukiwanie rze�b na podstawie
okre�lonych kryteri�w.

Cel:
Celem programu jest dostarczenie u�ytkownikowi narz�dzia do zarz�dzania
informacjamio rze�bach, umo�liwiaj�c �atwe przegl�danie, losowe
wybieranie oraz wyszukiwani rze�b na podstawie r�nych parametr�w.

Zastosowanie:
Program mo�e by� u�ywany przez muzea, galerie sztuki oraz kolekcjoner�w
rze�b do zarz�dzania informacjami o ich kolekcjach. Mo�e r�wnie� s�u�y�
jako narz�dzie edukacyjne dla student�w historii sztuki oraz os�b
zainteresowanych rze�b�.

Problem:
Program rozwi�zuje problem r�cznego zarz�dzania du�ymi zbiorami danych o rze�bach,
umo�liwiaj�c szybkie i efektywne wyszukiwanie informacji oraz
generowanie losowychprzyk�ad�w rze�b dla cel�w badawczych
lub edukacyjnych.
*/


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

% Wczytanie rze�b z pliku CSV (W zale�no�ci od tego, gdzie znajduje sie
% plik)
load_sculptures(Sculptures) :-
    csv_read_file('C:/Users/filip/Desktop/data.csv', Rows, [functor(row)]),
    Rows = [_Header | Sculptures]. % Pomijamy nag��wek

% Wylosowanie warto�ci z okre�lonej kolumny
random_value(Column, Value) :-
    load_sculptures(Sculptures),
    length(Sculptures, Len),
    random_between(1, Len, Index), % Losujemy indeks wiersza
    nth1(Index, Sculptures, Sculpture),
    Sculpture =.. [_|Values], % Konwersja row na list� warto�ci
    nth1(Column, Values, Value). % Pobieramy warto�� z okre�lonej kolumny

% Generowanie losowej rze�by
generate_random_sculpture(SculptureName) :-
    random_value(2, Material),
    random_value(3, XDimension),
    random_value(4, YDimension),
    random_value(5, ZDimension),
    random_value(6, Technique),
    random_value(7, Topic),
    random_value(8, Style),
    random_value(9, Color),
    format("Nazwa rze�by: ~w\n", [SculptureName]),
    format("Materia�: ~w\n", [Material]),
    format("Wymiary: ~w x ~w x ~w cm\n", [XDimension, YDimension, ZDimension]),
    format("Technika rze�bienia: ~w\n", [Technique]),
    format("Temat: ~w\n", [Topic]),
    format("Styl: ~w\n", [Style]),
    format("Kolor: ~w\n", [Color]).
% Zapytania:
% ?- generate_random_sculpture('Losowa rze�ba1').
% ?- generate_random_sculpture('Losowa rze�ba2').



% Wypisanie podanej kolumny na podstawie jej nazwy
print_column(ColumnHeader) :-
    column_name_to_number(ColumnHeader, Column),
    load_sculptures(Sculptures),
    maplist(arg(Column), Sculptures, Values),
    writeln(Values).
% Zapytania:
%?- print_column('Material').
%?- print_column('Kolor').


% Wypisanie unikalnych warto�ci z podanej kolumny
print_unique_column_values(ColumnHeader) :-
    column_name_to_number(ColumnHeader, Column),
    load_sculptures(Sculptures),
    maplist(arg(Column), Sculptures, Values),
    sort(Values, UniqueValues),  % Usuwanie powtarzaj�cych si� warto�ci
    writeln(UniqueValues).

%?-print_unique_column_values('Material').
%?-print_unique_column_values('Kolor').




% Wypisanie podanego wiersza
print_row(Index) :-
    load_sculptures(Sculptures),
    nth1(Index, Sculptures, Row),
    writeln(Row).
% Zapytania:
%?- print_row(1).
%?- print_row(5).


% Wyszukiwanie rze�b wed�ug warto�ci w podanej kolumnie
search_sculptures_by_column(ColumnHeader, Value) :-
    column_name_to_number(ColumnHeader, Column),
    load_sculptures(Sculptures),
    include(has_value(Column, Value), Sculptures, FilteredSculptures),
    maplist(print_sculpture, FilteredSculptures).
%?- search_sculptures_by_column('Kolor', 'Bialy').
%?- search_sculptures_by_column('Material', 'Marmur').


% Pomocniczy predykat sprawdzaj�cy warto�� w danej kolumnie
has_value(Column, Value, Sculpture) :-
    Sculpture =.. [row|Values],
    nth1(Column, Values, Value).

% Pomocniczy predykat do wypisania szczeg��w rze�by
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
    format("Nazwa rze�by: ~w\n", [SculptureName]),
    format("Materia�: ~w\n", [Material]),
    format("Wymiary: ~w x ~w x ~w cm\n", [XDimension, YDimension, ZDimension]),
    format("Technika rze�bienia: ~w\n", [Technique]),
    format("Temat: ~w\n", [Topic]),
    format("Styl: ~w\n", [Style]),
    format("Kolor: ~w\n", [Color]), nl.
