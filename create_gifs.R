library(here)
library(magick)
library(tweenr)
library(dplyr)

# setup
data_path <- here("data")
png_files <- list.files(data_path, pattern = "\\.png$", full.names = TRUE)
images <- image_read(png_files)
total_duration <- 20

# simple gif ####
frame_delay <- total_duration / num_frames * 100 # in centiseconds

gif <- images %>%
  image_animate(delay = frame_delay, loop = 0) %>%
  image_resize("800x800")  # Optional: resize for consistency

gif_path <- here("data", "steph_curry_shot_charts.gif")
image_write(gif, path = gif_path)
cat("GIF created and saved as", gif_path)


# alternate version with transitions ####
