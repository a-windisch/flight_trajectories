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

#taxiing 2 start and end indices (empiricallY)
ts2 <- 110800
te2 <- 126500
taxi2data <- dat2[ts2:te2,]

#load leaflet
library(leaflet)
library(mapview)
library(geosphere)


#create plots for flt1
fullmap1 <- leaflet(dat1) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)

mapshot(fullmap1,file="flight1_map.png")


ldgmap1 <- leaflet(ldg1data) %>% 
            addTiles() %>%
            addCircles(~lon, ~lat, weight = 3, radius=20, color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(ldgmap1,file="landing1_map.png")


#calculating the distance form the touch-down point
#for this procedure I followed a blog post by Mark Needham, 
#markhneedham.com
tmpcol1 <- rep(tail(ldg1data$lon,n=1),length(ldg1data$lat))
tmpcol2 <- rep(tail(ldg1data$lat,n=1),length(ldg1data$lat))
ldg1coords <- ldg1data[,c(2,1)]
ldg1touchdown <- data.frame(tmpcol1,tmpcol2)
ldg1dist <- by(ldg1coords,1:nrow(ldg1coords),function(row) { distm(c(row$lon,row$lat),ldg1touchdown[1,]) })
ldg1fit  <- lm(ldg1data$alt~ldg1dist)

#create the plot 
png(filename = "ldg1.png",width = 640, height = 480)
plot(x=ldg1dist,y=ldg1data$alt,main="Descent on final approach RW18, KSLO",xlab="dist from touch down point [m]", ylab = "altitude [m MSL]")
abline(ldg1fit,col="red")
dev.off()

#create plots for flt2
fullmap2 <- leaflet(dat2) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(fullmap2,file="flight2_map.png")

taximap2 <- leaflet(taxi2data) %>% 
   addTiles() %>%
   addCircles(~lon, ~lat, weight = 3, radius=1, 
              color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(taximap2,file="taxi2_map.png")


#create plots for flt3
fullmap3 <- leaflet(dat3) %>% 
    addTiles() %>%
    addCircles(~lon, ~lat, weight = 3, radius=40, 
               color="#ff0000", stroke = TRUE, fillOpacity = 0.8)
mapshot(fullmap3,file="flight3_map.png")
