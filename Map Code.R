cat("\014") 
rm(list=ls())

library("ggplot2")
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("ggspatial")
library("sf")

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

world_points<- st_centroid(world)
world_points <- cbind(world, st_coordinates(st_centroid(world$geometry)))

p<- ggplot(data = world) +
  geom_sf(color = "blue",size = 1) +
  annotate(geom = "text", x = -75.2, y = 39.15, label = "Delaware Bay", 
           fontface = "bold", color = "darkgreen", size = 3) +
  annotate(geom = "text", x = -74.4, y = 39.1, label = "Atlantic Ocean", 
           fontface = "bold", color = "darkgreen", size = 3) +
  coord_sf(xlim = c(-75.7, -74), ylim = c(39, 40.5), expand = FALSE)
p<-p + labs(x = "Latitude",y="Longtitude")
p<-p + labs(title = "Delaware Bay Map")
p<-p+theme_bw() +
  theme(panel.background = element_rect(fill = "aliceblue"),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_line(color = "white", size = 0.8))
p<- p + theme(axis.title.x = element_text(colour = "black"),
              axis.title.y = element_text(colour = "black"))
show(p)
ggsave("C:/Users/ahowlader/Desktop/map.pdf")
ggsave("C:/Users/ahowlader/Desktop/mapmap_web.png", width = 6, height = 6, dpi = "screen")