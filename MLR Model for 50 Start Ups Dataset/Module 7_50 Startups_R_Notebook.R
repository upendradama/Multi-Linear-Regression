# Multi Linear Regression

### Problem Statement:- 

  - Build a model to predict the profit of 50 start ups
  
### Data Understanding
```{r}
library(readr)
X50_Startups <- read_csv("/Users/thanush/Desktop/Digi 360/Module 7/Module 7_Multi Linear Regression/50_Startups.csv")
head(X50_Startups)
```

```{r}
# Renaming the coulmn names
colnames(X50_Startups) <- c("rd","ad","mk","st","pf")
head(X50_Startups)
```
```{r}
# Attching the dataset
attach(X50_Startups)
```
### Data Preparation

```{r}
#State is not numeric so let’s assign dummy variables.
X50_Startups <- cbind(X50_Startups,ifelse(X50_Startups$st=="New York",1,0), ifelse(X50_Startups$st=="California",1,0),ifelse(X50_Startups$st=="Florida",1,0))

head(X50_Startups)
```
```{r}
#Rename the dummy variable columns
colnames(X50_Startups)[6] <- "ny" 
colnames(X50_Startups)[7] <- "cf"
colnames(X50_Startups)[8] <- "fl"

```

```{r}
#Dropping the state column since dummy values are already assigned
X50_Startups$st <- NULL
head(X50_Startups)
```

### Data Visualization

```{r}
#Plotting the scatter plot for all the columns
attach(X50_Startups)
plot(X50_Startups)
```

```{r}
#Finding the correlation coefficient for the entire dataset
cor(X50_Startups)
```
### Building the model

```{r}
model1 <- lm(pf~rd+ad+mk+cf+ny+fl)
summary(model1)
```
 
 We can see here that the p value is too high for features `cf`, `ny` and `fl`. So let's drop them.
 
```{r}
# Rebuilding the model without features `cs`, `ny` and `fl`
model2 <- lm(pf~rd+ad+mk)
summary(model2)

```

Now we can see p valu ei shigh for feature `ad`. Let's rebuild the model without this feature.

```{r}
model3 <- lm(pf~rd+mk)
summary(model3)
```

Still we can see p value is insignificant for feature `mk`. Let's rebuild the model with remaining features.

```{r}
model4 <- lm(pf~rd)
summary(model4)
```

### Splitting the data to train and test

```{r}
n=nrow(X50_Startups)
n1=n*0.7
n2=n-n1
train=sample(1:n,n1)
head(train)
```
```{r}
test=X50_Startups[-train,]
head(test)
```

### Model Evoluation

```{r}
# Predicting the values with model 4
pred=predict(model4,newdata = test)
actual = test$pf
```

```{r}
#Finding the errors
error=actual-pred
error
```

### Finding the accuracy

```{r}
# RMSE of test
test.rmse=sqrt(mean(error**2))
test.rmse

# RMSE of train
train.rmse=sqrt(mean(model2$residuals**2))
train.rmse
```

# Table of R^2 value for four models: -

  Model 1	0.9508
  Model 2	0.9507
  Model 3	0.9505
  Model 4	0.9465
  
  
# Conclusion:- 

  - R^2 is 0.94 which is pretty good
  - RMSE is very close for train and test i.e. accuracy is good

We can conclude that the profit of given 50 startups depends on `R&D`.




