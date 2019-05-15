# LaTeX Workshop, 2018

Files for the UW--Madison Political Science workshop on LaTeX (2018).


## Using this repository

Download the repository as a `.zip` file or clone using `git`. 


### Introductory Slides

The introductory slideshow (in folder `intro-slides`) is an `html` file. It needs the accompanying `.css` file to make it pretty, so best not to move the `html` file from its home directory.


### Example Documents

Example documents include `tex` files and `pdf` files. The `tex` files are used to build the `pdf`s. If you want to modify the `tex` files, save new versions (perhaps in a different folder) before you re-compile them.

If example documents are in the same directory as a folder that contains images (e.g. a folder called `imgs`), then this folder *must* be present, or compilation will fail. This means if you want to copy a source file into another folder to play with it, you need to copy the image folder as well. 




### Directory

Folders contain various documents. 

Week 1

- `intro-slides`: my slides from day 1. You don't really need to mess with these. 
- `handout`: a detailed document describing many LaTeX commands. 
- `mgd-template`: an empty document featuring many of my most-used packages and settings


Week 2

- `workflow`: A mock project directory discussing how to integrate LaTeX into a social science workflow, focusing on integration with statistical software and bibliographies
- `tikz`: how to draw charts and game trees in LaTeX (using `tikz`)
- `beamer`: making slideshows with LaTeX
- `R-markdown`: similar to `workflow`, but with R-Markdown
- `xaringan`: Rmd-based slideshows (IMO superior to Beamer)


### Mock "project" directories

This repository contains two simulated project directories in the `workflow` and `r-markdown` folders. Each "project" has its own data, analysis code, writing, bibliography files. They both use accomplish similar tasks and use similar analysis code, but the former is designed to demonstrate LaTeX while the latter is for demonstrating R Markdown. For the full *project experience*, execute any `.R` code before compiling `.tex` the written documents.


### Other files

The `.gitignore` is a tool that I (Mike) use to manage this Git repository.  

Any `.here` and `.Rproj` files are for managing projects in R/RStudio. 



## Acknowledgments 

Materials in this repository are heavily influenced by past years' workshops and material created by Dave Ohls, Brad Jones, Sarah Bouchat, Nat Olin, Richard Loeza, José Luis Enríquez Chiñas, and Michael Masterson.
