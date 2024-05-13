## R Code Economics Term Paper 

### Import Libraries
library(AER)
library(ggplot2)
library(jtools)
library(tseries)
library(tidyverse)
library(TSA)
library(fpp2)
library(patchwork)
library(strucchange)
library(fixest)
library(gplots)


### Code for LM Test
lm.test <- function(model){
  N <- length(resid(model))
  J <- length(coef(model))-1
  Statistic <- N*summary(model)$r.squared
  pvalue <- 1- pchisq(Statistic, J)
  tmp <- data.frame(Statistic,pvalue)
  print(tmp)
}

### Chow Tests ###

## Importing Data: 
UnemploymentRate <- read_csv("G:/My Drive/Econ 497/Term Paper/UnemploymentRate.csv")
year <- UnemploymentRate$Year
unemp <- UnemploymentRate$Unemp_Rate
## Chow Test 1 (2006)
sctest(unemp ~ year, type = "Chow", point = 21)

## Chow Test 2 (2007)
sctest(unemp ~ year, type = "Chow", point = 22)

## Chow Test 3 (2008)
sctest(unemp ~ year, type = "Chow", point = 23)

### Modelling ### 

## Importing Data for Modelling
Data6 <- read_csv("G:/My Drive/Econ 497/Term Paper/Data 6/Data6.2.csv")

# Calculating Total Credits
Data6$total_credits <- Data6$Offset + Data6$Performance

### First Considering only a entity based fixed effect model
fit1 <- lm(UnemploymentRate ~ OBPS_Dummy +  factor(Province), data = Data6)
coeftest(fit1,vcov = vcovHC(fit1, type = "HC1"))
coeftest(fit1,vcov = NeweyWest(fit1,lag=2))

fit2 <- lm(UnemploymentRate ~ OBPS_Dummy + log(GDP) + factor(Province), data = Data6)
coeftest(fit2,vcov = vcovHC(fit2, type = "HC1"))
coeftest(fit2,vcov = NeweyWest(fit2,lag=2))

fit3 <- lm(UnemploymentRate ~ OBPS_Dummy + log(GDP) + total_credits + factor(Province), data = Data6)
coeftest(fit3,vcov = vcovHC(fit3, type = "HC1"))
coeftest(fit3,vcov = NeweyWest(fit3,lag=2))

### Now considering a time and entity based model
fit4 <- lm(UnemploymentRate ~ OBPS_Dummy + factor(Province) + factor(Year), data = Data6)
coeftest(fit4,vcov = vcovHC(fit4, type = "HC1"))
coeftest(fit4,vcov = NeweyWest(fit4,lag=2))

fit5 <- lm(UnemploymentRate ~ OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
coeftest(fit5,vcov = vcovHC(fit5, type = "HC1"))
coeftest(fit5,vcov = NeweyWest(fit5,lag=2))

fit6 <- lm(UnemploymentRate ~ OBPS_Dummy + log(GDP) + total_credits + factor(Province) + factor(Year), data = Data6)
coeftest(fit6,vcov = vcovHC(fit6, type = "HC1"))
coeftest(fit6,vcov = NeweyWest(fit6,lag=2))

### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit1))
e <- resid(fit1)[-1]
em1 <- resid(fit1)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit1)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit2))
e <- resid(fit2)[-1]
em1 <- resid(fit2)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit2)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit3))
e <- resid(fit3)[-1]
em1 <- resid(fit3)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit3)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit4))
e <- resid(fit4)[-1]
em1 <- resid(fit4)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit4)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit5))
e <- resid(fit5)[-1]
em1 <- resid(fit5)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit5)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


### Autocorrelation in the error term: 
## Breusch Godfrey Test

nobs <- length(resid(fit6))
e <- resid(fit6)[-1]
em1 <- resid(fit6)[-nobs]
bg.reg <- lm(e ~ em1 + OBPS_Dummy[-1] + log(GDP)[-1] + factor(Province)[-1] + factor(Year)[-1], data = Data6)
lm.test(bg.reg)
## strongly reject the null of no autocorrelation!

### Heteroskedasticity 
# Breusch Pagan Test
e2 <- resid(fit6)^2
bp.reg <- lm(e2 ~OBPS_Dummy + log(GDP) + factor(Province) + factor(Year), data = Data6)
lm.test(bp.reg)
## strongly reject the null of homoskedasticity!


## Heterogeneity Across Provinces
plotmeans(UnemploymentRate ~ Province, data = Data6)


## Heterogenetiy Across Years

plotmeans(UnemploymentRate ~ Year, data = Data6)


## Unemployment Plot
ggplot(data = Data6, aes(x = Year, y= UnemploymentRate, group = Province, color = Province)) + geom_line() + facet_wrap(~ Province) +theme_nice()





