# Multi LInear Regression

### Problem Statement:-

  - Build a model to predict sales of Toyota Corolla

```{r}
# Loading the datset.
library(readr)
ToyotaCorolla <- read_csv("/Users/thanush/Desktop/Digi 360/Module 7/Module 7_Multi Linear Regression/ToyotaCorolla.csv")
head(ToyotaCorolla)
```
```{r}
# Extracting selected columns given in probelm statement
ToyotaCorolla <- ToyotaCorolla[,c("Price","Age_08_04","KM","HP","cc","Doors","Gears","Quarterly_Tax","Weight")]
head(ToyotaCorolla)
```

```{r}
#Renaming the column names
colnames(ToyotaCorolla) <- c("price","age","km","hp","cc","door","gear","qrt","wgt")
head(ToyotaCorolla)
```
```{r}
#Lets' see quick summary

summary(ToyotaCorolla)
```

```{r}
# Attching the dataframe
attach(ToyotaCorolla)
```


### Data Visualization

```{r}
plot(ToyotaCorolla)
```
```{r}
#Finding correlation coefficient
cor(ToyotaCorolla)
```
We can see from above matrix that there are no features are closely correlated with each other.

### Model Building

```{r}
model1 <- lm(price~age+km+hp+cc+door+gear+qrt+wgt)
summary(model1)
```
### Checking VIF

```{r}
library(car)
```
```{r}
vif(model1)
```

Here the VIF is less than 5. So, no variable is collinear with others. So, let's remove the features which are having insignificant p values

Let's remove `cc` and `doors` since they have p value greater than 0.05.

```{r}
#Building the model after dropping the cc and doors variable

model2 <- lm(price~age+km+hp+gear+qrt+wgt)
summary(model2)
```

Here p value is significant so we reject the null hypothesis. That means there is significant correlation between price vs other input variables.

Here we also can see R-squared value is 0.8636 which is greater than 0.85. Hence our model is good and we don’t need further transformations.

### Splitting the dataset into Train and Test

```{r}
n=nrow(ToyotaCorolla) 
n1=n*0.7
n2=n-n1
train=sample(1:n,n1)
test=ToyotaCorolla[-train,]
```

### Predicting the values with model 2

```{r}
pred=predict(model2,newdata = test)
actual=test$price
```

```{r}
#Finding the errors
error=actual-pred
```

### Fnding the Accuracy

```{r}
test.rmse=sqrt(mean(error**2))
test.rmse
train.rmse=sqrt(mean(model2$residuals**2))
train.rmse
```

Here we can see test rmse value is very close to train rmse value. So, our model is significantly fit. 

### R^2 value for two models: - 

Model 1	0.8638
Model 2	0.8636

### Conclusion

  - R^2 of the model is 0.86 which is good
  - RMSE is very close for both train and test sets

We can conclude that the sales of the Corolla depends on the features `age`, `km`, `hp`, `gear`, `quarterly tax` and `weight`.



 
