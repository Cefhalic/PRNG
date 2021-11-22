PACKAGE_PATH = $(shell pwd)

TESTBENCH = ./TestBench.vhd \
            ./Modelsim.udo

INCLUDE_PATHS = \
  ../../RuflCore/firmware/hdl
  
include $(shell python -c "import os.path; print(os.path.abspath('../../RuflCore/config/mfRules.mk'))")
