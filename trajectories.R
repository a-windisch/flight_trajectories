##################################################
##        Flight Trajectory Analysis            ##
##                    2018                      ##
## Andreas Windisch, andreas.windisch@yahoo.com ##
##################################################
setwd("/home/andreas/GitHub/flight_trajectories/")



#load flight data and get relevant columns
flt1<-read.csv("C152_N53398_KCPS_to_KSLO_2017-10-29.csv")
flt2<-read.csv("DA20-C1_N107TX_KSUS_to_1H3_2018-07-17.csv")
flt3<-read.csv("DA20-C1_N107TX_KSUS_to_KMYJ_2018-09-15.csv")
dat1<-flt1[,c(6,7,8,9,19)]
dat2<-flt2[,c(6,7,8,9,19)]
dat3<-flt3[,c(6,7,8,9,19)]
names(dat1) <- c("lat","lon","alt","spd","hdg")
names(dat2) <- c("lat","lon","alt","spd","hdg")
names(dat3) <- c("lat","lon","alt","spd","hdg")

#landing 1 start and end indices (empirically) 
ls1 <- 2580
le1 <- 2622
ldg1data <- dat1[ls1:le1,]

#load leaflet
library(leaflet)
library(mapview)


#create plots for flt1
fullmap1 <- leaflet(dat1) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)

mapshot(fullmap1,file="flight1_map.png")


ldgmap1 <- leaflet(ldg1data) %>% 
            addTiles() %>%
            addCircles(~lon, ~lat, weight = 3, radius=40, color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(ldgmap1,file="landing1_map.png")

#create plots for flt2
fullmap2 <- leaflet(dat2) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(fullmap2,file="flight2_map.png")

#create plots for flt3
fullmap3 <- leaflet(dat3) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(fullmap3,file="flight3_map.png")
