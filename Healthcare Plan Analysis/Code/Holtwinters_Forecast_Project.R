#Group Project Timeseries Forecasting Portion

#Step 1
#aggregating data by year for timeseries analysis
#data is produced by NY health data annually

#2009
data_09 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2009.csv')
data_09$Total.Charges <- as.numeric(gsub(",","",data_09$Total.Charges))
data_09$Total.Costs <- as.numeric(gsub(",","",data_09$Total.Costs))
data_09$cost_shared <- (data_09$Total.Charges - data_09$Total.Costs)

year_09 <- data.frame(year=2009,total_charges = sum(data_09$Total.Charges), avg_charges=mean(data_09$Total.Charges), total_costs = sum(data_09$Total.Costs)
                      ,avg_costs = mean(data_09$Total.Costs), total_shared = sum(data_09$cost_shared),avg_shared = mean(data_09$cost_shared))

#2010
data_10 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2010.csv')
data_10$Total.Charges <- as.numeric(gsub(",","",data_10$Total.Charges))
data_10$Total.Costs <- as.numeric(gsub(",","",data_10$Total.Costs))
data_10$cost_shared <- (data_10$Total.Charges - data_10$Total.Costs)

year_10 <- data.frame(year=2010,total_charges = sum(data_10$Total.Charges), avg_charges=mean(data_10$Total.Charges), total_costs = sum(data_10$Total.Costs)
                      ,avg_costs = mean(data_10$Total.Costs), total_shared = sum(data_10$cost_shared),avg_shared = mean(data_10$cost_shared))

#2012
data_11 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2011.csv')
data_11$Total.Charges <- as.numeric(gsub(",","",data_11$Total.Charges))
data_11$Total.Costs <- as.numeric(gsub(",","",data_11$Total.Costs))
data_11$cost_shared <- (data_11$Total.Charges - data_11$Total.Costs)

year_11 <- data.frame(year=2011,total_charges = sum(data_11$Total.Charges), avg_charges=mean(data_11$Total.Charges), total_costs = sum(data_11$Total.Costs)
                      ,avg_costs = mean(data_11$Total.Costs), total_shared = sum(data_11$cost_shared),avg_shared = mean(data_11$cost_shared))

#2012
data_12 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2012.csv')
data_12$Total.Charges <- as.numeric(gsub(",","",data_12$Total.Charges))
data_12$Total.Costs <- as.numeric(gsub(",","",data_12$Total.Costs))
data_12$cost_shared <- (data_12$Total.Charges - data_12$Total.Costs)

year_12 <- data.frame(year=2012,total_charges = sum(data_12$Total.Charges), avg_charges=mean(data_12$Total.Charges), total_costs = sum(data_12$Total.Costs)
                      ,avg_costs = mean(data_12$Total.Costs), total_shared = sum(data_12$cost_shared),avg_shared = mean(data_12$cost_shared))


#2013
data_13 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2013.csv')
data_13$Total.Charges <- as.numeric(gsub(",","",data_13$Total.Charges))
data_13$Total.Costs <- as.numeric(gsub(",","",data_13$Total.Costs))
data_13$cost_shared <- (data_13$Total.Charges - data_13$Total.Costs)

year_13 <- data.frame(year=2013,total_charges = sum(data_13$Total.Charges), avg_charges=mean(data_13$Total.Charges), total_costs = sum(data_13$Total.Costs)
                      ,avg_costs = mean(data_13$Total.Costs), total_shared = sum(data_13$cost_shared),avg_shared = mean(data_13$cost_shared))

#2014
data_14 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2014.csv')
data_14$Total.Charges <- as.numeric(gsub(",","",data_14$Total.Charges))
data_14$Total.Costs <- as.numeric(gsub(",","",data_14$Total.Costs))
data_14$cost_shared <- (data_14$Total.Charges - data_14$Total.Costs)

year_14 <- data.frame(year=2014,total_charges = sum(data_14$Total.Charges), avg_charges=mean(data_14$Total.Charges), total_costs = sum(data_14$Total.Costs)
                      ,avg_costs = mean(data_14$Total.Costs), total_shared = sum(data_14$cost_shared),avg_shared = mean(data_14$cost_shared))

#2015
data_15 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2015.csv')
data_15$Total.Charges <- as.numeric(gsub(",","",data_15$Total.Charges))
data_15$Total.Costs <- as.numeric(gsub(",","",data_15$Total.Costs))
data_15$cost_shared <- (data_15$Total.Charges - data_15$Total.Costs)

year_15 <- data.frame(year=2015,total_charges = sum(data_15$Total.Charges), avg_charges=mean(data_15$Total.Charges), total_costs = sum(data_15$Total.Costs)
                      ,avg_costs = mean(data_15$Total.Costs), total_shared = sum(data_15$cost_shared),avg_shared = mean(data_15$cost_shared))

#2016
data_16 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2016.csv')
data_16$Total.Charges <- as.numeric(gsub(",","",data_16$Total.Charges))
data_16$Total.Costs <- as.numeric(gsub(",","",data_16$Total.Costs))
data_16$cost_shared <- (data_16$Total.Charges - data_16$Total.Costs)

year_16 <- data.frame(year=2016,total_charges = sum(data_16$Total.Charges), avg_charges=mean(data_16$Total.Charges), total_costs = sum(data_16$Total.Costs)
                      ,avg_costs = mean(data_16$Total.Costs), total_shared = sum(data_16$cost_shared),avg_shared = mean(data_16$cost_shared))

