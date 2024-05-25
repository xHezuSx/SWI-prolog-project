%potestowac, ten projekt jako plan b

:- use_module(library(random)).
:- use_module(library(lists)).

% Fakty o rze�bach
typ_rzezby(dawid, renesans).
typ_rzezby(wenus_z_milo, starozytna_grecja).
typ_rzezby(mysliciel, nowozytny).
typ_rzezby(moai, starozytna_polinezja).
typ_rzezby(pieta, renesans).

typ_rzezby(david2, renesans).
typ_rzezby(afrodyta, starozytna_grecja).
typ_rzezby(architekt, nowozytny).
typ_rzezby(tikis, starozytna_polinezja).
typ_rzezby(pastor, renesans).

% Fakty o materialach
material(renesans, marmur).
material(starozytna_grecja, marmur).
material(nowozytny, braz).
material(starozytna_polinezja, kamien).

material(renesans, drewno).
material(starozytna_grecja, bronz).
material(nowozytny, stal).
material(starozytna_polinezja, glina).

% Fakty o technikach
technika(renesans, dlutowanie).
technika(starozytna_grecja, dlutowanie).
technika(nowozytny, odlewanie).
technika(starozytna_polinezja, rzezba).

technika(renesans, rzezba).
technika(starozytna_grecja, rzezba).
technika(nowozytny, malowanie).
technika(starozytna_polinezja, malowanie).

% Fakty o rze�biarzach
rzezbiarz(michelangelo, dawid).
rzezbiarz(michelangelo, pieta).
rzezbiarz(rodin, mysliciel).
rzezbiarz(nieznany, wenus_z_milo).
rzezbiarz(nieznany, moai).

rzezbiarz(leonardo, david2).
rzezbiarz(apelles, afrodyta).
rzezbiarz(brunelleschi, architekt).
rzezbiarz(kalua, tikis).
rzezbiarz(bok, pastor).

% Fakty o cenach rze�b
cena(dawid, 1000).
cena(wenus_z_milo, 500).
cena(mysliciel, 800).
cena(moai, 1200).
cena(pieta, 900).

cena(david2, 1500).
cena(afrodyta, 600).
cena(architekt, 1000).
cena(tikis, 1100).
cena(pastor, 950).


% Fakty o podobnych rze�bach
podobne_rzezby(dawid, [pieta, mysliciel, wenus_z_milo]).
podobne_rzezby(wenus_z_milo, [mysliciel, dawid, moai]).
podobne_rzezby(mysliciel, [moai, dawid, wenus_z_milo]).
podobne_rzezby(pieta, [dawid, mysliciel, moai]).
podobne_rzezby(moai, [wenus_z_milo, mysliciel, dawid]).


% Przyk�adowe drzewa decyzyjne (symulowane)
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

% Wyb�r losowego drzewa i zastosowanie go
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
    write('Podobna rze�ba: '), write(Podobna), nl.

% Inicjacja zapytania o klasyfikacj� z losowym drzewem
klasyfikuj_i_rekomenduj(Rzezba) :-
    losowe_drzewo(Rzezba, Material, Technika, Rzezbiarz, Podobna),
    write('Rzezba: '), write(Rzezba), nl,
    write('Material: '), write(Material), nl,
    write('Technika: '), write(Technika), nl,
    write('Rzezbiarz: '), write(Rzezbiarz), nl,
    write('Podobna rze�ba: '), write(Podobna), nl.





% ------- regu�y podstawowe ---------


% Znajd� rze�by wykonane w konkretnej technice przez okre�lonego
% rze�biarza

rzezby_rzezbiarza_w_technice(Rzezbiarz, Technika, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), typ_rzezby(Rzezba, Typ), technika(Typ, Technika)), Rzezby).


%Znajd� rze�by wykonane z danego materia�u przez okre�lonego rze�biarza
rzezby_rzezbiarza_z_materialu(Rzezbiarz, Material, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), typ_rzezby(Rzezba, Typ), material(Typ, Material)), Rzezby).


%Znajd� rze�by podobne do danej, ale wykonane w innej technice: popraw

podobne_rzezby_w_innej_technice(Rzezba, Technika, Podobne) :-
    podobne_rzezby_do(Rzezba, Podobne),
    findall(RzezbaInnaTechnika,
            (member(RzezbaInnaTechnika, Podobne),
             typ_rzezby(RzezbaInnaTechnika, Typ),
             technika(Typ, InnaTechnika),
             dif(Technika, InnaTechnika)),
            PodobneInnejTechniki).









% ---------------Regu�y dla wy�wietlania poszczeg�lnych informacji------
% Znajd� wszystkie rze�by wraz z danymi dotycz�cymi ich
% autora, techniki wykonania, materia�u, ceny itp.
wszystkie_rzezby_z_danymi(RzezbyZDanymi) :-
    findall(Rzezba-Dane, rzezba_z_danymi(Rzezba, Dane), RzezbyZDanymi).

% Predykat pomocniczy do zbierania danych o rze�bach
rzezba_z_danymi(Rzezba, Dane) :-
    typ_rzezby(Rzezba, Styl),
    material(Styl, Material),
    technika(Styl, Technika),
    cena(Rzezba, Cena),
    rzezbiarz(Autor, Rzezba),
    Dane = [Styl, Material, Technika, Cena, Autor].

