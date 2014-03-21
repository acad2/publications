Poster Design Patterns
======================

A poster describing the 23 designpatterns documented by the "Gang of Four (GoF)"

The UML diagrams are described using a fileformat defined by `umlet`

Building
--------

You need to install umlet in order to convert the `.uxf` into `.pdf` files containing the UML diagrams and a LaTeX editor to generate the resulting `.pdf`:
```
sudo apt-get install umlet texlive-full
```

Furthermore there is a `Makefile` that takes care of the entire process. In order to build the poster, run:
```
make
```

License
-------
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Poster Design Patterns</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/KommuSoft/publications/tree/master/poster_design_patterns" property="cc:attributionName" rel="cc:attributionURL">Willem Van Onsem</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
