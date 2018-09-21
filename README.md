# Lab report template

Document template suitable for use as a latex master-file for lab
reports in University of Turku Department of Future Technologies. 

 * This template is synced with the gitlab template.
 * Works with sharelatex / pdflatex / xelatex

## How to use?

Want to write a lab report? Clone this template.
Kirjoitatko harjoitustyöraporttia? Kloonaa tämä pohja.

Want to fix something in the template? Send a
merge request @ https://gitlab.utu.fi/jmjmak/template-exercise-report
Haluatko korjata jotain alkup. pohjassa? Lähetä
korjauspyyntö @ https://gitlab.utu.fi/jmjmak/template-exercise-report

Relies on utuftlabreport.cls for the document class definitions.

This version should be compatible with xelatex and biblatex
which means that all source files can freely use normal UTF-8 text
without resorting to "legacy hacks".

The utuftlabreport.cls defines a new lab report class, which is based on
the report class. It supports these new named parameters:
 * language: provide a language (finnish,english) as a parameter to change the general document appearance and hyphenation
 * hidechapters: show (false) or hide (true) the chapter/luku text at the beginning of each Chapter
 * includereferences: include reference pages when calculating the total number of pages

## How to learn LaTeX?

Traditionally the best places to learn (La)TeX are probably the manual
pages for each package
 * http://www.ctan.org/ 
 * http://www.ctan.org/tex-archive/info/lshort/english/lshort.pdf
