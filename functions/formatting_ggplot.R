library(ggplot2)
library(RColorBrewer)

get_color_list <- function(n) {
  indeces <- c(1, 11, 5, 7, 15, 14, 16, 13, 6, 9, 17, 2, 10, 8, 3, 4, 12, 18)

  if (n > 18) {
    stop("n must be 18 or smaller")
  }
  c(
    "#9E1531",
    "#C66A27",
    "#F3953A",
    "#C9971D",
    "#F9C027",
    "#DDE48A",
    "#97C13A",
    "#64A638",
    "#174E3F",
    "#43ADA8",
    "#3C87EA",
    "#7863A9",
    "#C9CDFF",
    "#1C124A",
    "#6D1C8C",
    "#CF2561",
    "#EC8483",
    "#ECAFC6"
  )[sort(indeces[1:n])]
}


# ggplot theme with panel border

my_theme <- theme(
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
  panel.background = element_blank(),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
  axis.title = element_text(size = 16),
  axis.text = element_text(size = 16, color = "black"),
  axis.line = element_blank(),
  plot.title = element_text(size = 16)
)


divergent_3 <- c("#45a0b5", "#d8f59f", "#f02f02")


hmtheme <- theme(
  axis.text = element_text(size = 16, color = "black"),
  axis.text.y = element_text(face = "italic"),
  axis.text.x = element_text(angle = 90, hjust = 1),
  axis.title = element_blank(),
  panel.background = element_blank(),
  panel.border = element_rect(color = "black", fill = NA),
  axis.ticks = element_blank(),
  strip.background = element_blank(),
  strip.text = element_text(size = 16),
  legend.text = element_text(size = 16),
  legend.title = element_text(size = 16),
  legend.key.width = unit(.2, "cm"),
  legend.ticks.length = unit(c(-.2, 0), "cm"),
  legend.ticks = element_line(linewidth = .2),
  legend.frame = element_rect(linewidth = .2)
)
