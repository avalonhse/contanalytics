# 23/10/2013
# Author: Big Data Team - ContemiVN (Sebastian Nguyen, Trinh Pham, Keziah Do, Dung Nguyen)) 
# Reference: http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm
#
# Remember load Source ("utilis.R") and set directory to DSM data before running

# Combind data train and data test
data = combine_table("DSM_Data Set 1 Sales.csv", "201310072112-DSM_Submissions.csv")
# Encoding category variables
data = encode_data(data)
# Dummy coding on data
mat_market = dummy_coding(data, data$Market)
mat_pmc = dummy_coding(data, data$Product.Market.Combi)
mat_ac = dummy_coding(data, data$Application.Code)
mat_sa = dummy_coding(data, data$Sales.Area)
mat_pl = dummy_coding(data, data$PdtLine)
mat_cust = dummy_coding(data, data$Cust)
mat_mate = dummy_coding(data, data$Material)

Sales = data$Sales
year = as.numeric(data$year)
month = as.numeric(data$month)
data_dummy = as.data.frame(cbind(Sales, year, month, mat_market, mat_pmc, mat_ac, mat_sa, mat_pl, mat_cust, mat_mate))
# Model linear regresstion
model = model_linear_regresstion(data_dummy,1,19198)

# Prediction on data train 
predictions_train = fitted(model.svr)
actual = train$Sales
l <- abs(min(min(actual), min(predictions_train)))
acc <- calc_accuracy(predictions_train, actual, l)
print(acc)

# Prediction for data test
test = data_dummy[19199 : 23931, ]
predictions = predict(model, test, se.fit = TRUE)

# Saving file submisstion
data_submisstion <- read.csv("201310072112-DSM_Submissions.csv",stringsAsFactors = FALSE)
save_file_submisstion(predictions, data_submisstion)




