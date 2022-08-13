# data load & check
library(MASS)
data("Cars93")
str(Cars93) #structure

# simple lenear regression model 
# enginsie : x, price : y
lm(Price~EngineSize, Cars93)

# model scan : Use summary()
# summary() : 주어진 인자에 대한 요약정보 제공
cars93_model <- lm(Price~EngineSize, Cars93)
summary(cars93_model)

# plot.lm(x,y) : 선형회귀모델 시각화 함수
# x : 선형회귀모형, y : 그래프 종류

# 그래프 배치
par(mfrow = c(2,3))

# 그래프 작성
plot(cars93_model, which = c(1:6))

