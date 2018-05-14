#install.packages("neuralnet")
library("neuralnet")

#Generate random numbers uniformly distributed between 0 and 2PI (for very good results in such a range)
#And store them as a dataframe
X <- as.data.frame(runif(1, min=1, max=10))
Y <- (log10(X)^2)

#Column bind the data into one variable
trainingdata <- cbind(X,Y)
colnames(trainingdata) <- c("Input","Output")

#Train the neural network
#Going to have C(3, 4, 2) hidden layers
#Threshold is a numeric value specifying the threshold for the partial
#derivatives of the error function as stopping criteria.
net.myfunc <- neuralnet(Output~Input, trainingdata, hidden=c(3, 4, 2), threshold=0.01)
print(net.myfunc)

#Plot the neural network
plot(net.myfunc)

#Test the neural network on some training data
testdata <- as.data.frame((2:20)*0.5) #Generate some numbers between 1 and 10
net.results <- compute(net.myfunc, testdata) #Run them through the neural network

#Lets see what properties net.myfunc has
ls(net.results)

#Lets see the results
print(net.results$net.result)

#Lets display a better version of the results
cleanoutput <- cbind(testdata,(cos(testdata)^cos(testdata)),
                     as.data.frame(net.results$net.result))
colnames(cleanoutput) <- c("Input","Expected Output","Neural Net Output")
print(cleanoutput)

