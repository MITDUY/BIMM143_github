# Class05: Data visualization with ggplot
Yi-Hung Lee (PID: A16587141)

- [ggplot introduction](#ggplot-introduction)
- [A more complicated scatter plot](#a-more-complicated-scatter-plot)
- [Exploring the gapminder dataset](#exploring-the-gapminder-dataset)
- [Animation](#animation)
- [Happy Cat](#happy-cat)

## ggplot introduction

Today we will have our first play with the **ggplot2** package - one of
the most popular graphics packages on the planet.

There are many plotting systems in R. These include so-called *“base”*
plot/graphs.

Base plot is generally rather short code and dull plots - but it is
always for you and is fast for big dataset.

``` r
plot(cars)
```

![](class05_files/figure-commonmark/unnamed-chunk-1-1.png)

Try ggplot: Need to install **ggplot** package, use function
`install.packages()`. Already installed.

Every time I want to use a package, I need to call the library by
function `library(ggplot2)`

``` r
library(ggplot2)

ggplot(cars)
```

![](class05_files/figure-commonmark/unnamed-chunk-2-1.png)

Every **ggplot** has at least 3 things:

- **data**: the data. frame with the data you want to plot
- **aes**: the aesthetic mapping of the data to the plot
- **geom**: how do you want the plot to look

``` r
ggplot(cars) +
  aes(x=speed, y=dist)
```

![](class05_files/figure-commonmark/unnamed-chunk-3-1.png)

``` r
ggplot(cars) +
  aes(x = speed, y = dist) +
  geom_point()
```

![](class05_files/figure-commonmark/unnamed-chunk-4-1.png)

``` r
ggplot(cars) +
  aes(x = speed, y = dist) +
  geom_point() +
  geom_smooth()
```

    `geom_smooth()` using method = 'loess' and formula = 'y ~ x'

![](class05_files/figure-commonmark/unnamed-chunk-5-1.png)

``` r
ggplot(cars) +
  aes(x = speed, y = dist) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE )
```

    `geom_smooth()` using formula = 'y ~ x'

![](class05_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
bp <- ggplot(cars) +
  aes(x = speed, y = dist) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE )+
  labs(title = "Speed and stopping distance of cars",
      x = "Speed (MPH)", 
      y = "Stopping distance (ft)",
      subtitle = "MIT DUYYYYY",
      caption = "Dataset = 'cars'") +
  theme_bw()

bp
```

    `geom_smooth()` using formula = 'y ~ x'

![](class05_files/figure-commonmark/unnamed-chunk-7-1.png)

## A more complicated scatter plot

Here we make a plot of gene expression data:

``` r
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
```

            Gene Condition1 Condition2      State
    1      A4GNT -3.6808610 -3.4401355 unchanging
    2       AAAS  4.5479580  4.3864126 unchanging
    3      AASDH  3.7190695  3.4787276 unchanging
    4       AATF  5.0784720  5.0151916 unchanging
    5       AATK  0.4711421  0.5598642 unchanging
    6 AB015752.4 -3.6808610 -3.5921390 unchanging

``` r
nrow(genes)
```

    [1] 5196

``` r
colnames(genes)
```

    [1] "Gene"       "Condition1" "Condition2" "State"     

``` r
ncol(genes)
```

    [1] 4

``` r
table(genes$State)
```


          down unchanging         up 
            72       4997        127 

``` r
round(table(genes$State == 'up' )/nrow(genes) * 100, 2 )
```


    FALSE  TRUE 
    97.56  2.44 

``` r
n.gene <- nrow(genes)
n.up <- sum(genes$State == 'up')

up.percent <- n.up/n.gene *100
round(up.percent, 2)
```

    [1] 2.44

``` r
n <- 
  ggplot(genes) +
  aes(x = Condition1, y = Condition2) +
  geom_point()

n
```

![](class05_files/figure-commonmark/unnamed-chunk-11-1.png)

``` r
gene_plot <- n + aes(col = State)

gene_plot
```

![](class05_files/figure-commonmark/unnamed-chunk-12-1.png)

``` r
gene_plot + scale_color_manual(values = c("blue", "gray", "red")) +
  labs(x = "Control(no drug)", y = "Drug Treatment", title = "Gene Expression Changing Upon Drug Treatment")
```

![](class05_files/figure-commonmark/unnamed-chunk-13-1.png)

## Exploring the gapminder dataset

``` r
library(gapminder)
# File location online
url <- "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"
gapminder <- read.delim(url)
```

``` r
head(gapminder)
```

          country continent year lifeExp      pop gdpPercap
    1 Afghanistan      Asia 1952  28.801  8425333  779.4453
    2 Afghanistan      Asia 1957  30.332  9240934  820.8530
    3 Afghanistan      Asia 1962  31.997 10267083  853.1007
    4 Afghanistan      Asia 1967  34.020 11537966  836.1971
    5 Afghanistan      Asia 1972  36.088 13079460  739.9811
    6 Afghanistan      Asia 1977  38.438 14880372  786.1134

> Q. How many continent are there? Use function `unique()`

``` r
num <- unique(gapminder$continent)
length(num)
```

    [1] 5

> Q. How many countries are there?

``` r
num <- unique(gapminder$country)
length(num)
```

    [1] 142

``` r
library(dplyr)
```


    Attaching package: 'dplyr'

    The following objects are masked from 'package:stats':

        filter, lag

    The following objects are masked from 'package:base':

        intersect, setdiff, setequal, union

``` r
gapminder_2007 <- gapminder %>% filter(year==2007)
head(gapminder_2007)
```

          country continent year lifeExp      pop  gdpPercap
    1 Afghanistan      Asia 2007  43.828 31889923   974.5803
    2     Albania    Europe 2007  76.423  3600523  5937.0295
    3     Algeria    Africa 2007  72.301 33333216  6223.3675
    4      Angola    Africa 2007  42.731 12420476  4797.2313
    5   Argentina  Americas 2007  75.320 40301927 12779.3796
    6   Australia   Oceania 2007  81.235 20434176 34435.3674

``` r
library(ggplot2)
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp) +
  geom_point(alpha=0.5)
```

![](class05_files/figure-commonmark/unnamed-chunk-19-1.png)

``` r
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop) +
  geom_point(alpha=0.5)
```

![](class05_files/figure-commonmark/unnamed-chunk-20-1.png)

``` r
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = pop) +
  geom_point(alpha=0.7)
```

![](class05_files/figure-commonmark/unnamed-chunk-21-1.png)

> Q. How to reflect the real population on the size of the points

``` r
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop), alpha=0.5) + 
  scale_size_area(max_size = 10)
```

![](class05_files/figure-commonmark/unnamed-chunk-22-1.png)

> Q. Can you adapt the code you have learned thus far to reproduce our
> gapminder scatter plot for the year 1957? What do you notice about
> this plot is it easy to compare with the one for 2007?

``` r
gapminder_1957 <- gapminder %>% filter(year == 2007 | year==1957)
ggplot(gapminder_1957) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop) +
  geom_point() + 
  scale_size_area(max_size = 10) +
  facet_wrap(~year)
```

![](class05_files/figure-commonmark/unnamed-chunk-23-1.png)

## Animation

``` r
library(gapminder)
library(gganimate)
# Setup nice regular ggplot of the gapminder data
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  # Facet by continent
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  shadow_wake(wake_length = 0.1, alpha = FALSE)
```

![](class05_files/figure-commonmark/unnamed-chunk-24-1.gif)

# Happy Cat

![](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcXdsaGI1aHp5ZzhqMjBnY2drcXpqd3N3d3F1OTQxem5zOTcxbDl6diZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gVsmn4qdyBn1Bra2tN/giphy-downsized-large.gif)
