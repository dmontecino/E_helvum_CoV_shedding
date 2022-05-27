library(rnaturalearthdata)
library(rnaturalearth)
library(ggmap)
library(ggspatial)
library(sf)
library(dplyr)
library(maps)
library(cowplot)
library(magick)
library(egg)


world <- ne_countries(scale = "large", returnclass = "sf")

africa <- world%>%filter(continent=="Africa")

tanzania.ghana <- world%>%filter(name_vi%in%c("Tanzania", "Ghana"))
  

#data(world.cities)

accra.morogoro<-world.cities%>%
  filter(name%in%c("Accra", "Morogoro"))%>%
  select(long, lat, name)%>%
  st_as_sf(coords = c("long", "lat"), crs = 4326, agr = "constant")


#PLot
 main.plot= ggplot() + 
  geom_sf(data= africa, fill="white", color="white", lwd=0.2) +
  geom_sf(data = tanzania.ghana, fill="grey80", color="grey70", lwd=0.2) +
  geom_sf(data = accra.morogoro, size = 3, shape = 21, color=alpha("tomato", 0), fill=alpha("red", 0.9), inherit.aes = FALSE) +
  geom_sf_text(data = accra.morogoro, 
               aes(label=name), hjust="left", nudge_x = 1.5, size=5) +
  annotation_scale(location = "bl", width_hint = 0.6) +
  theme(panel.background = element_rect(fill = 'light blue', colour = NA),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(), 
        plot.margin=margin(0,0,0,0, "cm"),
        panel.border=element_blank(), 
        panel.spacing = unit(0, "cm"),
        axis.line=element_blank())
  
# morogoro and accra colonies
 
 # Example with PNG (for fun, the OP's avatar - I love the raccoon)
 accra.picture=ggdraw() +
   draw_image("accra.jpeg") #+
 # draw_plot(my_plot)
 morogoro.picture=ggdraw() +
   draw_image("Morogoro.png") #+
 

 figure1=
 grid.arrange(
   grobs = list(accra.picture, morogoro.picture, main.plot),
   widths = c(0.8,1.3),
   heights = c(1, 1),
   layout_matrix = rbind(c(1, 3),
                         c(2, 3))
 )

figure1 #test

ggsave(file="figure1.tiff", figure1)


