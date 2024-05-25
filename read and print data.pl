:- use_module(library(csv)).


% nazwa pliku w formacie 'C:/Users/User/Desktop/testy/data.csv' zakres
% kolumn: 1-11
wypisz_kolumne_csv(NazwaPliku, NumerKolumny) :-
    open(NazwaPliku, read, Strumien),
    set_stream(Strumien, encoding(utf8)),
    csv_read_stream(Strumien, Wiersze, []),
    maplist(wypisz_kolumne(NumerKolumny), Wiersze),
    close(Strumien).

wypisz_kolumne(NumerKolumny, Wiersz) :-
    Wiersz =.. [_|Kolumny],
    nth1(NumerKolumny, Kolumny, Wartosc),
    format('~w~n', [Wartosc]).
