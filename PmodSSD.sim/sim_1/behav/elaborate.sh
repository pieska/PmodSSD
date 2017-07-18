#!/bin/bash -f
xv_path="/home/pharaoh/Xilinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 032a148f09fa4b5b8d464a7245df5d5b -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot controller_tb_behav xil_defaultlib.controller_tb -log elaborate.log
