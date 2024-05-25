:- use_module(library(random)).
:- use_module(library(lists)).

% Fakty o rzeübach
typ_rzezby(dawid, renesans).
typ_rzezby(wenus_z_milo, starozytna_grecja).
typ_rzezby(mysliciel, nowozytny).
typ_rzezby(moai, starozytna_polinezja).
typ_rzezby(pieta, renesans).

% Fakty o materialach
material(renesans, marmur).
material(starozytna_grecja, marmur).
material(nowozytny, braz).
material(starozytna_polinezja, kamien).

% Fakty o technikach
technika(renesans, dlutowanie).
technika(starozytna_grecja, dlutowanie).
technika(nowozytny, odlewanie).
technika(starozytna_polinezja, rzezba).

% Fakty o rzeübiarzach
rzezbiarz(michelangelo, dawid).
rzezbiarz(michelangelo, pieta).
rzezbiarz(rodin, mysliciel).
rzezbiarz(nieznany, wenus_z_milo).
rzezbiarz(nieznany, moai).

% Fakty o podobnych rzeübach
podobne_rzezby(dawid, [pieta, mysliciel, wenus_z_milo]).
podobne_rzezby(wenus_z_milo, [mysliciel, dawid, moai]).
podobne_rzezby(mysliciel, [moai, dawid, wenus_z_milo]).
podobne_rzezby(pieta, [dawid, mysliciel, moai]).
podobne_rzezby(moai, [wenus_z_milo, mysliciel, dawid]).

% Przyk≥adowe drzewa decyzyjne (symulowane)
drzewo1(Rzezba, Material, Technika, Rzezbiarz, Podobna) :-
    typ_rzezby(Rzezba, Typ),
    material(Typ, Material),
    technika(Typ, Technika),
    rzezbiarz(Rzezbiarz, Rzezba),
    podobne_rzezby(Rzezba, Podobne),
    random_member(Podobna, Podobne).

drzewo2(Rzezba, Material, Technika, Rzezbiarz, Podobna) :-
    typ_rzezby(Rzezba, Typ),
    technika(Typ, Technika),
    material(Typ, Material),
    rzezbiarz(Rzezbiarz, Rzezba),
    podobne_rzezby(Rzezba, Podobne),
    random_member(Podobna, Podobne).

drzewo3(Rzezba, Material, Technika, Rzezbiarz, Podobna) :-
    material(Typ, Material),
    typ_rzezby(Rzezba, Typ),
    technika(Typ, Technika),
    rzezbiarz(Rzezbiarz, Rzezba),
    podobne_rzezby(Rzezba, Podobne),
    random_member(Podobna, Podobne).

% Lista drzew decyzyjnych
lista_drzew([drzewo1, drzewo2, drzewo3]).

% WybÛr losowego drzewa i zastosowanie go
losowe_drzewo(Rzezba, Material, Technika, Rzezbiarz, Podobna) :-
    lista_drzew(Drzewa),
    random_member(Drzewo, Drzewa),
    call(Drzewo, Rzezba, Material, Technika, Rzezbiarz, Podobna).

% Inicjacja zapytania o rekomendacje z losowym drzewem
rekomenduj_rzezbe(Rzezba) :-
    losowe_drzewo(Rzezba, Material, Technika, Rzezbiarz, Podobna),
    write('Rekomendacje dla '), write(Rzezba), nl,
    write('Material: '), write(Material), nl,
    write('Technika: '), write(Technika), nl,
    write('Rzezbiarz: '), write(Rzezbiarz), nl,
    write('Podobna rzeüba: '), write(Podobna), nl.

% Inicjacja zapytania o klasyfikacjÍ z losowym drzewem
klasyfikuj_i_rekomenduj(Rzezba) :-
    losowe_drzewo(Rzezba, Material, Technika, Rzezbiarz, Podobna),
    write('Rzezba: '), write(Rzezba), nl,
    write('Material: '), write(Material), nl,
    write('Technika: '), write(Technika), nl,
    write('Rzezbiarz: '), write(Rzezbiarz), nl,
    write('Podobna rzeüba: '), write(Podobna), nl.
