# ModelSim script for testing int64 prng

file mkdir ./modelsim/libs/msim
cd modelsim

vlib libs/work
vlib libs/msim

vlib libs/msim/lib
vmap lib libs/msim/lib

vcom -2008 -work lib ../PkgPRNG.vhd \
                     ../Xoshiro256float.vhd

vsim -t fs -g/Xoshiro256double/Debugging=true -voptargs="+acc" lib.Xoshiro256double
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
}

force -freeze sim:/Xoshiro256double/Clk   1 0fs, 0 1fs -r 2fs
run -All
