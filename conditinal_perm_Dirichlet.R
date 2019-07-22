require(extendedForest)
require(MASS)

setwd('C:/Users/Yiting/Desktop/Teck/R_stuff')
XX = read.csv("X_R_Dirichlet.csv",row.names = 1,header=TRUE)
XX <- as.matrix(XX)
yy = read.csv("y_R.csv",row.names = 1,header=TRUE)
yy = yy['SeRR']
yy <- as.matrix(yy)
df <- cbind(yy = yy, as.data.frame(XX))
colnames(df)[1] = 'yy'

maxK <- c(0,1,2,3,4,5)
nsites <- 100
nsim <- 100
imp <- array(0, dim = c(dim(XX)[2], length(maxK), nsim))
set.seed(222)
for (sim in 1:nsim) {
  
  for (lev in 1:length(maxK)) {
    RF <- randomForest(yy ~ ., df,
                       maxLevel = maxK[lev],
                       importance = TRUE, ntree = 500,
                       corr.threshold = 0.5,
                       mtry = 8)
    imp[, lev, sim] <- RF$importance[, 1]
  }
}
dimnames(imp) <- list(rownames(RF$importance),as.character(maxK), NULL)
imp <- as.data.frame.table(imp)

dev.off()
require(lattice)
names(imp) <- c("var", "maxK", "sim", "importance")
pdf("feature_importances_Dirichlet.pdf",width = 10, height = 23)
print(bwplot(var ~ importance | ifelse(maxK == "0",
                                       "Marginal",
                                       paste("Conditional: Level",
                                       maxK, sep = "=")),
                                       imp, as.table = T))

dev.off()
