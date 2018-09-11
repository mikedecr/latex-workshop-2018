# LaTeX Workshop, 2018

Files for the UW--Madison Political Science workshop on LaTeX (2018).


## Using this repository

Download the repository as a `.zip` file or clone using `git`. 

##  Slides

The introductory slideshow is an `html` file. It needs the accompanying `.css` file to make it pretty, so best not to move the `html` file from its home directory.

## Example Documents

Example documents include `tex` files and `pdf` files. The `tex` files are used to build the `pdf`s. If you want to modify the `tex` files, save new versions (perhaps in a different folder) before you re-compile them.

If example documents are in the same directory as a folder that contains images (e.g. a folder called `imgs`), then this folder *must* be present, or compilation will fail. This means if you want to copy a source file into another folder to play with it, you need to copy the image folder as well. 

## Other files

The `.gitignore` and `readme` files are not essential for end-users. They are merely tools that I (Mike) use to manage this Github repository.  


## Directory

Description of these documents:

- `slides`: slideshows from day 1
- `handout`: a detailed document describing many LaTeX commands
- `mgd-preamble`: an empty document featuring many of my most-used packages and settings
- `bib`: slideshow and example documents about bibliographies
- `tikz`: a document describing ways to draw charts in LaTeX
- `beamer`: a slideshow about slideshows (meta)
- `workflow`: A mock project directory discussing how to integrate LaTeX, Stata, and/or R into the social science workflow