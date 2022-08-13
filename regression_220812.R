# load data
library(MASS)
str(Cars93)

# multiple regression model 
price_lm <- lm(Price~EngineSize + RPM + Weight, Cars93)
summary(price_lm)