#2017
data_17 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2017.csv')
data_17$Total.Charges <- as.numeric(gsub(",","",data_17$Total.Charges))
data_17$Total.Costs <- as.numeric(gsub(",","",data_17$Total.Costs))
data_17$cost_shared <- (data_17$Total.Charges - data_17$Total.Costs)

year_17 <- data.frame(year=2017,total_charges = sum(data_17$Total.Charges), avg_charges=mean(data_17$Total.Charges), total_costs = sum(data_17$Total.Costs)
                      ,avg_costs = mean(data_17$Total.Costs), total_shared = sum(data_17$cost_shared),avg_shared = mean(data_17$cost_shared))

#2018
data_18 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2018.csv')
data_18$Total.Charges <- as.numeric(gsub(",","",data_18$Total.Charges))
data_18$Total.Costs <- as.numeric(gsub(",","",data_18$Total.Costs))
data_18$cost_shared <- (data_18$Total.Charges - data_18$Total.Costs)

year_18 <- data.frame(year=2018,total_charges = sum(data_18$Total.Charges), avg_charges=mean(data_18$Total.Charges), total_costs = sum(data_18$Total.Costs)
                      ,avg_costs = mean(data_18$Total.Costs), total_shared = sum(data_18$cost_shared),avg_shared = mean(data_18$cost_shared))

#2019
data_19 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2019.csv')
data_19$Total.Charges <- as.numeric(gsub(",","",data_19$Total.Charges))
data_19$Total.Costs <- as.numeric(gsub(",","",data_19$Total.Costs))
data_19$cost_shared <- (data_19$Total.Charges - data_19$Total.Costs)

year_19 <- data.frame(year=2019,total_charges = sum(data_19$Total.Charges), avg_charges=mean(data_19$Total.Charges), total_costs = sum(data_19$Total.Costs)
                      ,avg_costs = mean(data_19$Total.Costs), total_shared = sum(data_19$cost_shared),avg_shared = mean(data_19$cost_shared))

#2020
data_20 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2020.csv')
data_20$Total.Charges <- as.numeric(gsub(",","",data_20$Total.Charges))
data_20$Total.Costs <- as.numeric(gsub(",","",data_20$Total.Costs))
data_20$cost_shared <- (data_20$Total.Charges - data_20$Total.Costs)

year_20 <- data.frame(year=2020,total_charges = sum(data_20$Total.Charges), avg_charges=mean(data_20$Total.Charges), total_costs = sum(data_20$Total.Costs)
                      ,avg_costs = mean(data_20$Total.Costs), total_shared = sum(data_20$cost_shared),avg_shared = mean(data_20$cost_shared))

#2021
data_21 <-read.csv('Hospital_Inpatient_Discharges__SPARCS_De-Identified___2021.csv')
data_21$Total.Charges <- as.numeric(gsub(",","",data_21$Total.Charges))
data_21$Total.Costs <- as.numeric(gsub(",","",data_21$Total.Costs))
data_21$cost_shared <- (data_21$Total.Charges - data_21$Total.Costs)

year_21 <- data.frame(year=2021,total_charges = sum(data_21$Total.Charges), avg_charges=mean(data_21$Total.Charges), total_costs = sum(data_21$Total.Costs)
                      ,avg_costs = mean(data_21$Total.Costs), total_shared = sum(data_21$cost_shared),avg_shared = mean(data_21$cost_shared))

#Step 2
#All years combined into single dataframe
year_data <- rbind(year_09,year_10,year_11,year_12,year_13,year_14,year_15,year_16,year_17,year_18,year_19,year_20,year_21)

#Export of csv to create visualizations
#year_data
#export data for tableau visualization
#write.csv(year_data,'year_data.csv',row.names=FALSE)

#Step 3
#Holt-Winters Approach for simple forecasting 

library(stats)
avg_chrg_ts <- ts(year_data$avg_charges, frequency = 1, start = c(2009,1))
#avg_chrg_ts

#charges
hw <- HoltWinters(avg_chrg_ts, gamma=FALSE)
hw_pred <-predict(hw,5,prediction.interval = TRUE, level=0.95)
plot(hw,xlim=c(2009,2026),ylim=c(20000,150000))
lines(hw_pred[,1], col="green")
lines(hw_pred[,2], col="red")
lines(hw_pred[,3], col="blue")
summary(hw_pred)
hw_pred
hw

#costs
avg_cost_ts <- ts(year_data$avg_costs, frequency = 1, start = c(2009,1))
hw2 <- HoltWinters(avg_cost_ts, gamma=FALSE)
hw_pred2 <-predict(hw2,5,prediction.interval = TRUE, level=0.95)
plot(hw2,xlim=c(2009,2026),ylim=c(10000,60000))
lines(hw_pred2[,1], col="green")
lines(hw_pred2[,2], col="red")
lines(hw_pred2[,3], col="blue")

#shared costs
avg_shared_ts <- ts(year_data$avg_shared, frequency = 1, start = c(2009,1))
hw3 <- HoltWinters(avg_shared_ts, gamma=FALSE)
hw_pred3 <-predict(hw3,5,prediction.interval = TRUE, level=0.95)
plot(hw3,xlim=c(2009,2026),ylim=c(15000,150000))
lines(hw_pred3[,1], col="green")
lines(hw_pred3[,2], col="red")
lines(hw_pred3[,3], col="blue")

#export results for tableau visualization
#commented out 
#write.csv(as.data.frame(hw_pred),'avg_charges.csv',row.names = FALSE)
#write.csv(as.data.frame(hw_pred2),'avg_costs.csv',row.names = FALSE)
#write.csv(as.data.frame(hw_pred3),'avg_shared.csv',row.names = FALSE)