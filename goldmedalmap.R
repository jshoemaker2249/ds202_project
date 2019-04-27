golds <- athlete_events %>% filter(Medal == "Gold")
g <- golds %>% group_by(Team) %>% summarise(numGolds = n())


test <- g
write.csv(test, "goldmedals.csv")

golds_final <- read_csv("goldmedals_final.csv", col_types = cols(X1 = col_skip()))

countries <- map_data('world')
merged <-  right_join(golds_final, countries, by= c("Team"="region"))
library(ggplot2)
p <- ggplot(merged, aes(x=long, y=lat, fill= numGolds)) + geom_polygon(aes(group=group)) + geom_path(aes(group=group)) + xlab("Longitude") + ylab("Latitude") 
p <- p + scale_fill_continuous(low='white', high='red', na.value='grey') + labs(fill= "Number of Gold Medals")
p 
