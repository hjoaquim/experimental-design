# sample regression in r

# load data
data <- read.csv("/home/hjoaquim/Documents/experimental-design/kc_house_data.csv")

# fit model
model <- lm(y ~ x, data)

# print summary
summary(model)

# plot data
plot(model)
