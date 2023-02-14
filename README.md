# The efficacy of a new drug against a disease

A randomized clinical trial was carried out with the purpose of testing the efficacy of a new drug against a disease. 1,554 male and female patients were randomly assigned to one of two treatments (i.e., new drug and placebo). The outcome was severity of the disease determined at two follow-up visits, approximately six or twelve months after the beginning of treatment. To explore the treatment effects of this new drug, we mainly applied marginal modeling for repeated ordinal data with treatment (i.e., new drug and placebo), gender (i.e., male and female), occasion (i.e., months 12 and months 6) and initial severity (i.e., severity 2 or 3) as covariates. 

We fitted a *saturated* model with all potential interactions, obtained a reduced model using backward selection (p-value < 0.05), checked the *proportionality* and refitted this reduced model. We conclude that under most situations, significant differences exist between patients’ response to these two treatments. Comparing patients at months 12 with those at months 6 after treatment, under most situations, we can observe a significantly increasing odds of getting less severe disease, which means a significantly overall improvement over time. The rate of improvement over time from months 6 to months 12 after treatment ranges from 1.69 to 5.17 per 6 months depending on initial severity (i.e., severity 2 or 3), gender (i.e., male and female) and cumulative proportional odds (i.e., cumulative odds of severity equal to 2 and 1). The odds of getting this overall improvement over time for males is also significantly higher than that for females (odds ratio: 1.76, p-value: 0.0011, 95% CI: 1.25-2.46).

## Files

- `Categorical Data Analysis.sas`

  - Summary statistics by treatment and gender at baseline
  - Summary statistics by treatment and gender after 6 follow-up months and 12 follow-up months
  - Marginal modeling for repeated ordinal data
