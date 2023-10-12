# Sales App

##  Development

### Przygotowanie środowiska

1. Otwórz plik `app.R` w programie RStudio (bądź otwórz IDE RStudio i ustaw ścieżkę roboczą w katalogu aplikacji).
2. Zainstaluj bibliotekę `renv` poprzez `install.packages('renv')`.
3. Zainstaluj zależności: `renv::restore(prompt = FALSE)`.

### Uruchomienie aplikacji

1. Otwórz plik `app.R`.
2. Kliknij przycisk `Run App` znajdujący się nad oknem otworzonego skryptu.
3. W celu zatrzymania aplikacji naciśnij przycisk `Stop` w panelu konsoli.

Możesz także uruchomić aplikację z poziomu terminala poprzez `Rscript app.R`.
Aplikacja będzie dostępna pod adresem <http://127.0.0.1:8888/>.

### Dodawanie/Aktualizacja zależności

1. Zainstaluj wymaganą bibliotekę poprzez: `renv::install("nazwa_bilbioteki")`
2. Zapisz stan zależności poprzez: `renv::snapshot(prompt = FALSE)`.
3. Zacommituj plik `renv.lock`.
