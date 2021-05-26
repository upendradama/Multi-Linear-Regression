# Multi Linear Regression

### Problem Statement:- 

  - Build a model to predict the computer sales

### Data Understanding
```{r}
library(readr)
Computer_Data <- read_csv("/Users/thanush/Desktop/Digi 360/Module 7/Module 7_Multi Linear Regression/Computer_Data.csv")
head(Computer_Data)
```
```{r}
#Attaching the dataset
attach(Computer_Data)
```

### Data Cleaning
```{r}
#Replace categorical values with dummy values
library(plyr)
Computer_Data$cd <- revalue(Computer_Data$cd, c("yes"=1, "no"=0))
Computer_Data$multi <- revalue(Computer_Data$multi, c("yes"=1, "no"=0))
Computer_Data$premium <- revalue(Computer_Data$premium, c("yes"=1, "no"=0))
head(Computer_Data)
```

```{r}
#Remove the first column since it is serial number.
Computer_Data$X1 <- NULL
head(Computer_Data)
```
```{r}
# Converting the datatype as numeric for categorical fatures
Computer_Data$cd <- as.numeric(Computer_Data$cd)
Computer_Data$multi <- as.numeric(Computer_Data$multi)
Computer_Data$premium <- as.numeric(Computer_Data$premium)
head(Computer_Data)
```
### Data Visualization

```{r}
plot(Computer_Data)
```
```{r}
# Finding the Corrleation Coefficient
cor(Computer_Data)
```

### Building the first model

```{r}
model1 <- lm(price~speed+hd+ram+screen+cd+multi+premium+ads+trend)
summary(model1)

```
All features are having significant p value. But R^2 is not too good, let's do some transformations.

### Transformations - Polynomial 

```{r}
# Let's build model with 7th degree polynomial

model2 <- lm(price~speed+I(speed^2)+I(speed^3)+I(speed^4)+I(speed^5)+I(speed^6)+I(speed^7)+hd+I(hd^2)+I(hd^3)+I(hd^4)+I(hd^5)+I(hd^6)+I(hd^7)+ram+I(ram^2)+I(ram^3)+I(ram^4)+I(ram^5)+I(ram^6)+I(ram^7)+screen+I(screen^2)+I(screen^3)+I(screen^4)+I(screen^5)+I(screen^6)+I(screen^7)+cd+I(cd^2)+I(cd^3)+I(cd^4)+I(cd^5)+I(cd^6)+I(cd^7)+multi+I(multi^2)+I(multi^3)+I(multi^4)+I(multi^5)+I(multi^6)+I(multi^7)+premium+I(premium^2)+I(premium^3)+I(premium^4)+I(premium^5)+I(premium^6)+I(premium^7)+ads+I(ads^2)+I(ads^3)+I(ads^4)+I(ads^5)+I(ads^6)+I(ads^7)+trend+I(trend^2)+I(trend^3)+I(trend^4)+I(trend^5)+I(trend^6)+I(trend^7), Computer_Data)

summary(model2)
```
Here, the linear equation with the above coefficients will be considered a good equation because the p value is less than 0.05 and R^2 is also significant. So, we can stop building the model here. 

### Splitting the Dataset into train and test
```{r}
n=nrow(Computer_Data)
n1=n*0.7
n2=n-n1
train=sample(1:n,n1)
test=Computer_Data[-train,]

```
### Predictions

```{r}
pred=predict(model2,newdata = test)
```

### Accuracy

```{r}
actual=test$price
error=actual-pred
# Test RMSE
test.rmse=sqrt(mean(error**2))
test.rmse
# Train RMSE
train.rmse=sqrt(mean(model2$residuals**2))
train.rmse
```

### Table of R^2 value for two models

Model 1	0.7756

Model 2	0.8259

### Conclusion

    - R^2 for final model is significant
    - RMSE is very close for test and train so the accuracy of the model is good
    
We can conclude that the computer sales depend on below features.

      `speed`
      `hd`
      `ram`
      `screen`
      `cdyes`
      `multiyes`
      `premiumyes`
      `ads`
      `trend`
      
