
###1)The first step: Define project goals and ask questions.

#Using the data we have, we will answer the following questions:

#1)Determine which is more popular smart watch or fitness Band?
#2)What is the most preferred brand for customers for both smart watches and fitness bands?
#3)Determine the relationship between product specifications and customer rating


###2)The second step is to collect data:

#The data has been collected from an e-commerce website (Flipkart) using webscraping technique.

#We imported the data from the Kaggle website
#(https://www.kaggle.com/datasets/devsubhash/fitness-trackers-products-ecommerce?select=Fitness_trackers_updated.csv)


#Data import 

library(readr)

Fitness_trackers<- read_csv("D:/Projects/R-Fitness Trackers/Fitness_trackers_updated.csv")

View(Fitness_trackers)


  
#data exploration

head(Fitness_trackers)  #Display the first 6 rows of the data set

str(Fitness_trackers)  #Structure and type of data


sapply(Fitness_trackers, class)  # Print classes of  columns


summary(Fitness_trackers)  #Calculate Descriptive Statistics

names(Fitness_trackers)   # Get column names

dim(Fitness_trackers)            # Number of rows & columns



###3)The third step is to clean the data:

View(Fitness_trackers)


colnames(Fitness_trackers)     # Print column names

#Modify Column Names

colnames(Fitness_trackers) <- c("Brand_Name", "Device_Type", "Model_Name","Color",
                                        "Selling_Price","Original_Price","Display","Rating",
                                        "Strap_Material","Battery_Life_by_days","Reviews")


Fitness_trackers <- unique(Fitness_trackers)          # Exclude duplicates

#the number of smart watches VS number of Fitness Band
library(tidyverse)
Fitness_trackers %>%
  count(Device_Type) %>%
  group_by(Device_Type)

#We found the number of Smart Watch more than the number of Fitness Band, this leads to bias in the sample
#To avoid bias, we equate the number of Smart Watch with the number of Fitness Band

# We convert data into numbers to facilitate the process of sorting and arranging

Fitness_trackers$Device_Type <- gsub("FitnessBand", "1", Fitness_trackers$Device_Type)       
Fitness_trackers$Device_Type <- gsub("Smartwatch", "0", Fitness_trackers$Device_Type)       

view(Fitness_trackers)

dataframe<-Fitness_trackers %>% arrange(Device_Type)  # sort data

view(dataframe)


Fitness_trackers2<-dataframe[-c(1:452), ] # Create a bias-free data set 

view(Fitness_trackers2)


# We restore the data to its original state

Fitness_trackers2$Device_Type <- gsub("1", "FitnessBand", Fitness_trackers2$Device_Type)       
Fitness_trackers2$Device_Type <- gsub("0", "Smartwatch", Fitness_trackers2$Device_Type)

view(Fitness_trackers2)

#Now we have the number of Smart Watch equal to the number of Fitness Band

#dealing with messing data

library(tidyverse)

Fitness_trackers2 %>% map(~sum(is.na(.))) #See all missing values in the entire data set columns


#Number of NA values in the Rating column

Fitness_trackers2 %>% 
  summarise(count=sum(is.na(Rating)))

#Number of NA values in the Reviews column

sum(is.na(Fitness_trackers2$Reviews))


#We create a new data set and replace the missing values with zero

Fitness_trackers3<-Fitness_trackers2 %>% 
  replace_na(list(
    Rating=0,
    Reviews=0))

view(Fitness_trackers3)

colSums(is.na(Fitness_trackers3))       # Check missing values



# We delete the columns we don't need in a new data set

colnames(Fitness_trackers3)

Fitness_trackers4<- subset(Fitness_trackers3, select = -c(Model_Name,Original_Price,Display,Strap_Material) )

colnames(Fitness_trackers4)

###4)Step four Analyzing the data:

#As mentioned before, the goal of the project is to answer the questions:

#Let's start with the first question.....
#1)Determine which is more popular smart watch or fitness Band?



#The sum of ratings  for smart watches and Fitness Band

Fitness_trackers4 %>% 
  group_by(Device_Type) %>% 
  drop_na() %>% 
  summarise(Rating=sum(Rating))

#Chart total ratings for smart watches and Fitness Band

rating<-ggplot(data=Fitness_trackers4, aes(x=Device_Type, y=Rating))+
  geom_bar(stat="identity",fill="lightblue")+
  theme_dark()+
  labs(title = "Rating for smart watches VS Fitness Band")

rating


#The sum of reviews for smart watches and Fitness Band

Fitness_trackers4 %>% 
  group_by(Device_Type) %>%
  drop_na() %>% 
  summarise(Reviews=sum(Reviews))

