@echo off
set xv_path=D:\\Xilinx2014\\Vivado\\2014.4\\bin
call %xv_path%/xsim decoder_3_to_8_behav -key {Behavioral:sim_1:Functional:decoder_3_to_8} -tclbatch decoder_3_to_8.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
