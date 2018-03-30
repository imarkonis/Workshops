
Workshop: An introduction to cross-scale variability analyses of the Earth system
====================================================

### by Christoforos Pappas & Yannis Markonis

#### Université de Montréal, Département de géographie 520 ch de la Côte Sainte-Catherine, Room 140, April 4-5, 2018

*Département de géographie and Centre d’études nordiques* *Université de Montréal, Montréal, QC, Canada* <christoforos.pappas@umontreal.ca>

*Department of Water Resources* *Czech University of Life Sciences Prague, Prague, Czech republic* <markonis@fzp.czu.cz>

#### Install/Update R & Rstudio to latest version

https://cran.r-project.org/

https://www.rstudio.com/products/rstudio/download/

#### Download/install packages

``` r
list_of_packages <- c("data.table", "reshape2", "RColorBrewer", "zoo", "ggplot2", 
"scales","RNCEP", "gimms", "ncdf4", "parallel", "longmemo", "HKprocess")

new_packages <- list_of_packages [!(list_of_packages  %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)
lapply(list_of_packages, require, character.only = TRUE) 
```

#### Set working directory and create sub-dirs / load functions

``` r
work_dir <- getwd() 

dir.create("./data")
dir.create("./source")
dir.create("./bin")
dir.create("./results")

download.file("https://raw.githubusercontent.com/imarkonis/Workshops/master/2017StochasticMethods_Prague/scalegram_w.R", 
              "./source/scalegram_w.R", mode = "wb")
source("./source/scalegram_w.R")
```

#### Study period and location setup for NCAP 2 reanalysis dataset

``` r
ncep_raw <- list() #Use list in case time series of different lengths are combined
site_coords = data.frame(lat = 45.5, lon = 286.5) # C'est Montreal
coordinates(site_coords) <- c("lon", "lat")
start_day <- 1
end_day <- 31
start_month <- 1
end_month <- 12
start_year <- 1979
end_year <- 2016

time_as_date = as.POSIXct(seq(ISOdate(start_year, start_month, start_day, 00, 00, tz = "UTC"),
                              ISOdate(end_year, end_month, end_day, 18, 00, tz = "UTC"),
                              "6 h"), tz = "UTC")

start_date = as.Date(head(time_as_date, 1))
end_date = as.Date(tail(time_as_date, 1))
```

#### Hydroclimatic data

**Define which variables should be downloaded**

Variables in reference to a T62 gaussian grid

air.2m is Air Temperature (At 2 meters) deg K

prate.sfc is Precipitation rate (At Surface) Kg/m^2/s

**NCAP 2 Reanalysis Data**

More info about data: <https://www.esrl.noaa.gov/psd/data/gridded/data.ncep.reanalysis2.html>

*ncep\_dload* function returns a three dimensional array of weather data. The three dimensions are latitude, longitude, and datetime reflected in the dimnames of the array. Datetimes are always expressed in UTC with the format "%Y\_%m\_%d\_%H". Optionally, the units of the variable being queried are printed upon completion.

``` r
variables <- c("air.2m", "prate.sfc")
n_variables <- length(variables)

for (j in 1:n_variables){# loop through variables
  ncep_dload <- NCEP.gather(
    variable  = variables[j],
    level = 'gaussian',
    months.minmax = c(start_month, end_month), 
    years.minmax  = c(start_year, end_year), # overall length of the dataset
    lat.southnorth  = c(site_coords@coords[2], site_coords@coords[2]),
    lon.westeast  = c(site_coords@coords[1], site_coords@coords[1]),
    reanalysis2 = TRUE,
    return.units = TRUE,
    status.bar  = TRUE
  )
  # get the mean of the 4 cells (i.e., area)
  ncep_raw[[j]] <- apply(ncep_dload, 3, mean, na.rm=T)
} # end loop through variables
```
``` r
names(ncep_raw) <- c("temperature", "precipitation")
ncep_raw_long <- data.table(melt(ncep_raw))
colnames(ncep_raw_long)[2] <- "variable"

ncep_raw_long[variable == "temperature", value := value - 273]    #Change units from K to C
ncep_raw_long[variable == "precipitation", value := value * 3600 * 6]    #Change units from Kg/m^2/s to mm/6h

ncep_raw_long[, time := rep(time_as_date, n_variables)]
setcolorder(ncep_raw_long, c("variable", "time", "value"))

saveRDS(ncep_raw_long, "./data/montreal_T_P_ncep.rds")
```
------------------------------------------------------------------------

