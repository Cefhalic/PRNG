#add wave *


# add wave top/DUT/*
# add wave -divider
# add wave top/Flt/*
add wave top/data_star
add wave top/float_star

run 100ns
wave zoom full