bodayfat2 <- read.csv('bodyfat2.csv')
bodayfat3 <- read.csv('bodyfat3.csv')
lm3 <- lm(BODYFAT ~ ABDOMEN, bodayfat3)
summary(lm3)

BodyFat_reference <- data.frame(
  Description = c("Essential fat", "Athletes", "Fitness", "Average", "Obese"),
  Women = c("10-13%", "14-20%", "21-24%", "25-31%", "32+%"),
  Men = c("2-5%", "6-14%", "14-17%", "18-24%", "25+%"))

write.csv(BodyFat_reference, "Body_Fat_Calculator/BodyFat_reference.csv")
