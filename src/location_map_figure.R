#!/usr/bin/env Rscript

library(data.table)
library(ggmap)

# wgs84_loc <- fread("data/manual_locations_with_wgs84.csv")
wgs84_loc <- fread("data/manual_locations_with_wgs84.csv")[location != "Reefton"]
wgs84_loc[, loc_code := paste0(location, " (", code, ")")]
setorder(wgs84_loc, -lat)
wgs84_loc[, loc_code := factor(loc_code, levels = rev(loc_code))]
wgs84_loc[, code_loc := paste0(code, " (", location, ")")]
wgs84_loc[, paste(code_loc, collapse = ", ")]

# prepare a plot
if(!file.exists("data/nz_map.Rds")) {
    nz <- get_googlemap(center = "Wellington NZ",
                        zoom = 5,
                        scale = 2,
                        maptype = "terrain",
                        style = "element:labels|visibility:off")
    saveRDS(nz, "data/nz_map.Rds")
} else {
    nz <- readRDS("data/nz_map.Rds")
}



# plot
bbox = c(165,-47.5,180,-35)
lon_bump <- 0.25
lat_bump <- 0.025

gp <- ggmap(nz) +
    theme_minimal(base_size = 8) +
    theme(legend.key.size = unit(0.5, "lines")) +
    xlim(c(165, 180)) + xlab(NULL) +
    ylim(c(-47, -35)) + ylab(NULL) +
    geom_point(mapping = aes(x = lon,
                             y = lat,
                             colour = loc_code),
               # shape = 16,
               size = 0.8,
               data = wgs84_loc) +
    geom_text(mapping = aes(x = lon + lon_bump,
                            y = lat - lat_bump,
                            label = toupper(location),
                            colour = loc_code),
              size = 2,
              hjust = "left",
              vjust = 0.5,
              data = wgs84_loc,
              fontface = "bold") +
    geom_text(mapping = aes(x = lon - lon_bump,
                            y = lat - lat_bump,
                            label = n,
                            colour = loc_code),
              size = 2,
              hjust = "right",
              vjust = 0.5,
              data = wgs84_loc,
              fontface = "bold") +
    scale_color_viridis_d(guide = FALSE)

# gp + xlab("Longitude") + ylab("Latitude")

wo <- grid::convertUnit(unit(483 * (7/16), "pt"), "mm", valueOnly = TRUE)
ho <- grid::convertUnit(unit(483 * (1/2), "pt"), "mm", valueOnly = TRUE)
ggsave(
    "fig/location_map.pdf",
    gp + xlab("Longitude") + ylab("Latitude"),
    width = wo,
    height = ho,
    unit = "mm",
    device = cairo_pdf)

saveRDS(gp, "fig/location_map.Rds")
