# CvCreator

<!-- [![Build Status](https://travis-ci.org/klalumiere/DelayedConstructor.svg?branch=master)](https://travis-ci.org/klalumiere/DelayedConstructor/) -->

Use some LaTeX-like formatted data files to generate a CV in many languages with optional entries. Some sample data files about the author are provided on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData). The name of the data files searched are harcoded and to each name is associated a particular view subclass. This allow to format, for instance, the *skillSummary* section in a different way than the *autodidactTraining* section. The user also needs to associate a language to its data, allowing to change the language of its CV on the fly. The data on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData) have two languages associated to them, **Fr** (french) and **En** (english). Finally, the data can be regrouped into classes. This allow to turn on and off related data on the fly. The classes of the data on the branch [withData](https://github.com/klalumiere/CvCreator/tree/withData) are **research**, **computerScience**, **teaching** and **other**. The output of the CV is in *[soon]* LaTeX and in HTML.

**Basic usage:** `ruby -I lib bin/CvCreator`

**Typical usage (e.g. on branch [withData](https://github.com/klalumiere/CvCreator/tree/withData)):** `ruby -I lib bin/CvCreator data En research computerScience teaching other`

<!-- To be compile, this CV should use the included style-sheet "resume2.cls". There's also a html view available, with a program cvMakerOnline.rb that uses Sinatra and an index.html to serve the CV online. -->
