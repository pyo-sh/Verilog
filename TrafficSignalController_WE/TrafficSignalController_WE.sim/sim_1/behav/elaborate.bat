@echo off
set xv_path=D:\\Xilinx2014\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto c831cca5eb7943fc9b170e864ca9681e -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot TrafficSignalController_WETb_behav xil_defaultlib.TrafficSignalController_WETb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
