create_project PRNG ./vivado -part xcku15p-ffva1156-2-e -force

add_files -norecurse {PkgPRNG.vhd Xoshiro.vhd Testbench.vhd xilinx-vivado-constraint.xdc}
update_compile_order -fileset sources_1

set_property file_type {VHDL 2008} [get_files *.vhd]
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE AreaOptimized_high [get_runs synth_1]

set_property top Testbench64bit [current_fileset]

launch_runs impl_1 -jobs 12

wait_on_run impl_1
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -routable_nets -name timing_1
report_utilization -name utilization_1
