# The probability that a woman has breast cancer is 1% ("prevalence")

# If a woman has breast cancer, the probability that she tests positive is 90% ("sensitivity")

# If a woman does not have breast cancer, the probability that she nevertheless tests positive 
#is 9% ("false alarm rate")
# 
# In one session, almost half the group of 160 gynaecologists responded that the 
# woman's chance of having cancer was nine in 10.” [21% chose the right answer.]

total = 1000

BC = 0.01*total
print(BC)
n_BC = 0.99*total

df = data.frame('breast cancer'=c(0.9*BC,0.1*BC),'no breast cancer'=c(0.09*n_BC,0.91*n_BC))
row.names(df) <- c('positive','negative')
df$total = c(sum(df['positive',]),sum(df['negative',]))
df['total',] = c(sum(df$breast.cancer),sum(df$no.breast.cancer),sum(df$total))
write.csv(df,file='/Users/JoshuaLevy/Desktop/Coding/R_scripts_LMC/output.csv')
