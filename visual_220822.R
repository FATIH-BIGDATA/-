# load data

setwd("C:/Users/phc07/Desktop/dataHC/01_bigdata/03_BigdataEngineer")
route <- getwd()

traffic <- read.csv(file.path(route, 'traffic.csv'))
traffic

jung <- subset(traffic, 
               자치구명 == '중구' & 연도 == 2015)
jung

tra15 <- subset(traffic, 
               월 == 12 & 연도 == 2015)
tra15


# libraries
library(ggplot2)

# bar plot
bar <- ggplot(data =jung, aes(x = 월, y = 발생건수)) +
  geom_bar(stat = 'identity', color = 'red', fill = 'orange') +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015년 서울 중구의 월별 교통사고 발생 동향")

bar

# scatter plot
scat <- ggplot(data =jung, aes(x = 월, y = 발생건수)) +
  geom_point(aes(x = 월, y = 발생건수)) +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015년 서울 중구의 월별 교통사고 발생 동향")

scat

# line 

line <- ggplot(data =jung, aes(x = 월)) +
  geom_line(aes(y = 발생건수)) +
  coord_cartesian(xlim = c(0, 13), ylim = c(0, 160)) +
  ggtitle("2015년 서울 중구의 월별 교통사고 발생 동향")

line

# 공간 시각화

# load data
seoul <- read.csv(file.path(route, 'seoul.csv'), 
                  header = T, sep = ",",
                  encoding = "EUC-KR")
seoul

seoul15 <- merge(tra15, seoul, 
                 by.x="자치구명", by.y = "area")

seoul15

# libraries

install.packages("ggmap") # 동적
install.packages("maps") # 정적
install.packages("mapproj") # 정적

library("ggmap")
library("maps")
library("mapproj") # 투영 기능 지원

# load map
## require google api

register_google(key = "AIzaSyDvO0zaBtHZD5pEeVjdwHVMusgNcXDFXv8")

seoul_map <- get_googlemap("seoul", zoom = 11)
sm <- ggmap(seoul_map) #ggmap() 지도 데이터 시각화
print(sm)

# dot plot
dot <- ggmap(seoul_map)
dot <- dot + geom_point(data = seoul15, 
                        aes(x = lon, y = lat))
dot

# bubble plot

library(RColorBrewer)

bub <- ggmap(seoul_map)
bub <- bub + 
  scale_fill_brewer(palette = "Set2") +
  geom_point(data = seoul15, 
             aes(x=lon, y=lat, size = "발생건수"),
             shape = 16, color = 'yellow', alpha = 0.6)
bub

# relation visualization

scat2 <- ggplot(tra15, aes(x=발생건수, y = 부상자수))
scat2 <- scat2 + geom_point() +
  ggtitle("교통사고 - 발생건수와 사상자수의 관계")+
  stat_smooth(method = "lm", se = F, color = 'skyblue')
scat2

# bubble chart
bub2 <- ggplot(tra15, aes(x=발생건수, y = 부상자수)) +
  scale_fill_brewer(palette = "Set3") +
  geom_point(aes(size = 사망자수), shape = 16, color = 'red',
             alpha = 0.56) +
  ggtitle("교통사고 발생 통계 버블차트"); bub2

# bar graph

ba <- ggplot(tra15, aes(x=자치구명, y = 부상자수)) +
  geom_bar(stat = 'identity', color = 'gray', fill = 'magenta') +
  ggtitle("교통사고 부상자수"); ba

# heatmap

row.names(tra15) <- tra15$자치구명
tra15 <- tra15[,c(4:6)]
tra15_mat <- data.matrix(tra15)
tra15_mat
heatmap(tra15_mat, Rowv = NA, Colv = NA,
        col = cm.colors(256), scale = "column",
        margin = c(5,5), cexCol = 1)


