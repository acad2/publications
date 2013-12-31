Poster Automaten en Berekenbaarheid
===================================
A poster on automata and computability in Dutch based on the *KU Leuven* course of prof. dr. B. Demoen.

One can build the poster by calling the make command:
```
make
```
Building the poster requires `pdflatex` and `qrencode`. One better installs `texlive-full` as well (since
the poster requires some packages).

It is possible that the poster cannot be generated on a Windows system since that operating system uses `\r\n` to denote a newline.

`make upload` is only used by the author to upload the poster to a webserver.
