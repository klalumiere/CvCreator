# CvCreator

[![Build Status](https://github.com/klalumiere/CvCreator/workflows/Continuous%20Integration%20Workflow/badge.svg?branch=master)](https://github.com/klalumiere/CvCreator/actions)

Use some LaTeX-like formatted data files to generate a CV in many languages with optional entries. Some sample data files about the author are provided on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData). The name of the data files searched are harcoded and to each name is associated a particular view subclass. This allow to format, for instance, the *Skill Summary* section in a different way than the *Autodidact Training* section.

The user needs to associate a language to its data, allowing to change the language of its CV on the fly. The data on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData) have two languages associated to them, **Fr** (french) and **En** (english).

Finally, the data can be regrouped into classes. This allow to turn on and off related data on the fly. The classes of the data on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData) are **research**, **computerScience**, **teaching** and **other**.

The output of the CV can be in LaTeX or in HTML. The third party package **resume2.cls** is required to compile the LaTeX output, and it is provided in [build/resume2.cls](https://github.com/klalumiere/CvCreator/blob/master/build/resume2.cls).

**Basic usage:** `./run.sh`

**Typical usage (e.g. on branch [withData](https://github.com/klalumiere/CvCreator/tree/withData)):** `./run.sh TexView data En research computerScience teaching other > build/result.tex`

**Web interface:** A web interface is available and has been deployed on [Heroku](https://www.heroku.com/) at [http://fierce-hamlet-5053.herokuapp.com/](http://fierce-hamlet-5053.herokuapp.com/). The data are those of the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData).
