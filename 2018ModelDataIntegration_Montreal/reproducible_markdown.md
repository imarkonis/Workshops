Basics of reproducible research
================

------------------------------------------------------------------------

### Motivation
-   Which is the [problem?](http://journals.plos.org/plosmedicine/article/file?id=10.1371/journal.pmed.0020124&type=printable)
-   How [big is it?](http://www.nature.com/news/1-500-scientists-lift-the-lid-on-reproducibility-1.19970)
-   What is [reproducible research?](http://onlinelibrary.wiley.com/doi/10.1002/2016WR019285/abstract)
-   What if research is [not reproducible?](https://retractionwatch.com/2013/02/01/seizure-study-retracted-after-authors-realize-data-got-terribly-mixed/)

------------------------------------------------------------------------

### Main components of reproducible research

- Data: Easily accessible in [open data repository](https://www.nature.com/sdata/policies/repositories) 
or provide the data from [your own server](https://shiny.fzp.czu.cz/KVHEM/OWDA/).

- Methods: Use [efficient workflow](https://csgillespie.github.io/efficientR/preface.html), [robust directory layout](https://nicercode.github.io/blog/2013-04-05-projects/), [clean code](http://adv-r.had.co.nz/Style.html), and share it with a version control, collaborative platform, such as [github](https://github.com/KVHEM/drought_uncertainty).

- Results: Share results in a dynamic way with [Markdown](http://daringfireball.net/projects/markdown/), [Shiny](https://shiny.rstudio.com/) or [Sharelatex](https://www.sharelatex.com/)/[Googledocs](https://www.google.ca/docs/about/).

To further enhance collaboration you can use [slack](https://www.nature.com/news/how-scientists-use-slack-1.21228) or [Jupyter Notebooks](https://reproducible-science-curriculum.github.io/introduction-RR-Jupyter/docs/slides/Jupyter_Intro_Background.slides.html#/1).

### Pros and cons of the reproducible approach
_Pros_
- Dynamic
- Collaborative
- Archieving
- Increase audience
\n
_Cons_
- Time consuming
- Needs training/coordination

### Examples of successful applications of reproducible research using Markdown
- [LIGO project](https://losc.ligo.org/s/events/GW150914/GW150914_tutorial.html)
- [European drought reconstruction](https://www.fzp.czu.cz/en/r-9409-science-research/r-9674-leading-research-groups/r-9669-hydrological-and-climate-variability/r-9713-team-news/drought-reconstruction-1776-2015.html)


### Markdown

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

-   Allows collaborative science and coding (cloud-computing), and also..



------------------------------------------------------------------------

*Takeaway message: "Sharing methods and data is strength, not a weakness."*

------------------------------------------------------------------------

**Installing R Markdown**

Like the rest of R, R Markdown is free and open source. You can install the R Markdown package from CRAN with:

``` r
#install.packages("jsonlite", type="binary")
#install.packages("base64enc", type="binary")
#install.packages('knitr', dependencies = TRUE)
#install.packages("rmarkdown")   
```

**Create a Markdown & an HTML file**

To create a new markdown file: File/New File/R Markdown...

This is a plain text file that has the extension .Rmd

Notice that the file contains three types of content:

-   A header surrounded by `---`
-   R code surrounded by \`\`\` \[we call them chunks and can create a new one we use the Insert button \[or Ctr+Alt+I\] & discover another strength of Markdown; any ideas??\]
-   text mixed with some simple text formatting

To create an html \[PDF/word\] file, we press the Knit button \[or Ctr+Shift+K\].

------------------------------------------------------------------------

**Markdown formating**

> Following the syntax rules we have seen [here](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf), try to make the following changes to the original rmd file:

-   Change any **bold** formating to *italics*.
-   Create a sub-heading below the original one (Markdown).
-   Replace <http://rmarkdown.rstudio.com> to the phrase "this link", but keep the link.
-   Add the following text \[from "Including..." to "...this"\] in the end of the file:

------------------------------------------------------------------------

#### Including Equations

You can also add equations, such as:

-   *f*(*x*)=*e*<sup>*x*</sup>
-   *f*′(*x*)=*x*<sup>2</sup>(*a*<sub>1</sub> + *a*<sub>2</sub>)
-   *A* = *π**ρ*<sup>2</sup>

To find out how to write greek letters or use complex mathematical formulations check [this](https://en.wikibooks.org/wiki/LaTeX/Mathematics).

------------------------------------------------------------------------

**R scripting**

Each code chunk can be run seperately.

When you knit your .Rmd file, RMarkdown will run all the code chunks and embed their results beneath them.

Remember: *When knitting, Rmarkdown will not use anything outside the code chunks, e.g. other variables created in our workspace.*

> Report some results from the previous lesson.

-   Download and import the dataset \[data\_PRT.csv\].
-   Replace the data frame summary chunk, add the str() command to examine its structure.
-   Replace the plot in the other chunk with the set of histograms you have made in the previous lesson \[transform data to tidy format\].
-   The headings should now be "Data description" and "Empirical distributions".
-   Delete all the irrelevant text.
-   Knit it!

<!-- -->

    ## 'data.frame':    6900 obs. of  5 variables:
    ##  $ ID : Factor w/ 5 levels "HRADISTE","METIKALOV",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ DTM: Factor w/ 1380 levels "1901-01-15","1901-02-15",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ P  : num  88.6 34 129.2 53.8 59.4 ...
    ##  $ T  : num  -8.423 -7.882 0.109 5.723 10.59 ...
    ##  $ RM : num  11.94 9.22 65.61 75.63 35.53 ...

    ##              ID               DTM             P                T          
    ##  HRADISTE     :1380   1901-01-15:   5   Min.   :  0.82   Min.   :-12.880  
    ##  METIKALOV    :1380   1901-02-15:   5   1st Qu.: 31.39   1st Qu.:  0.491  
    ##  PLAVEC       :1380   1901-03-15:   5   Median : 49.94   Median :  7.123  
    ##  STRIBRNE_HORY:1380   1901-04-15:   5   Mean   : 57.64   Mean   :  6.985  
    ##  TUCHORAZ     :1380   1901-05-15:   5   3rd Qu.: 75.66   3rd Qu.: 13.841  
    ##                       1901-06-15:   5   Max.   :432.76   Max.   : 22.429  
    ##                       (Other)   :6870                                     
    ##        RM         
    ##  Min.   :  0.009  
    ##  1st Qu.:  5.710  
    ##  Median : 11.341  
    ##  Mean   : 17.308  
    ##  3rd Qu.: 23.174  
    ##  Max.   :229.532  
    ## 

![](ped_markdown_git_files/figure-markdown_github-ascii_identifiers/histograms-1.png)

------------------------------------------------------------------------

**Pandoc and LaTeX**

During knitting the following things happen:

1.  R Markdown feeds the .Rmd file to [knitr](http://yihui.name/knitr/).
2.  Knitr executes all of the code chunks and creates a new markdown (.md) document.
3.  The markdown file is then processed by [pandoc](http://pandoc.org/) which creates the finished format.

Among the many formats pandoc can convert a the .md file to [LaTeX](http://www.latex-project.org/).

Why to use LaTeX and why [not](https://www.overleaf.com/6258626cgrkxt#/21001967/)? *"LaTeX makes difficult things easy, and easy things very difficult."*

The file that mixes R code chunks and LaTeX has the extension .Rnw.

> Knit the report to a PDF file \[LaTeX format\].

------------------------------------------------------------------------

**Basic chunk options**

With knitr::opts\_chunk$set we can set some global options for our code chunks. The cache option is one of them; R saves the content of each chunk and does not run it as long as it remains unchanged.

Some other options, which can be also used to each code chunk are:

-   echo
-   include
-   message
-   fig.width, fig.height
    -   small: &lt;4
    -   medium: 4-8
    -   big: &gt;8
-   fig.align

------------------------------------------------------------------------

With the `echo` option, we can share our code easily with our collaborators:

``` r
tapply(pr$value, list(pr$ID, month(pr$DTM), pr$variable), mean) #Martin, do you know if tapply() should be used like this? [the results seem ok]
```

    ## , , P
    ## 
    ##                      1        2        3        4        5         6
    ## HRADISTE      43.49113 42.81443 50.60000 64.39939 94.92348 116.93913
    ## METIKALOV     51.55078 44.72887 46.30070 48.00330 63.86157  73.85504
    ## PLAVEC        28.34017 25.62148 28.75296 35.40574 57.67087  68.27096
    ## STRIBRNE_HORY 50.79991 42.59130 45.58617 49.20878 73.46791  82.73078
    ## TUCHORAZ      35.94357 32.02026 38.51878 45.28617 69.95609  82.15678
    ##                       7         8        9       10       11       12
    ## HRADISTE      128.43661 109.70513 71.08191 55.43809 49.36183 48.52122
    ## METIKALOV      79.32861  71.37400 53.82348 50.01713 51.16826 54.32643
    ## PLAVEC         72.17843  63.11383 42.46304 35.24522 34.52861 32.09817
    ## STRIBRNE_HORY  94.25826  84.11809 57.87226 49.29296 49.90783 52.42026
    ## TUCHORAZ       84.30609  76.12661 50.11461 43.89974 39.89000 40.40270
    ## 
    ## , , T
    ## 
    ##                       1          2         3        4        5        6
    ## HRADISTE      -3.668304 -2.5789652 1.3422957 5.885626 10.89711 14.00514
    ## METIKALOV     -4.280678 -3.1907913 0.7783565 5.529626 10.52406 13.76995
    ## PLAVEC        -2.419687 -1.0082522 3.0898087 8.134948 13.06986 16.19507
    ## STRIBRNE_HORY -3.341174 -2.1504870 1.7188522 6.645122 11.71125 14.75129
    ## TUCHORAZ      -2.006443 -0.9090261 3.1436087 8.068174 13.08153 16.19616
    ##                      7        8        9       10        11         12
    ## HRADISTE      15.80772 15.23567 11.61106 6.718235 1.3475043 -2.3716522
    ## METIKALOV     15.53105 14.92232 11.34753 6.114139 0.8488957 -2.8259739
    ## PLAVEC        18.08919 17.56487 13.59557 8.415678 2.9780957 -0.9114522
    ## STRIBRNE_HORY 16.60937 16.12944 12.23282 7.313139 1.9104870 -1.8189565
    ## TUCHORAZ      18.00400 17.41819 13.52738 8.370757 3.0017391 -0.5988087
    ## 
    ## , , RM
    ## 
    ##                       1         2        3         4         5         6
    ## HRADISTE      20.870930 22.178313 36.74675 47.310774 38.730730 37.330148
    ## METIKALOV     17.826539 24.008617 44.94725 36.166591 16.077583 12.077226
    ## PLAVEC         5.417887  8.150713 11.30548  6.857783  6.442165  5.512017
    ## STRIBRNE_HORY 23.068939 28.756226 36.43119 28.099696 21.240948 17.107757
    ## TUCHORAZ      13.047000 15.220270 22.42844 11.380313 11.161774 10.138930
    ##                       7         8         9        10        11        12
    ## HRADISTE      37.454043 31.883826 24.851974 23.865791 24.332322 22.325826
    ## METIKALOV     11.533313  9.912339 10.151539 16.598409 24.705704 20.629652
    ## PLAVEC         4.563278  3.553522  2.786287  2.494096  2.793652  4.057017
    ## STRIBRNE_HORY 14.509496 11.435548  8.608730  9.309913 13.615157 18.414591
    ## TUCHORAZ       8.758922  7.521896  5.925557  6.679174  7.927191 11.221687

------------------------------------------------------------------------

**Tables**

The knitr package also offers another useful function: kable()

For example:

``` r
aa = data.frame(ID = 1:10,  Value = rnorm(10), Type = sample(c('A', 'B', 'C', 'D'), 10, replace = TRUE))
knitr::kable(aa, caption = "A simple table with kable()")
```

|   ID|       Value| Type |
|----:|-----------:|:-----|
|    1|  -0.1690271| D    |
|    2|   0.3764003| D    |
|    3|   0.8883423| C    |
|    4|   1.5897389| C    |
|    5|  -1.0333382| C    |
|    6|  -0.0693501| B    |
|    7|  -0.3748832| A    |
|    8|   0.4624406| A    |
|    9|   0.9013177| B    |
|   10|  -0.4385452| C    |

> Let's try to make a better table.

A new code chunk with a table showing the means of each variable per station.

|                |      P|     T|     RM|
|----------------|------:|-----:|------:|
| HRADISTE       |  72.98|  6.19|  30.66|
| METIKALOV      |  57.36|  5.76|  20.39|
| PLAVEC         |  43.64|  8.07|   5.33|
| STRIBRNE\_HORY |  61.02|  6.81|  19.22|
| TUCHORAZ       |  53.22|  8.11|  10.95|

The function that helps us estimate the means is tapply(). Its syntax is quite simple and we use it often with tidy data:

tapply(val, id, fun) is translated to: *Apply function "fun" to the values "val" of each category "id"*

We can apply the function to more than one identificators by making a list of them, e.g.:

tapply(val, list(id.var1, id.var2, id.var3), fun).

Is there any alternative way to do this?

------------------------------------------------------------------------

**In line text**

It is not necessary to create code chunks to present our results. We can add them by using the \`\`\`'r' some code \`\`\` formulation.

> Add the following text with the results

In terms of precipitation our data have a mean of `57.6435986` with standard deviation `35.1505118` and a maximum of `432.76` at `HRADISTE`.

------------------------------------------------------------------------

The true strength of Rmarkdown is that in this way our report is dynamic. For example, if the Hradiste station is erroneous and should be removed, than we just remove him and re-knit our rmd file:

------------------------------------------------------------------------

In terms of precipitation our data have a mean of `53.8104909` with standard deviation `32.1380494` and a maximum of `276.24` at `STRIBRNE_HORY`.

**Finalizing our work**

We can use the theme option in the header section to specify the theme to use for the page. The theme names are "default", "cerulean", "journal", "flatly", "readable", "spacelab", "united", "cosmo", "lumen", "paper", "sandstone", "simplex", and "yeti". For example:

    ---
    title: "EDA"
    output:
      html_document:
        theme: united
    ---

We can also add a table of contents using the toc option and section numbering to headers using the `number_sections` option. For example:

    ---
    title: "EDA"
    output: 
      html_document:
        toc: true
        number_sections: true
        pandoc_args: 
          ["--number-sections",
          "--number-offset=1"]
    ---

**Sharing our work**

Rmarkdown is fully compatible with dropbox and github. It also provides free its own cloud, [Rpubs.](http://rpubs.com/farofylax/rmarkdown)

Finally, you can see some rmarkdown in action [here](http://rpubs.com/farofylax/221608) \[and provide us some feedback, if you like!\].

------------------------------------------------------------------------

> More resources:

-   [webpage](http://rmarkdown.rstudio.com/)
-   [cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)
-   [even more resources](http://kbroman.org/knitr_knutshell/pages/resources.html)
-   [and always..](https://www.google.cz/search?client=ubuntu&channel=fs&q=r+markdown&ie=utf-8&oe=utf-8&gfe_rd=cr&ei=vk4OWPmPEuik8wfkw5kY)