#### Scalegram: a diagnostic tool for cross-scale analysis

``` r
montreal_T_P <- readRDS("./data/montreal_T_P_ncep.rds")
```

Aggregate 6-h time series to monthly time step and estimate empirical scalograms

``` r
montreal_T_P[, month := month(time)]
montreal_T_P[, year := year(time)]
ncep_raw_monthly <- montreal_T_P[variable != "precipitation" , mean(value), list(month, year, variable)]  
ncep_raw_monthly <- rbind(ncep_raw_monthly, montreal_T_P[variable == "precipitation", sum(value), list(month, year,variable)])
names(ncep_raw_monthly)[4] = "value"

#ncep_raw_matrix <- dcast(data = montreal_T_P, time~variable, value.var = "value")   #Transformation for parallel computing
#empirical_scalegrams <- scalegram_parallel(ncep_raw_matrix[-1])

empirical_scalegrams_meteo_6h <- data.table(montreal_T_P[, scalegram_main(value), variable])
empirical_scalegrams_meteo_mon <- data.table(ncep_raw_monthly[, scalegram_main(value), variable])
```

``` r
plot_scalegram(empirical_scalegrams_meteo_6h)
plot_scalegram(empirical_scalegrams_meteo_mon)
```

**Plotting two scalegrams**

``` r
empirical_scalegrams_meteo_mon_6h <- empirical_scalegrams_meteo_mon
empirical_scalegrams_meteo_mon_6h$scale <- empirical_scalegrams_meteo_mon_6h$scale * 120

empirical_scalegrams_meteo_mon_6h$variable <- "Monthly precipitation"
dummy <- empirical_scalegrams_meteo_6h[variable == "precipitation"]
dummy$variable <- "6-h precipitation"

combo_p_plot <- rbind(dummy, empirical_scalegrams_meteo_mon_6h)

plot_scalegram(combo_p_plot)
```

**Rescaling monthly scalegrams to 6h**

``` r
empirical_scalegram_precip_rescaled <- rescale_variance( #Var. of the 6h scalegrams in the monthly scale  
  emp_scalegram_coarse = empirical_scalegrams_meteo_mon[variable == "precipitation"], 
  emp_scalegram_fine = empirical_scalegrams_meteo_6h[variable == "precipitation"],
  scale_ratio = 4 * 30)

empirical_scalegram_precip_rescaled$variable <- "Monthly precipitation"
dummy <- empirical_scalegrams_meteo_6h[variable == "precipitation"]
dummy$variable <- "6-h precipitation"

combo_p_plot <- rbind(dummy, empirical_scalegram_precip_rescaled)

plot_scalegram(combo_p_plot)
```

*Exercise 1: Plot in one scalegram 6-h, daily, monthly and annual scalegrams.*

*Exercise 2 (optional): Can you plot the original variances instead of the standardised ones?*

------------------------------------------------------------------------

#### Model-Observational data comparison

**Comparison between NCAP and station data**

Station data correspond to daily meteorological data for MONTREAL/PIERRE_ELLIOTT_TRUDEA that are downloaded from: <http://climexp.knmi.nl/start.cgi?id=someone@somewhere>

``` r
download.file("http://climexp.knmi.nl/data/pgdcnCA007025250.dat", "./data/montreal_P_ghcn.dat")
montreal_station_prec <- data.table(read.csv("./data/montreal_P_ghcn.dat", sep = "", skip = 21, header = F))
colnames(montreal_station_prec) <- c("year", "month", "day", "value")
montreal_station_prec$variable <- "Daily precipitation"
montreal_station_prec[, time := as.Date(paste0(year, "/", month, "/", day))]

empirical_scalegram_montreal_station <- scalegram_main(montreal_station_prec$value)

empirical_scalegram_montreal_station_rescaled <- rescale_variance(
  emp_scalegram_coarse = empirical_scalegram_montreal_station, 
  emp_scalegram_fine = empirical_scalegrams_meteo_6h[variable == "precipitation"],
  scale_ratio = 4)
```

