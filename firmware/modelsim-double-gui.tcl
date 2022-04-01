# ModelSim script for testing int64 prng

file mkdir ./modelsim/libs/msim
cd modelsim

vlib libs/work
vlib libs/msim

vlib libs/msim/lib
vmap lib libs/msim/lib

vcom -2008 -work lib ../PkgPRNG.vhd \
                     ../Xoshiro.vhd \
                     ../Testbench.vhd

vsim -t fs -voptargs="+acc" lib.TestbenchDouble
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
  view wave
  config wave -signalnamewidth 1
  delete wave *
  add wave sim:/TestbenchDouble/Clk
  add wave sim:/TestbenchDouble/Reset
  add wave sim:/TestbenchDouble/Pull
  add wave -divider
  add wave sim:/TestbenchDouble/ResetVal
  add wave -divider
  add wave -radix float64 sim:/TestbenchDouble/Data_*
}

force -freeze sim:/TestbenchDouble/Clk        1 0fs, 0 1fs  -r 2fs
force -freeze sim:/TestbenchDouble/Reset      1 0fs, 0 1ps  -r 2ps
force -freeze sim:/TestbenchDouble/Pull       0 0fs, 1 14fs -r 20fs
force -freeze sim:/TestbenchDouble/ResetValIn 1 0fs, 0 13fs -r 29fs
run 4ps

wave zoom full
