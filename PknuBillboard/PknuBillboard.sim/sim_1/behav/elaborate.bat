@echo off
set xv_path=D:\\Xilinx2014\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 6664752fec1d45ff84ed5d3081c7894d -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot PknuBillboardTb_behav xil_defaultlib.PknuBillboardTb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
