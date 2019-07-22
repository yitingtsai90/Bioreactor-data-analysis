library(lattice)
library(xtable)
library(parallel)
library(DirichletMultinomial)
install.packages("readxl")

setwd('C:/Users/Yiting/Desktop/Teck/R_stuff')
raw_abundances = read.csv("YT_bioreactor_data.csv",row.names = 1,header=TRUE)

mydata1 <- as.matrix(raw_abundances)
mydata <- mydata1
cnts <- log10(colSums(mydata))
densityplot(cnts, xlim=range(cnts), xlab="Taxon Representation (log 10 count)")
dev.off()

fitm <- mclapply(1:10, dmn, count=mydata, verbose = TRUE)

pdf("min-laplace.pdf")
fit_laplace <- sapply(fitm, laplace)
plot(fit_laplace, type="b", xlab="Number of Dirichlet Components", ylab="Model Fit")
dev.off()

pdf("min-aic.pdf")
fit_AIC <- sapply(fitm, AIC)
plot(fit_AIC, type="b", xlab="Number of Dirichlet Components", ylab="Model Fit")
dev.off()

fit_BIC <- sapply(fitm, BIC)
pdf("min-bic.pdf")
plot(fit_BIC, type="b", xlab="Number of Dirichlet Components", ylab="Model Fit")
dev.off()

pdf("scatter_Laplace.pdf")
best_Laplace <- fitm[[which.min(fit_laplace)]]
splom(log(fitted(best_Laplace)))
dev.off()

pdf("scatter_AIC.pdf")
best_AIC <- fitm[[which.min(fit_AIC)]]
splom(log(fitted(best_AIC)))
dev.off()

pdf("scatter_BIC.pdf")
best_BIC <- fitm[[which.min(fit_BIC)]]
splom(log(fitted(best_BIC)))
dev.off()

# Choose optimal number of Dirichlet groups based on Information Criteria
best = best_Laplace # Choose an info criterion to examine
p0 <- fitted(fitm[[1]], scale = TRUE)
p_best <- fitted(best, scale = TRUE)
k_best = dim(attr(best,"group"))[2] # Specify best number of clusters
colnames(p_best) <- paste("m", 1:k_best, sep="")
(meandiff <- colSums(abs(p_best-as.vector(p0))))

diff <- rowSums(abs(p_best - as.vector(p0)))
o <- order(diff, decreasing = TRUE)
cdiff <- cumsum(diff[o])/sum(diff)
df <- head(cbind(Mean=p0[o], p_best[o,], diff=diff[o], cdiff), 10)
df

# Make heatmaps based on all info criteria
pdf("OTUheatmap_Laplace.pdf")
heatmapdmn(mydata, fitm[[1]],best_Laplace, 20)
dev.off()

pdf("OTUheatmap_AIC.pdf")
heatmapdmn(mydata, fitm[[1]],best_AIC, 20)
dev.off()

pdf("OTUheatmap_BIC.pdf")
heatmapdmn(mydata, fitm[[1]],best_BIC, 20)
dev.off()
