# ModelSim script for testing int64 prng

file mkdir modelsim_lib/msim

vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/top
vmap top modelsim_lib/msim/top

vcom -2008 -work top PkgPRNG.vhd Xoshiro.vhd

vsim -g/Xoshiro256starstar/debug=true  -voptargs="+acc" top.Xoshiro256starstar
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
}

force -freeze sim:/xoshiro256starstar/Clk 1 0, 0 1 -r 2
run -All

