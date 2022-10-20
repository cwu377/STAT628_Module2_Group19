library(dplyr)
bodyfat <- read.csv('BodyFat.csv')

bodyfat_out <- bodyfat %>% 
  subset(bodyfat$BODYFAT >= 4 & bodyfat$BODYFAT <= 40 & bodyfat$WEIGHT < 300 & bodyfat$HEIGHT > 50 & bodyfat$ANKLE <= 30 & bodyfat$WRIST <= 21) %>% 
  select(-ADIPOSITY, -IDNO, -DENSITY) %>% mutate(HEIGHT = HEIGHT * 2.54, WEIGHT = WEIGHT*2.2)


write.csv(bodyfat_out, 'bodyfat_out.csv')
