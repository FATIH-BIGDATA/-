# restructured by using 1:1 Q&A

# load data
load("C:/Users/phc07/Desktop/dataHC/01_bigdata/03_BigdataEngineer/sample.RData")

#library
#install.packages("igraph")
library(igraph)

tomo <- graph.data.frame(data); tomo
summary(tomo)

vcount(tomo)
V(tomo)

ecount(tomo)
E(tomo)

get.edge.attribute(tomo, "friend_tie")     #--- Edge attribute
get.edge.attribute(tomo, "social_tie")     #--- Edge attribute
get.edge.attribute(tomo, "task_tie")       #--- Edge attribute

mFriend <- delete.edges(tomo, E(tomo)[get.edge.attribute(tomo, name = "friend_tie") == 0])
mSocial <- delete.edges(tomo, E(tomo)[get.edge.attribute(tomo, name = "social_tie") == 0])
mTask <- delete.edges(tomo, E(tomo)[get.edge.attribute(tomo, name = "task_tie") == 0])

summary(mFriend)
plot(mFriend)

mFriend <- as.undirected(mFriend, mode = "collapse")
mFriend <- delete.vertices(mFriend, V(mFriend)[degree(mFriend) == 0])

summary(mFriend)
plot(mFriend)
  
# walktrap
mFriend_wt <- walktrap.community(mFriend, steps = 200, modularity = TRUE)
plot(as.dendrogram(mFriend_wt, use.modularity = TRUE))
mFriend_wt$modularity

# Edge Betweenness method
mFriend_eb<-edge.betweenness.community(mFriend)
plot(as.dendrogram(mFriend_eb, use.modularity = TRUE))
