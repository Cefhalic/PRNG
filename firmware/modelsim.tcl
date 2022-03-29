# ModelSim script for testing int64 prng

file mkdir ./modelsim/libs/msim
cd modelsim

vlib libs/work
vlib libs/msim

vlib libs/msim/lib
vmap lib libs/msim/lib

vcom -2008 -work lib ../PkgPRNG.vhd \
                     ../Xoshiro.vhd

vsim -t fs -g/Xoshiro256starstar/Debugging=true -voptargs="+acc" lib.Xoshiro256starstar
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
}

force -freeze sim:/xoshiro256starstar/Clk 1 0, 0 1fs -r 2fs
run -All
