library(here)
library(magick)
library(tweenr)
library(dplyr)

# setup
data_path <- here("data")
png_files <- list.files(data_path, pattern = "\\.png$", full.names = TRUE)
images <- image_read(png_files)
num_frames <- length(images)
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
morphed_images <- images[1]
frame_delay <- 12  # 100 ms divided by fps (10 fps = 100ms per frame)

for (i in seq_len(length(images) - 1)) {
  start <- images[i]
  end <- images[i + 1]
  transition_frames <- image_morph(c(start, end), frames = 5)
  morphed_images <- c(morphed_images, transition_frames[-1])  # Exclude duplicate start frame
}

gif <- morphed_images %>%
  image_animate(delay = frame_delay, loop = 0) %>%
  image_resize("800x800")  # Resize for consistency

# Save the GIF
output_path <- here("data", "smooth_transition.gif")
image_write(gif, output_path)

cat("GIF created and saved to:", output_path, "\n")
