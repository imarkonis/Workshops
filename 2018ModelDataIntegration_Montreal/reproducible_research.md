Basics of reproducible research
================

------------------------------------------------------------------------

### Motivation
-   Which is the [problem?](http://journals.plos.org/plosmedicine/article/file?id=10.1371/journal.pmed.0020124&type=printable)
-   How [big is it?](http://www.nature.com/news/1-500-scientists-lift-the-lid-on-reproducibility-1.19970)
-   What is [reproducible research?](https://agupubs.onlinelibrary.wiley.com/doi/10.1002/2015EA000136%4010.1002/%28ISSN%292333-5084.GPF1)
-   What if research is [not reproducible?](https://retractionwatch.com/2013/02/01/seizure-study-retracted-after-authors-realize-data-got-terribly-mixed/)
-   How R can improve [reproducibility?](https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2012EO160003)

------------------------------------------------------------------------

### Main components of reproducible research

####Data 

Easily accessible in [open data repository](https://www.nature.com/sdata/policies/repositories) 
or provide the data from [your own server](https://shiny.fzp.czu.cz/KVHEM/OWDA/).

  + Raw data should be considered read-only and stored seperately.
  + If possible, keep the names of local files downloaded from the internet or copied onto your computer unchanged.
  + Exception: names should be as much as representative as possible.
  + Use plain text as much as possible.
  + Make data cleaning as easy and effective as possible; [tidy format](http://vita.had.co.nz/papers/tidy-data.pdf).
  + Create a script that can automatically generate clean data from the raw data.

####Methods

Use [efficient workflow](https://csgillespie.github.io/efficientR/preface.html), [robust directory layout](https://nicercode.github.io/blog/2013-04-05-projects/), [clean code](http://adv-r.had.co.nz/Style.html), and share it with a version control, collaborative platform, such as [github](https://github.com/KVHEM/drought_uncertainty).
 
  + Use Readme files.
  + Maintain a consistent folder structure across projects.
  + Have a consistent coding style.
  + Reduce copy-pasting code as much as possible.
  + Break code into small, discrete pieces. Ideally, each script file should do one thing.
  + Separate function definition and application
  + Try not to save your R environments. Try not to load them either. 
  + Organize and name files so that they make intuitive sense to your future self, and follow the narrative of the data analysis.
  + Comment a lot, but avoid redundant comments by smart use of naming.
  + Again, names should be as much as representative as possible.
  
####Results

Share results in a dynamic way with [Markdown](http://daringfireball.net/projects/markdown/), [Shiny](https://shiny.rstudio.com/) or [Sharelatex](https://www.sharelatex.com/)/[Googledocs](https://www.google.ca/docs/about/).

  + Results should be kept in a seperate folder. 
  + Treat generated output as disposable
  + Documentation is important, because  is the key to communicating your workflow and findings with your future self, collaborators, peers, and the general public.
  + Guess what: names should be as much as representative as possible.
  
> Remember that publishing is not the end of your research, but a way station towards your future analyses and the future analyses of others.

To further enhance collaboration you can use [slack](https://www.nature.com/news/how-scientists-use-slack-1.21228).

### Pros and cons of the reproducible approach

_Pros_

- Dynamic
- Collaborative
- Archieving
- Facilitates [peer review](https://ciencias.ulisboa.pt/sites/default/files/fcul/outros/A%20Letter%20from%20the%20Frustrated%20Author%20of%20a%20Journal%20paper.pdf)
- Increase audience  

_Cons_

- Time consuming (at first place)
- Needs training/coordination
- Most of us are afraid of errors

### A short introduction to Markdown

**What is Markdown?**

"Markdown is a text-to-HTML conversion tool for web writers." *Source: [Markdown Web page](http://daringfireball.net/projects/markdown/)*

**Why Markdown has become so popular?**

Because...

1.  it is easy. To beign with all you need to learn is just the first [page](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf).
2.  it is fast and clean; you make less mistakes -&gt; increases efficiency. Here is an [example](https://en.wikipedia.org/wiki/Markdown).
3.  it is portable; your documents can be edited in any text application on any operating system.
4.  it is flexible;
    -   many other platforms/languages are using it, e.g. Dropbox, Github and of course R.
    -   variety in applications (e.g. emails, webpages, presentations, even books!)

**So, why R Markdown?**

------------------------------------------------------------------------

### R Markdown

R Markdown has some significant strengths:

-   Supports many formats (HTML, PDF, Word), which..
-   Helps us present/teach a specific method in R, which..
-   Allows collaborative science and coding (cloud-computing).

------------------------------------------------------------------------

### Examples of successful applications of reproducible research using Markdown

- [LIGO project](https://losc.ligo.org/s/events/GW150914/GW150914_tutorial.html)
- [European drought reconstruction](https://www.fzp.czu.cz/en/r-9409-science-research/r-9674-leading-research-groups/r-9669-hydrological-and-climate-variability/r-9713-team-news/drought-reconstruction-1776-2015.html)

###  More resources:

-   [more examples on reproducibility](https://github.com/Reproducible-Science-Curriculum/introduction-RR-Jupyter/blob/gh-pages/notebooks/Intro-to-reproducible-research.ipynb)
-   [data & project organization](https://reproducible-science-curriculum.github.io/organization-RR-Jupyter/aio.html)
-   [reproducible research and Jupyter notebooks](https://reproducible-science-curriculum.github.io/workshop-RR-Jupyter/)
-   [RMarkdown tutorial](https://github.com/imarkonis/rmarkdown/blob/master/ped_markdown_git.md)
-   [best practices in writing R code](https://swcarpentry.github.io/r-novice-inflammation/06-best-practices-R/)
-   [and always..](https://www.google.cz/search?client=ubuntu&channel=fs&q=r+markdown&ie=utf-8&oe=utf-8&gfe_rd=cr&ei=vk4OWPmPEuik8wfkw5kY)