#Chart total Reviews for smart watches and Fitness Band

Review<-ggplot(data=Fitness_trackers4, aes(x=Device_Type, y=Reviews))+
  geom_bar(stat="identity",fill="lightblue")+
  theme_dark()+
  labs(title = "Reviews for smart watches VS Fitness Band")

Review


#then we move to the second question.....
#2)What is the most preferred brand for customers for both smart watches and fitness bands?

unique(Fitness_trackers4$Brand_Name)  #Brand names in the data set

# Calculate the number of devices for each Brand

Fitness_trackers4 %>% 
  count(Brand_Name) %>% 
  print(n=21)


# Create a dataset to rank the devices owned by each brand

newdf<-Fitness_trackers4 %>%count(Brand_Name)  #Create brand data set

names(newdf)[names(newdf) == 'n'] <- 'number_of_devices' #Change the device number column name

view(newdf)

newdf %>%
  arrange(-number_of_devices) %>%  #Arrange the number of devices for each brand
  print(n=21)

# We calculate the total ratings obtained by each company
#We created a data set to collect and rank the most rated Brands

newdf2<-aggregate(Fitness_trackers4$Rating,list(Fitness_trackers4$Brand_Name),sum,na.rm=T) #groupe by Brand_Name

colnames(newdf2)<-c("Brand_Name","number_of_Rating")  #Change column names

view(newdf2)

newdf3<-newdf2 %>% arrange(-number_of_Rating) #Create a new data set to rank the ratings

view(newdf3)

#We are now choosing the 5 most rated Brands

top_Brand<-newdf3[-c(6:21), ] # To delete data 

view(top_Brand)

#Representation in a graph of the most rated brands of smart devices

Brand<-ggplot(data=top_Brand, aes(x=Brand_Name, y=number_of_Rating))+
  geom_bar(stat="identity",fill="lightblue")+
  theme_dark()+
  labs(title = "top 5 Brand Name has Rating")

Brand


#then we move to the third question.....
#3)Determine the relationship between product specifications, prices and customer evaluation.

view(Fitness_trackers4)

# We make a comparison between the classification and the specifications
#First we see which colors got the highest rating

#We created a new dataset to put the colors that got the top 10 rating in order

top_color<-aggregate(Fitness_trackers4$Rating,list(Fitness_trackers4$Color),sum,na.rm=T) #groupe by color

view(top_color)

colnames(top_color)<-c("color","number_of_Rating") #Edit column names

top_color2<-top_color %>% 
  arrange(-number_of_Rating) #Create a new data set to the color ratings

top_color3<-top_color2[-c(11:66), ] # To delete data


#Representation in a graph to see which colors are preferred by customers

colors<-ggplot(data=top_color3, aes(x=color, y=number_of_Rating,color=number_of_Rating))+
  geom_bar(stat="identity",fill="lightblue")+
  theme_dark()+
  labs(title = "top 10 Colores has Rating")

colors

#Then we compare the battery life and ratings and see the relationship between them

plot(x = Fitness_trackers4$Battery_Life_by_days,y = Fitness_trackers4$Rating,
     xlab = "Battery Life",
     ylab = "Rating",
     main = "Battery Life vs Rating"
     , pch=19
)

#Determine the relationship between selling price and customer rating

plot(x = Fitness_trackers4$Selling_Price,y = Fitness_trackers4$Rating,
     xlab = "Selling Price",
     ylab = "Rating",
     main = "Selling Price vs Rating"
     , pch=19
)

###5)Step five Interpretation of results:

#We also know that the goal of the project is to answer the following questions....

#1)Determine which is more popular smart watch or fitness Band?
#2)What is the most preferred brand for customers for both smart watches and fitness bands?
#3)Determine the relationship between product specifications, prices and customer rating


#1#which is more popular smart watch or fitness Band?

#Through the results of ratings and reviews, the FitnessBand is the most requested 
#and desired by customers, perhaps because the FitnessBand is cheaper compared to smart watches,
#as well as sufficient specifications to track sports activities.

#2#What is the most preferred brand for customers for both smart watches and fitness bands?

#The brand fitBit is the most famous in the world of sports trackers for having the most 
#rating of 114.5Perhaps the reason for this is that it has 27 devices, 
#which is the most brand with devices in the data set.

#3#Determine the relationship between product specifications, prices and customer rating

#We analyzed the relationships or correlation between specifications and customer rating
#Where we found that the black color is the most common, and we found the correlation between battery life
#and customer rating  no relationship.
#We also found an inverse relationship between the selling price and customer rating
#, where the lower the price, the higher the rating
library(rmarkdown)
library(knitr)
