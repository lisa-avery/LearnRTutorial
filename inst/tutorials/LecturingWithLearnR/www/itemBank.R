# varInfo a dataframe with columns as follows:
# -Variable string name of variable
# Population a string describing the target population
# Mean numeric, the mean of the variable in the target population
# SD numeric, the SD of the variable in the target population
# dp integer, the number of decimals to display the results to
createQuiz <- function(varInfo){
  # Choose one variable to refer to all questions
  i <- sample(1:nrow(varInfo),1)

  # Information for all related questions - note the use of '\\\\' for math
  intro <- paste0('Assume that the distribution of ',varInfo$Variable[i],' for ',varInfo$Population[i],
                  ' follows a Normal distribution with mean ($\\\\mu$) of ',varInfo$Mean[i],
                  " and standard deviation ($\\\\sigma$) of ",varInfo$SD[i],'.')

  # Questions and answers
  Questions <- NULL

  # Question : percentage of population above a value
  x <- round(rnorm(1,mean=varInfo$Mean[i],sd = varInfo$SD[i]),varInfo$dp[i])
  Questions[['p_above']]$Question <- paste0('What percentage of ',varInfo$Population[i],' have ',
                                           varInfo$Variable[i],' values above ',x,'?')
  zscore = (x-varInfo$Mean[i])/varInfo$SD[i]
  p_above = rnd(100*pnorm(zscore,lower.tail = FALSE),0)
  # Need more wrong answers here
  Ans <- data.frame(text=paste0(p_above,'%'),correct = T)
  Ans <- dplyr::bind_rows(Ans,
                          data.frame(text=paste0(rnd(100*pnorm(zscore,lower.tail = TRUE),0),'%'),
                                     message='This is the proportion with values below the value of interest.'))

  z_wrong = c((x+varInfo$Mean[i])/varInfo$SD[i],(x-varInfo$Mean[i])/varInfo$SD[i]^2)
  for (z in z_wrong){
    Ans <- dplyr::bind_rows(Ans,
                            data.frame(text=paste0(rnd(100*pnorm(z,lower.tail = TRUE),0),'%'),
                                       message = 'Check the z-scores you used, trying drawing a picture.'))
    Ans <- dplyr::bind_rows(Ans,
                            data.frame(text=paste0(rnd(100*pnorm(z,lower.tail = FALSE),0),'%'),
                                       message = 'Check the z-scores you used, trying drawing a picture.'))
  }
  Questions[['p_above']]$Answers = Ans


    # Question : values that define the middle x percent
  p <- mround(runif(1,min=20,max=80),base=5)
  Questions[['middle']]$Question <- paste0('Between what two values do the middle ',p,'% of ',
                                           varInfo$Variable[i],' values lie?')
  zscore = qnorm(.5-p/200,lower.tail = T)
  x_lower = round(zscore*varInfo$SD[i]+varInfo$Mean[i],varInfo$dp[i])
  x_upper = round(abs(zscore)*varInfo$SD[i]+varInfo$Mean[i],varInfo$dp[i])
  Ans <- data.frame(text=paste(x_lower,'and',x_upper),correct = T)
  Ans <- dplyr::bind_rows(Ans,data.frame(text=paste(rnd(zscore,2),'and',rnd(abs(zscore),2)),message = 'These are the z-scores that contain the middle values.'))

  z_wrong = c(qnorm(p/200,lower.tail = T), qnorm(p/100,lower.tail = T),qnorm(1-p/100,lower.tail = T))
  for (z in z_wrong){
    x_lower = round(z*varInfo$SD[i]+varInfo$Mean[i],varInfo$dp[i])
    x_upper = round(abs(z)*varInfo$SD[i]+varInfo$Mean[i],varInfo$dp[i])
    Ans <- dplyr::bind_rows(Ans,data.frame(text=paste(x_lower,'and',x_upper),message = 'Check the z-scores you used, trying drawing a picture.'))
  }
  Questions[['middle']]$Answers = Ans

  # Build the quiz
  write_answers <- function(answers){
    a_str <- character(0)
    for (a in 1:nrow(answers)){
      a_str <- c(a_str, paste0("answer('",answers$text[a],"'",
                               ifelse(is.na(answers$correct[a]),'',paste0(", correct=",Questions[[q]]$Answers$correct[a])),
                               ifelse(is.na(answers$message[a]),'',paste0(", message='",Questions[[q]]$Answers$message[a],"'")),
                               ")"))
    }
    return(paste(a_str,collapse = ","))
  }

  q_str <- paste0("quiz(caption = '",intro,"',")
  for (q in seq_along(Questions)){
    q_str <- paste0(q_str, "question('",Questions[[q]]$Question,"',",collapse = '')
    q_str <- paste0(q_str,write_answers(Questions[[q]]$Answers))
    q_str <- paste0(q_str,")")
  }
  q_str <- paste0(q_str,")")
  return(q_str)
}


# Possible Use: Note, this is a work in progress
# ```{r quiz-test, results='asis',echo=T,eval=F}
# normalVars <- tibble::tribble(
#   ~Variable,~Population,~Mean,~SD,~dp,
#   'body temperature ( in degrees C)','healthy human adults', 36.8, 0.4,1,
#   'IQ', 'Candian adults',100, 15,0,
#   'heart rate (bpm)', 'healthy adults at rest', 66 , 9.7,1,
#   'birth weight (kg)','female babies born at 40 weeks', 3.638, 0.447,3
# )
#
# # Dynamically create a quiz (see R/itemBank.R)
# source('www/helper_functions.R')
# source('www/itemBank.R')
# quiz_text <- createQuiz(normalVars)
#
# # Evaluate it
# eval(parse(text=quiz_text))
#
#
# ```

