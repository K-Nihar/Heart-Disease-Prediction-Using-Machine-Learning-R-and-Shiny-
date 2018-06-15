## Server Logic To Define
source("svm.R")

library(shiny)
#library(sqldf)
library(e1071)
#require(gsubfn)
# require(proto)
# require(RSQLite)
#require(reshape2)
#install.packages("sqldf")

# Define server logic required
shinyServer(function(input, output) {
  
  
  observeEvent(input$pred,{
    
    output$Heartresult <- renderText({
      
      age <- as.numeric(as.character(input$ageinpt))
      
      sex <- factor(input$gender, levels = c(0, 1))
      
      chestpaintype <- factor(input$cp, levels = c(1,2,3,4))
      
      restingbp <- as.numeric(as.character(input$restingbp))
      
      cholestrol <- as.numeric(as.character(input$cholestrol))
      
      fastingbloodsugar <- factor(input$fastingbp, levels = c(0,1))
      
      electrocardiographic <- factor(input$restcg, levels = c(0, 1,2))
      
      maximumheartrate <- as.numeric(as.character(input$maxheartrate))
      
      exerciseangina<- factor(input$exang, levels = c(0, 1))
      
      oldpeak <- as.numeric(as.character(input$oldpeak))
      
      slopeofpeakexercise <- factor(input$slope, levels = c(1,2,3))
      
      ca <- factor(input$ca, levels = c( 0,1,2,3))
      
      thal <- factor(input$thal, levels = c( 3,6,7))
      
       valVector <- list(age,sex,chestpaintype,restingbp,cholestrol,fastingbloodsugar,electrocardiographic,maximumheartrate,exerciseangina,oldpeak,slopeofpeakexercise,ca,thal)
      # 
      HeartTestDataMatrix <- as.matrix(valVector,nrow(1),ncol(12),colnames("Age","Sex","chesp.pain.type","resting.bp","cholestrol","fasting.blood.sugar","electrocardiographic","max.heart.rate","exercise.induced.angina","oldpeak","slope.of.peak.exercise","ca","thal"))
      
      
      
     HeartTestData <- data.frame(HeartTestDataMatrix)
      write.csv(HeartTestData, file="hearttestData.csv", row.names = FALSE)

      csvTestData <- read.csv("hearttestData.csv")

      db<-dbConnect(SQLite(), dbname="diseasedb")

      sqldf("attach 'diseasedb' as new")


      dbWriteTable(conn = db, name = "Heart", value = csvTestData , row.names= FALSE, header = FALSE, append = TRUE)

      HeartDiseaseData <- dbReadTable(db,"Heart")

       namesFactor <- c(2:3,6:7,9,11:13)
      #
       namesNumeric <- c(1,4:5,8,10)
      #
       HeartTestData[,namesNumeric] <- lapply(HeartTestData[,namesNumeric], as.numeric)
       HeartTestData[,namesFactor] <- lapply(HeartTestData[,namesFactor], as.factor)

      HeartTestData <- tail(HeartDiseaseData,1)
      Heartmodel <- svm(formula = num ~ .,
                        data = HeartDiseaseData,
                        type = 'C-classification',
                        kernel = 'linear')
       Heartresult <- predict(Heartmodel,HeartTestData)
     svm1(HeartTestDataMatrix)
    })
    
    
    #output$Heartresult<-renderText(svm1(HeartT))
    # HeartTestData <- data.frame("Age" = age, "Sex" = sex, "chesp.pain.type" = chestpaintype,
    #                             "resting.bp" = restingbp, "cholestrol" = cholestrol,
    #                             "fasting.blood.sugar" = fastingbloodsugar, "electrocardiographic" = electrocardiographic,
    #                             "max.heart.rate" = maximumheartrate, "exercise.induced.angina" = exerciseangina,
    #                             "oldpeak" = oldpeak, "slope.of.peak.exercise" = slopeofpeakexercise, "ca" = ca, "thal" = thal)
    
    
  })
  
  
  
  
  
  
  # ds <- c(output$Age)
  # df <- data.frame(ds)
  
  #observeEvent(input$pred,{output$Heartresult <- renderText(svm1(HeartT))})
  observeEvent(input$accc,{output$accuracy1 <- renderText(accuracy())})
  
}

)

