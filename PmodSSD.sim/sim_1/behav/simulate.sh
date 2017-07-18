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
ExecStep $xv_path/bin/xsim controller_tb_behav -key {Behavioral:sim_1:Functional:controller_tb} -tclbatch controller_tb.tcl -log simulate.log