``` r
dummy_1 <- empirical_scalegrams_meteo_6h[variable == "precipitation"]
dummy_1$variable <- "NCAP"
dummy_2 <- empirical_scalegram_montreal_station_rescaled
dummy_2$variable <- "Station"
compare_scalegrams <- rbind(dummy_1, dummy_2) 

plot_scalegram(compare_scalegrams)
```

**Comparison between NCAP and EOBS data**

CPC data were also downloaded from: <http://climexp.knmi.nl/start.cgi?id=someone@somewhere>

More info about CPC dataset can be found at: <https://www.esrl.noaa.gov/psd/data/gridded/data.unified.daily.conus.html>

``` r
montreal_eobs_prec <- read.csv("./data/montreal_eobs.csv", header = T)

download.file("http://climexp.knmi.nl/data/pgdcnCA007025250.dat", "./data/montreal_P_ghcn.dat")
montreal_station_prec <- data.table(read.csv("./data/montreal_P_ghcn.dat", sep = "", skip = 21, header = F))
colnames(montreal_station_prec) <- c("year", "month", "day", "value")
montreal_station_prec$variable <- "Daily precipitation"
montreal_station_prec[, time := as.Date(paste0(year, "/", month, "/", day))]


empirical_scalegram_montreal_eobs <- scalegram_main(montreal_eobs_prec$value)

empirical_scalegram_montreal_eobs_rescaled <- rescale_variance(
  emp_scalegram_coarse = empirical_scalegram_montreal_eobs, 
  emp_scalegram_fine = empirical_scalegrams_meteo_6h[variable == "precipitation"],
  scale_ratio = 4)
```

``` r
dummy_1 <- empirical_scalegrams_meteo_6h[variable == "precipitation"]
dummy_1$variable <- "NCAP"
dummy_2 <- empirical_scalegram_montreal_eobs_rescaled
dummy_2$variable <- "EOBS"
compare_scalegrams <- rbind(dummy_1, dummy_2) 

plot_scalegram(compare_scalegrams)
```

*Exercise 3: Compare all three precipitation datasets.*

*Exercise 4 (optional): Download the EOBS temperature data from KNMI portal, estimate the scalegram and compare it with NCAP temperature scalegram.*

#### Theoretical scalegrams

Generate time series of simple stochastic processes.

``` r
par(mfrow = c(2,1))

wn_synthetic <- rnorm(n = 1000)
plot.ts(wn_synthetic, main = "White Noise") 
acf(wn_synthetic)  #Each value is independent

ar_synthetic <- arima.sim(model = list(ar = 0.8), n = 1000)
plot.ts(ar_synthetic, main = "Auto Regressive (1)") 
acf(ar_synthetic)  #Each value is dependent in each short range (short-term persistance or short-range dependance)

fgn_synthetic <- simFGN0(n = 1000, H = 0.9)
plot.ts(fgn_synthetic, main = "Fractional Gaussian Noise")
acf(fgn_synthetic)   #Each value is dependent in each long range (Long-term persistance or long-range dependance)
```

*Exercise 5: Generate one time series for each stochastic process, with different parameters than above, and compare their ACFS. Which should be the model parameters (ar and H) so that WN, AR(1) and FGN generate the same process?*

``` r
my_scales <- 1:max(empirical_scalegram_praha_station_rescaled$scale)
my_wn <- data.frame(scale = my_scales, 
                   var_scale = generate_wn(sigma = 1, my_scales), variable = "WN")
my_ar_1 <- data.frame(scale = my_scales, 
                     var_scale = generate_ar_1(sigma = 1, rho = 0.5, my_scales), variable = "AR1")
my_fgn <- data.frame(scale = my_scales, 
                    var_scale = generate_fgn(sigma = 1, rho = 0.5, my_scales), variable = "FGN")

my_harmonic_1 <- data.frame(scale = my_scales, 
                           var_scale = generate_harmonic(period = 4, my_scales), variable = "Daily\nHarmonic")
my_harmonic_1[my_harmonic_1$var_scale < 0.00001, "var_scale"] = 0.00001

my_harmonic_2 <- data.frame(scale = my_scales, 
                           var_scale = generate_harmonic(period = 4*365, my_scales), variable = "Annual\nHarmonic")
my_harmonic_2[my_harmonic_2$var_scale < 0.00001, "var_scale"] = 0.00001

empirical_scalegram_praha_station_rescaled$variable <- "Daily precipitation\nstation"

all_scalegrams = rbind(my_wn, my_ar_1, my_fgn, my_harmonic_1, my_harmonic_2, empirical_scalegram_praha_station_rescaled)

plot_scalegram(all_scalegrams) 
```

