library(dplyr)

### Create a column according to whether assessments were referred by criminal justice or not
### Create another column dichotomyzing the assessment's outcome

df2 <- synthetic_assessments31 |>
  mutate(group = case_when(
    referral_source %in% c("Police", "PL", "Probation") ~ "criminal_justice",
    referral_source %in% c("Self", "Hospital", "GP") ~ "non_criminal"
  )) |>
  mutate(outcome_binary = case_when(
    outcome == "Completed" ~ 1,
    outcome %in% c("DNA", "Rearranged") ~ 0
  ))        

# Contingency table and chi squared
table(df$group, df$outcome_binary)
chisq.test(table(df$group, df$outcome_binary)) # there is an association between assesment's attendance and group

# But.. how does the referred criminal justice group affect the odds of completion?
# Logistic regresion

model <- glm(outcome_binary ~ group, data = df, family = binomial)
summary(model)

# log-odds -> odds ratios
exp(coef(model))  # non criminal group has 2.94 times the odds of completion compared to criminal group 

# Table with overall results
OR  <- exp(coef(model))
CI  <- exp(confint(model)) # 95% confidence interval

results <- cbind(OR, CI)
results  # clients referred through criminal services had significantly lower odds of completing assesment

