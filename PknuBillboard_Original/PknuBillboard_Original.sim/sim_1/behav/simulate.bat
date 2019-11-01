@echo off
set xv_path=D:\\Xilinx2014\\Vivado\\2014.4\\bin
call %xv_path%/xsim PknuBillboard_OriginTb_behav -key {Behavioral:sim_1:Functional:PknuBillboard_OriginTb} -tclbatch PknuBillboard_OriginTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
