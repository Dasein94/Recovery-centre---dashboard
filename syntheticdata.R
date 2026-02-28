
# ===============================
# 1. Packages
# ===============================


library(charlatan)
library(dplyr)
library(tidyr)
library(lubridate)

set.seed(123)

# ===============================
# 2. Creating clients (random number)
# ===============================

n_clients <- 320
target_assessments <- 764

clients <- data.frame(
  client_id = 1:n_clients,
  name = ch_name(n_clients)
) # ch_name() is a function from charlatan to have fake names

# ===============================
# 3. Assigning assesments per client (as they often don't attend and then need another assesment date)
# ===============================

assessments_per_client <- sample(
  1:4,
  size = n_clients,
  replace = TRUE,
  prob = c(0.5, 0.3, 0.15, 0.05)
) # up to 4 times max, replace = True because you want to continue assigning 1-4 assessments to the rest of the clients. You also weight probabilities to have only 1 assessment (50%), 2(30%)...

# Adjust assessments per client to 764 (scaling to the target assessment number)
assessments_per_client <- round(
  assessments_per_client * target_assessments / sum(assessments_per_client)
) # the division is 764/new value, which is almost 1 (little difference), and then you multiply by random assessment number value created and round it

difference <- target_assessments - sum(assessments_per_client) # it wont be a perfect 764 so you calculate how far you are from the target

while(difference != 0){
  i <- sample(1:n_clients, 1) # pick a random client
  if(difference > 0){
    assessments_per_client[i] <- assessments_per_client[i] + 1
    difference <- difference - 1
  } else if(assessments_per_client[i] > 1){
    assessments_per_client[i] <- assessments_per_client[i] - 1
    difference <- difference + 1
  }
}  # while loop: if the difference is not 0 --> if the difference 
# is more than 0, iterate +1 (you need more assessments to reach target), and update -1 the difference
# Otherwise, we need less assessments, so if the random client picked 
# had more than one assessment, substract one.
# the logic enforces that every client has at least one assessment 

clients$n_assessments <- assessments_per_client  # update

# ===============================
# 4. Expanding from client level to assessment level (increasing rows)
# ===============================

dataset <- clients %>%
  uncount(n_assessments) %>%
  group_by(client_id) %>%
  mutate(assessment_number = row_number()) %>%
  ungroup()

# Break down by rows the assessment number for every client
# ===============================
# 5. Dates 
# ===============================

months_seq <- seq(
  as.Date("2024-10-01"),
  as.Date("2026-11-01"),
  by = "month"
)

dataset$assessment_date <- sample(
  months_seq,
  size = nrow(dataset),
  replace = TRUE
)

# List the assessments by chronological order
dataset <- dataset %>%
  arrange(client_id, assessment_date)

# ===============================
# 6. REFERRAL SOURCE
# ===============================

dataset$referral_source <- sample(
  c("GP","Self","Hospital","PL","Police","Probation"),
  size = nrow(dataset),
  replace = TRUE,
  prob = c(0.30,0.20,0.15,0.10,0.10,0.15)
)

# ===============================
# 7. Substance
# ===============================

dataset$substance <- sample(
  c("Alcohol", "Opiates", "Cocaine", "Cannabis"),
  size = nrow(dataset),
  replace = TRUE,
  prob = c(0.5, 0.2, 0.15, 0.15)
)
# ===============================
# 8. OUTCOME according to client and chronology
# ===============================

dataset <- dataset %>%
  group_by(client_id) %>%
  arrange(assessment_date) %>%
  mutate(outcome = {
    
    outcomes <- character(n()) # creating a vector to store outcomes. n() -> number of assessments of a client, 
    # and charachter(n()) is the vector of the length that will be set by the loop later
    
    for(i in 1:n()){      # for loop - i --> current assessment
      
      ref <- referral_source[i]
      
      if(i == 1){
        
        # first assessment
        
        if(ref == "PL"){
          outcomes[i] <- sample(c("DNA","Rearranged"),
                                1,
                                prob = c(0.8,0.2))
          
        } else if(ref == "Probation"){
          outcomes[i] <- sample(c("Completed","Rearranged","DNA"),
                                1,
                                prob = c(0.5,0.3,0.2))
          
        } else if(ref == "Police"){
          outcomes[i] <- sample(c("DNA","Rearranged","Completed"),
                                1,
                                prob = c(0.6,0.2,0.2))
          
        } else {
          outcomes[i] <- sample(c("Completed","DNA","Rearranged"),
                                1,
                                prob = c(0.6,0.25,0.15))
        }  #setting probabilities according to referral source to complete first assessment
        
      } else {
        
        # if Rearranged, high chance for next assessment to be Completed
        
        if(outcomes[i-1] == "Rearranged"){
          outcomes[i] <- sample(c("Completed","DNA"),
                                1,
                                prob = c(0.7,0.3))
          
        } else {  # the following code sets the prob according to referral source again 
          
          if(ref %in% c("PL")){
            outcomes[i] <- sample(c("DNA","Completed"),
                                  1,
                                  prob = c(0.7,0.3))
            
          } else if(ref == "Probation"){
            outcomes[i] <- sample(c("Completed","Rearranged","DNA"),
                                  1,
                                  prob = c(0.6,0.25,0.15))
            
          } else {
            outcomes[i] <- sample(c("Completed","DNA","Rearranged"),
                                  1,
                                  prob = c(0.6,0.25,0.15)) #non-criminal
          }
        }
      }
    }
    
    outcomes
  }) %>%
  ungroup()





