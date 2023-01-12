#####Install and load libraries
#1. Install pacman
install.packages("pacman")
#2. Load all the needed packages via the pacman p_load function
pacman::p_load(ggplot2, gapminder)

####Take a first look at the gapminder dataset
gapminder

####Aesthetic mappings 
#ggplot2: Plot wird schichtweise aufgebaut!!!
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + 
  geom_point() 
#geom_point() erzeugt einen scatter-plot
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + ## Applicable to all geoms
  geom_point(aes(size = pop, col = continent), alpha = 0.3) ## Applicable to this geom only

#Speichere Grundstruktur des Plots separat ab
p = ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))
p

p + 
  geom_point(aes(size = pop, col = continent), alpha = 0.3)  +
  geom_smooth(method = "loess") #fittet eine kurve an daten

#Plotten einer Wahrscheinlichkeitsdichtefunktion
ggplot(data = gapminder) + ## i.e. No "global" aesthetic mappings"
  geom_density(aes(x = gdpPercap, fill = continent), alpha=0.3)

#Build your plot in layers
p2 =
  p +
  geom_point(aes(size = pop, col = continent), alpha = 0.3) +
  scale_color_brewer(name = "Continent", palette = "Set1") + ## Different colour scale
  scale_size(name = "Population", labels = scales::comma) + ## Different point (i.e. legend) scale
  scale_x_log10(labels = scales::dollar) + ## Switch to logarithmic scale on x-axis. Use dollar units.
  labs(x = "Log (GDP per capita)", y = "Life Expectancy") + ## Better axis titles
  theme_minimal() ## Try a minimal (b&w) plot theme

#Some more advanced plots
if (!require("pacman")) install.packages("pacman")
pacman::p_load(hrbrthemes, gganimate)
p2 + theme_modern_rc() + geom_point(aes(size = pop, col = continent), alpha = 0.2)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')