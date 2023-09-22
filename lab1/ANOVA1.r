setwd("/home/hjoaquim/Documents/experimental-design/lab1/")

#****************************************************************************************** #
#**************************** ANOVA- Exerc�cio 1********************************************#
#****************************************************************************************** #


dados1 <- read.table("ANOVA1.txt", header = T) # L� a base de dados#
attach(dados1)
str(dados1)
dados1$Municipio <- factor(dados1$Municipio, labels = c("A", "B", "C", "D"))
attach(dados1)



# Pressupostos

# Testes de homogeneidade das vari�ncias

# install.packages("car")
library(car)
bartlett.test(ConcentracaoZn ~ Municipio)
leveneTest(ConcentracaoZn, Municipio)
fligner.test(ConcentracaoZn ~ Municipio) # Fligner-Killeen test of homogeneity of variances # � mais robusto em rela��o � n�o normalidade

# Normalidade

# Testes � normalidade

tapply(ConcentracaoZn, Municipio, shapiro.test)

library(nortest)
tapply(ConcentracaoZn, Municipio, lillie.test) # Teste K-S com corec��o de Liliefors (indicado quando usamos estimativas dos par�metros)


#**************************** ANOVA********************************************#


modelo1 <- aov(ConcentracaoZn ~ Municipio)
summary(modelo1)

boxplot(ConcentracaoZn ~ Municipio)

# Pressupostos aos erros=res�duos)

attributes(modelo1)

# Testes de homogeneidade das vari�ncias

library(car)
bartlett.test(ConcentracaoZn ~ Municipio)
leveneTest(ConcentracaoZn ~ Municipio)
leveneTest(ConcentracaoZn, Municipio, center = mean) # p-value=0.6493 > 0,05 N�o rejeitamos H0
fligner.test(ConcentracaoZn ~ Municipio) # Fligner-Killeen test of homogeneity of variances # � mais robusto em rela��o � n�o normalidade

rmodelo1 <- resid(modelo1)

plot(rmodelo1)

par(mfrow = c(1, 2)) # Dividir a janela gr�fica em 2 colunas

# M�todos gr�ficos

hist(rmodelo1, prob = T, col = "red", xlab = "Res�duos", main = "")
qqnorm(rmodelo1, main = "")
qqline(rmodelo1, col = 3, lwd = 5)

# M�todos Anal�ticos

shapiro.test(rmodelo1)
library(nortest)
lillie.test(rmodelo1)
# ks.test(rmodelo1,"pnorm") n�o � o teste adequado, pois o par�metros s�o estimados

cvm.test(rmodelo1) # Cramer-von Mises normality test

ad.test(rmodelo1) # Anderson-Darling normality test


# Compara��es m�ltiplas de TukeyHSD (Tukey Honest Significant Differences)

TukeyHSD(modelo1)
plot(TukeyHSD(modelo1))

# Compara��es m�ltiplas de Bonferroni

pairwise.t.test(ConcentracaoZn, Municipio, p.adj = "bonf")

# Compara��es m�ltiplas LSD (Least Significant Difference = M�nima diferan�a significativa)
pairwise.t.test(ConcentracaoZn, Municipio, p.adj = "none")

# Compara��es m�ltiplas de Holm

pairwise.t.test(ConcentracaoZn, Municipio, p.adj = "holm")

# library(agricolae)
# comparison <- scheffe.test(modelo1,"Municipio", group=TRUE, main="Polui��o de zinco em solos de 4 munic�pios")
# comparison

library(ExpDes)
crd(Municipio, ConcentracaoZn, quali = TRUE, mcomp = "tukey", sigT = 0.05, sigF = 0.05)

# library(agricolae)
# comparison1 <- scheffe.test(modelo1,"Municipio", group=TRUE,alpha=0.10, main="Polui��o de zinco em solos de 4 munic�pios")
# comparison1

library(ExpDes)
crd(Municipio, ConcentracaoZn, quali = TRUE, mcomp = "tukey", sigT = 0.1, sigF = 0.1)


# Contrastes planeados
# correr a ANOVA
str(dados1)

modelo1 <- aov(ConcentracaoZn ~ Municipio)
summary(modelo1)


# n�veis do factor
levels(Municipio)

# indicar os grupos a comparar
c1 <- c(.5, .5, -.5, -.5) # A, B vs C, D
c2 <- c(1, -1, 0, 0) # A vs B
c3 <- c(0, 1, 0, -1) # B vs D
c4 <- c(0, 1, -1, 0) # B vs C


contrastes <- rbind(c1, c2, c3, c4)



library(multcomp) # para utilizar glht()
summary(glht(modelo1, linfct = mcp(Municipio = contrastes), alternative = "two.sided"), test = adjusted("none"))

# Contrastes planeados

# indicar os grupos a comparar
c1 <- c(-1, -1, -1, 3) # D vs A, B, C
c2 <- c(-1, -1, 3, -1) # C vs A, B, D
c3 <- c(-1, 0, 2, -1) # C vs A,D
c4 <- c(-1, 0, 1, 0) # A vs C


contrastes <- rbind(c1, c2, c3, c4)



library(multcomp) # para utilizar glht()
summary(glht(modelo1, linfct = mcp(Municipio = contrastes), alternative = "two.sided"), test = adjusted("none"))




#  ******   alinea h)  ******

library(lme4)
modeloh <- lmer(ConcentracaoZn ~ (1 | Municipio))
summary(modeloh)

# sigma^2_A=73,61

plot(modeloh)
