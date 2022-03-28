# ModelSim script for testing int64 prng

file mkdir modelsim_lib/msim

vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/lib
vmap lib modelsim_lib/msim/lib

vcom -2008 -work lib PkgPRNG.vhd Xoshiro.vhd Top.vhd

vsim -t fs -voptargs="+acc" lib.Top
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
  view wave
  config wave -signalnamewidth 1
  delete wave *
  add wave *
}

force -freeze sim:/Top/Clk   1 0fs, 0 1fs -r 2fs
force -freeze sim:/Top/Reset 1 0fs, 0 1ps -r 2ps
force -freeze sim:/Top/Pull  0 0fs , 1 14fs -r 20fs
run 4ps

wave zoom full
