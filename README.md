# Projekt "Rzeźbiarstwo"

Autorzy: 
* Filip Maksymiuk   (alb. 169458)
* Jakub Żakowski    (alb. 169543)

## Funkcjonalność:

- Wczytywanie rzeźb z pliku CSV
- Generowanie losowych rzeźb
- Wypisywanie podanej kolumny
- Wypisywanie unikalnych wartości z podanej kolumny
- Wypisywanie podanego wiersza
- Wyszukiwanie rzeźb według wartości w podanej kolumnie
### użycie:

- Aby wygenerować losową rzeźbę, użyj predykatu generate_random_sculpture(SculptureName). Zastąp SculptureName pożądaną nazwą rzeźby.
- Aby wypisać podaną kolumnę, użyj predykatu print_column(ColumnHeader). Zastąp - ColumnHeader nazwą kolumny, np. 'Material' lub 'Kolor'.
- Aby wypisać unikalne wartości z podanej kolumny, użyj predykatu print_unique_column_values(ColumnHeader). Zastąp ColumnHeader nazwą kolumny, np. 'Material' lub 'Kolor'.
- Aby wypisać podany wiersz, użyj predykatu print_row(Index). Zastąp Index indeksem wiersza, np. 1 lub 5.
- Aby wyszukać rzeźby według wartości w podanej kolumnie, użyj predykatu search_sculptures_by_column(ColumnHeader, Value). Zastąp ColumnHeader nazwą kolumny, np. 'Kolor' lub 'Material', a Value pożądaną wartością.
### Przykładowe zapytania:

* ?- generate_random_sculpture('Losowa rzeźba1').
* ?- print_column('Material').
* ?- print_unique_column_values('Kolor').
* ?- print_row(1).
* ?- search_sculptures_by_column('Kolor', 'Bialy').
* ?- search_sculptures_by_column('Material', 'Marmur').
