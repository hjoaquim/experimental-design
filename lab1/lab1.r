# Ex1

# -> identify the kind of ANOVA design

# dependent variable: Zn (mg/kg) concentration
# there is 1 factor: municipality (4 levels: A,B,C,D)
# since in the exercise it is not specified, we assume that we're working with fixed factors
# since each level (municipality) has the same number of observations, we can say that the design is balanced.

# Model: Yij = μ + αi + εij
# Yij: Zn concentration of the jth sample from the ith municipality
# μ: overall mean
# αi: effect of the ith municipality
# εij: random error

# i = municipality (A,B,C,D)
# j = samples (1,2,3, ..., n)

# hipotesis:
# H0: ∀ αi = 0 (for i = 1,2,3,4)
# H1: ∃ αi ≠ 0 (for at least one i)

# Ex1. d)

# assumptions:
# 1) independence of the observations: random observations of the soil
# 2) normality (can be done graphically [r: qqplot] or analytically (shapiro rule, K-S test, etc))
#    H0: yi ~ N
#    H1: yi !~ N
