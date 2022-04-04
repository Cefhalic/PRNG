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

vsim -t fs -voptargs="+acc" lib.Testbench64bit
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
  view wave
  config wave -signalnamewidth 1
  delete wave *
  add wave sim:/Testbench64bit/Clk
  add wave sim:/Testbench64bit/Reset
  add wave sim:/Testbench64bit/Pull
  add wave -divider
  add wave sim:/Testbench64bit/ResetVal
  add wave -divider
  add wave sim:/Testbench64bit/Data_*
  }

force -freeze sim:/Testbench64bit/Clk        1 0fs, 0 1fs  -r 2fs
force -freeze sim:/Testbench64bit/Reset      1 0fs, 0 1ps  -r 2ps
force -freeze sim:/Testbench64bit/Pull       0 0fs, 1 14fs -r 20fs
force -freeze sim:/Testbench64bit/ResetValIn 1 0fs, 0 13fs -r 29fs
run 4ps

wave zoom full
