library(MASS)
cmd <- cmdscale(eurodist)

x <- cmd[, 1]
y <- -cmd[, 2] # 북쪽 도시의 상단 표기를 위해 부호 변환


plot(x, y, type = "n", asp=1,
     main = "Metric MDS")
text(x,y, rownames(cmd), cex = 0.6)
abline(v = 0, h =0, lty = 2, lwd = 0.7)
