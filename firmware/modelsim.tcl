# ModelSim script for testing int64 prng

file mkdir modelsim_lib/msim

vlib modelsim_lib/work
vlib modelsim_lib/msim
# project new ./TestBits xoshiro256

vcom -2008 "PkgPRNG.vhd"
vcom -2008 "Xoshiro.vhd"

vsim -voptargs="+acc" work.Xoshiro256starstar
set NumericStdNoWarnings 1
set StdArithNoWarnings 1

if { ! [batch_mode] } {
  noview *
  view wave
  config wave -signalnamewidth 1

  delete wave *
  add wave *
}

force -freeze sim:/xoshiro256starstar/Clk 1 0, 0 {5 ns} -r 10
run 1us

if { ! [batch_mode] } {
  wave zoom full
} else {
  exit
}