*Exercise 6: Apply this procedure for temperature and/or radiation.*

*Exercise 7: Plot the scalegrams for the time series generated in exercise 5.*

------------------------------------------------------------------------

#### Stochastic simulation: Case study annual temperature and precipitation

``` r
praha_station_temp <- data.table(read.csv("./data/praha_station_T.csv", header = T))
praha_station_temp_annual <- praha_station_temp[, mean(value), year]
names(praha_station_temp_annual)[2] <- "temperature"

plot(temperature~year, data <- praha_station_temp_annual, type = 'l')
praha_station_temp_annual_150 <- praha_station_temp_annual[year<1939]

acf(praha_station_temp_annual_150$temperature)
plot(density(praha_station_temp_annual_150$temperature))
```

``` r
empirical_scalegram_praha_station_temp_annual <- scalegram_main(praha_station_temp_annual$temperature)

my_scales <- 1:max(empirical_scalegram_praha_station_temp_annual$scale)
my_wn <- data.frame(scale = my_scales, 
                   var_scale = generate_wn(sigma = 1, my_scales), variable = "WN")
my_ar_1 <- data.frame(scale = my_scales, 
                     var_scale = generate_ar_1(sigma = 1, rho = 0.5, my_scales), variable = "AR1")
my_fgn <- data.frame(scale = my_scales, 
                    var_scale = generate_fgn(sigma = 1, rho = 0.5, my_scales), variable = "FGN")
empirical_scalegram_praha_station_temp_annual$variable = "Annual temperature\nstation"

all_scalegrams <- rbind(my_wn, my_ar_1, my_fgn, empirical_scalegram_praha_station_temp_annual)

plot_scalegram(all_scalegrams) 
```

``` r
acf(praha_station_temp_annual_150$temperature, plot = F)[1]
praha_station_temp_ar <- mlear1(praha_station_temp_annual_150$temperature)
praha_station_temp_fgn <- mleHK(praha_station_temp_annual_150$temperature)
```

``` r
nn <- nrow(praha_station_temp_annual_150)
mc_WN <- replicate(1000, rnorm(n = nn, sd = sd(praha_station_temp_annual_150$temperature)))
mc_AR1 <- replicate(1000, arima.sim(model = list(ar = praha_station_temp_ar["phi_estimate"]), n = nn))
mc_FGN <- replicate(1000, simFGN0(n = nn, H = praha_station_temp_fgn["H_estimate"]))
```

``` r
library(parallel)
mc_WN_scalegrams <- scalegram_parallel(mc_WN)
mc_WN_scalegrams <- melt(mc_WN_scalegrams, id = c("scale", "var_scale"))
colnames(mc_WN_scalegrams)[3] <- "variable"
plot_scalegram(mc_WN_scalegrams) + geom_line(data = scalegram_main(praha_station_temp_annual_150$temperature))

mc_AR1_scalegrams <- scalegram_parallel(mc_AR1)
mc_AR1_scalegrams <- melt(mc_AR1_scalegrams, id = c("scale", "var_scale"))
colnames(mc_AR1_scalegrams)[3] <- "variable"
plot_scalegram(mc_AR1_scalegrams) + geom_line(data = scalegram_main(praha_station_temp_annual_150$temperature))

mc_FGN_scalegrams <- scalegram_parallel(mc_FGN)
mc_FGN_scalegrams <- melt(mc_FGN_scalegrams, id = c("scale", "var_scale"))
colnames(mc_FGN_scalegrams)[3] <- "variable"
plot_scalegram(mc_FGN_scalegrams) + geom_line(data = scalegram_main(praha_station_temp_annual_150$temperature))

mc_WN <- replicate(100, rnorm(1000))
mc_AR1 <- replicate(100, arima.sim(model = list(ar = 0.3), n = 1000))
mc_FGN <- replicate(100, simFGN0(1000, H = 0.9))
```

*Exercise 8: Apply the same procedure for precipitation.*