% Znajd� wszystkich autor�w rze�b wraz z ich rze�bami, technikami wykonania, materia�ami, cenami itp.
wszyscy_autorzy_rzezb_z_danymi(AutorzyZDanymi) :-
    findall(Autor-Rzezby, autor_rzezb_z_danymi(Autor, Rzezby), AutorzyZDanymi).

% Predykat pomocniczy do zbierania danych o autorach rze�b
autor_rzezb_z_danymi(Autor, RzezbyZDanymi) :-
    rzezbiarz(Autor, _),
    rzezby_rzezbiarza(Autor, Rzezby),
    maplist(rzezba_z_danymi, Rzezby, RzezbyZDanymi).










% --------------Regu�y dla nazwy rze�by ---------------------


% Po wpisaniu imienia rze�biarza, oraz dopisaniu zmiennej otrzymujemy
% nazwy rze�b tego rzezbiarza
rzezby_rzezbiarza(Rzezbiarz, Rzezby) :-
    findall(Rzezba, rzezbiarz(Rzezbiarz, Rzezba), Rzezby).



% Po wpisaniu techniki w jakiej zostala wykonana rzezbia, oraz
% dopisaniu zmiennej otrzymujemy rzezby wykonane za pomoc� podanej
% techniki
rzezby_w_technice(Technika, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Typ), technika(Typ, Technika)), Rzezby).


% Po wpisaniu materialu z jakiego rzezba zostala wykonana, oraz
% dopisaniu zmiennej otrzymujemy nazwy rze�b zrobionych z tego materia�u
rzezby_z_materialu(Material, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Typ), material(Typ, Material)), Rzezby).


% Po wpisaniu nazwy rzezby, oraz dopisaniu zmiennej otrzymujemypodobne rzezby do podanej
podobne_rzezby_do(Rzezba, Podobne) :-
    podobne_rzezby(Rzezba, Podobne).



%--- okres---

rzezby_w_okresie_rzezbiarza(Okres, Rzezbiarz, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Okres), rzezbiarz(Rzezbiarz, Rzezba)), Rzezby).


rzezby_w_okresie_w_technice(Okres, Technika, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Okres), technika(Okres, Technika)), Rzezby).

rzezby_w_okresie_z_materialu(Okres, Material, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Okres), material(Okres, Material)), Rzezby).



%------reguly dla autorow-----
%Znajd� rze�by wykonane przez okre�lonego rze�biarza w danej technice:

rzezby_rzezbiarza_w_technice(Rzezbiarz, Technika, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), typ_rzezby(Rzezba, Typ), technika(Typ, Technika)), Rzezby).



%Znajd� rze�by wykonane przez okre�lonego rze�biarza z danego materia�u:
rzezby_rzezbiarza_z_materialu(Rzezbiarz, Material, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), typ_rzezby(Rzezba, Typ), material(Typ, Material)), Rzezby).




%Znajd� wszystkie rze�by wykonane przez okre�lonego rze�biarza:
wszystkie_rzezby_rzezbiarza(Rzezbiarz, Rzezby) :-
    findall(Rzezba, rzezbiarz(Rzezbiarz, Rzezba), Rzezby).

%Znajd� rze�by wykonane przez okre�lonego rze�biarza i w okre�lonym stylu:
rzezby_rzezbiarza_w_stylu(Rzezbiarz, Styl, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), typ_rzezby(Rzezba, Styl)), Rzezby).


%Znajd� rze�by wykonane przez okre�lonego rze�biarza i w danym przedziale cenowym:
rzezby_rzezbiarza_w_przedziale_cenowym(Rzezbiarz, CenaMin, CenaMax, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), cena(Rzezba, CenaRzezby), CenaRzezby >= CenaMin, CenaRzezby =< CenaMax), Rzezby).






% --------------regu�y z cenami---------------------


% Znajd� rze�by w cenie mniejszej ni� podana
rzezby_w_cenie_mniejszej_niz(Cena, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, _), cena(Rzezba, CenaRzezby), CenaRzezby < Cena), Rzezby).

% Znajd� rze�by w cenie wi�kszej ni� podana
rzezby_w_cenie_wiekszej_niz(Cena, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, _), cena(Rzezba, CenaRzezby), CenaRzezby > Cena), Rzezby).

% Znajd� rze�by w cenie r�wniej podanej
rzezby_w_cenie_rownej(Cena, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, _), cena(Rzezba, CenaRzezby), CenaRzezby = Cena), Rzezby).

% Znajd� rze�by wykonane w okre�lonym stylu w okre�lonej cenie
rzezby_w_stylu_i_cenie(Styl, Cena, Rzezby) :-
    findall(Rzezba, (typ_rzezby(Rzezba, Styl), cena(Rzezba, CenaRzezby), CenaRzezby = Cena), Rzezby).

% Znajd� rze�by wykonane przez okre�lonego rze�biarza w okre�lonej cenie
rzezby_rzezbiarza_w_cenie(Rzezbiarz, Cena, Rzezby) :-
    rzezby_rzezbiarza(Rzezbiarz, RzezbyRzezbiarza),
    findall(Rzezba, (member(Rzezba, RzezbyRzezbiarza), cena(Rzezba, CenaRzezby), CenaRzezby = Cena), Rzezby).


