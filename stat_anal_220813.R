library(MASS) # 데이터 패키지
data(swiss)

swiss_land <- as.matrix(swiss[,-1])
swiss.dist <- dist(swiss_land)
swiss.mds <- isoMDS(swiss.dist)

plot(swiss.mds$points, type = "n")
text(swiss.mds$points,
     labels = as.character(1:nrow(swiss_land)))
abline(v = 0, h = 0, lty= 2, lwd =0.5)

# sammon 
swiss.sam <- sammon(swiss.dist)
plot(swiss.sam$points, type = "n")
text(swiss.sam$points,
     labels = as.character(1:nrow(swiss_land)))
abline(v = 0, h = 0, lty= 2, lwd =0.5)
