
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:kc705:part0:0.92default:default2h
TD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/kintex7/kc705/0.9/board_part.xml2default:default2$
xc7k325tffg900-22default:defaultZ49-26h px
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:kc705:part0:1.02default:default2h
TD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/kintex7/kc705/1.0/board_part.xml2default:default2$
xc7k325tffg900-22default:defaultZ49-26h px
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:kc705:part0:1.12default:default2h
TD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/kintex7/kc705/1.1/board_part.xml2default:default2$
xc7k325tffg900-22default:defaultZ49-26h px
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:zc706:part0:0.92default:default2e
QD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/zynq/zc706/0.9/board_part.xml2default:default2#
xc7z045ffg900-22default:defaultZ49-26h px
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:zc706:part0:1.02default:default2e
QD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/zynq/zc706/1.0/board_part.xml2default:default2#
xc7z045ffg900-22default:defaultZ49-26h px
�
scannot add Board Part %s available at %s as part %s specified in board_part file is either invalid or not available5*board2.
xilinx.com:zc706:part0:1.12default:default2e
QD:/Xilinx2014/Vivado/2014.4/data/boards/board_parts/zynq/zc706/1.1/board_part.xml2default:default2#
xc7z045ffg900-22default:defaultZ49-26h px
~
]hardware handoff file cannot be generated as there is no block diagram instance in the design132*	vivadotclZ4-279h px
�
Command: %s
53*	vivadotcl2S
?synth_design -top TrafficSignalController -part xc7z020clg484-12default:defaultZ4-113h px
7
Starting synth_design
149*	vivadotclZ4-321h px
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7z0202default:defaultZ17-347h px
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7z0202default:defaultZ17-349h px
�
%s*synth2�
rStarting Synthesize : Time (s): cpu = 00:00:06 ; elapsed = 00:00:08 . Memory (MB): peak = 239.488 ; gain = 74.684
2default:defaulth px
�
synthesizing module '%s'638*oasys2+
TrafficSignalController2default:default2�
tD:/Xilinx2014/Workspace/TrafficSignalController/TrafficSignalController.srcs/sources_1/new/TrafficSignalController.v2default:default2
32default:default8@Z8-638h px
I
%s*synth24
 	Parameter S0 bound to: 3'b000 
2default:defaulth px
I
%s*synth24
 	Parameter S1 bound to: 3'b001 
2default:defaulth px
I
%s*synth24
 	Parameter S2 bound to: 3'b010 
2default:defaulth px
I
%s*synth24
 	Parameter S3 bound to: 3'b011 
2default:defaulth px
I
%s*synth24
 	Parameter S4 bound to: 3'b100 
2default:defaulth px
I
%s*synth24
 	Parameter S5 bound to: 3'b101 
2default:defaulth px
O
%s*synth2:
&	Parameter TL_GREEN bound to: 3'b100 
2default:defaulth px
P
%s*synth2;
'	Parameter TL_YELLOW bound to: 3'b010 
2default:defaulth px
M
%s*synth28
$	Parameter TL_RED bound to: 3'b001 
2default:defaulth px
N
%s*synth29
%	Parameter WL_GREEN bound to: 2'b10 
2default:defaulth px
L
%s*synth27
#	Parameter WL_OFF bound to: 2'b00 
2default:defaulth px
L
%s*synth27
#	Parameter WL_RED bound to: 2'b01 
2default:defaulth px
�
%done synthesizing module '%s' (%s#%s)256*oasys2+
TrafficSignalController2default:default2
12default:default2
12default:default2�
tD:/Xilinx2014/Workspace/TrafficSignalController/TrafficSignalController.srcs/sources_1/new/TrafficSignalController.v2default:default2
32default:default8@Z8-256h px
�
%s*synth2�
sFinished Synthesize : Time (s): cpu = 00:00:08 ; elapsed = 00:00:10 . Memory (MB): peak = 273.531 ; gain = 108.727
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
~Finished Constraint Validation : Time (s): cpu = 00:00:08 ; elapsed = 00:00:10 . Memory (MB): peak = 273.531 ; gain = 108.727
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
S
%s*synth2>
*Start Loading Part and Timing Information
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
G
%s*synth22
Loading part: xc7z020clg484-1
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:08 ; elapsed = 00:00:10 . Memory (MB): peak = 273.531 ; gain = 108.727
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2default:default2+
TrafficSignalController2default:defaultZ8-802h px
�
%s*synth2r
^ROM "state" won't be mapped to Block RAM because address size (3) smaller than threshold (5) 
2default:defaulth px
�
%s*synth2r
^ROM "count" won't be mapped to Block RAM because address size (3) smaller than threshold (5) 
2default:defaulth px
�
%s*synth2z
fROM "traffic_light" won't be mapped to Block RAM because address size (3) smaller than threshold (5) 
2default:defaulth px
�
%s*synth2w
cROM "walk_light" won't be mapped to Block RAM because address size (3) smaller than threshold (5) 
2default:defaulth px
�
%s*synth2s
_ROM "state0" won't be mapped to Block RAM because address size (1) smaller than threshold (5) 
2default:defaulth px
g
%s*synth2R
>ROM "state0" won't be mapped to RAM because it is too sparse.
2default:defaulth px
g
%s*synth2R
>ROM "state0" won't be mapped to RAM because it is too sparse.
2default:defaulth px
g
%s*synth2R
>ROM "state0" won't be mapped to RAM because it is too sparse.
2default:defaulth px
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2default:default2

sequential2default:default2+
TrafficSignalController2default:defaultZ8-3354h px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:10 . Memory (MB): peak = 280.426 ; gain = 115.621
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
I
%s*synth24
 Start RTL Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
7
%s*synth2"
+---Adders : 
2default:defaulth px
W
%s*synth2B
.	   2 Input      5 Bit       Adders := 1     
2default:defaulth px
:
%s*synth2%
+---Registers : 
2default:defaulth px
W
%s*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                2 Bit    Registers := 1     
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   7 Input      5 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   6 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   4 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	  10 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   5 Input      2 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   6 Input      1 Bit        Muxes := 2     
2default:defaulth px
W
%s*synth2B
.	   4 Input      1 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   5 Input      1 Bit        Muxes := 1     
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Finished RTL Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
V
%s*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Hierarchical RTL Component report 
2default:defaulth px
I
%s*synth24
 Module TrafficSignalController 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
7
%s*synth2"
+---Adders : 
2default:defaulth px
W
%s*synth2B
.	   2 Input      5 Bit       Adders := 1     
2default:defaulth px
:
%s*synth2%
+---Registers : 
2default:defaulth px
W
%s*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                2 Bit    Registers := 1     
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   7 Input      5 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   6 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   4 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	  10 Input      3 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   5 Input      2 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   6 Input      1 Bit        Muxes := 2     
2default:defaulth px
W
%s*synth2B
.	   4 Input      1 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   5 Input      1 Bit        Muxes := 1     
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
X
%s*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
E
%s*synth20
Start Part Resource Summary
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
Loading clock regions from %s
13*device2c
OD:/Xilinx2014/Vivado/2014.4/data\parts/xilinx/zynq/zynq/xc7z020/ClockRegion.xml2default:defaultZ21-13h px
�
Loading clock buffers from %s
11*device2d
PD:/Xilinx2014/Vivado/2014.4/data\parts/xilinx/zynq/zynq/xc7z020/ClockBuffers.xml2default:defaultZ21-11h px
�
&Loading clock placement rules from %s
318*place2[
GD:/Xilinx2014/Vivado/2014.4/data/parts/xilinx/zynq/ClockPlacerRules.xml2default:defaultZ30-318h px
�
)Loading package pin functions from %s...
17*device2W
CD:/Xilinx2014/Vivado/2014.4/data\parts/xilinx/zynq/PinFunctions.xml2default:defaultZ21-17h px
�
Loading package from %s
16*device2f
RD:/Xilinx2014/Vivado/2014.4/data\parts/xilinx/zynq/zynq/xc7z020/clg484/Package.xml2default:defaultZ21-16h px
�
Loading io standards from %s
15*device2X
DD:/Xilinx2014/Vivado/2014.4/data\./parts/xilinx/zynq/IOStandards.xml2default:defaultZ21-15h px
�
%s*synth2k
WPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB18 60 RAMB36 30)
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Finished Part Resource Summary
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Start Parallel Synthesis Optimization  : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 436.191 ; gain = 271.387
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
K
%s*synth26
"Start Cross Boundary Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Cross Boundary Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 436.191 ; gain = 271.387
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
~Finished Parallel Reinference  : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 436.191 ; gain = 271.387
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
�
%s*synth2�
~---------------------------------------------------------------------------------
Start RAM, DSP and Shift Register Reporting
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished RAM, DSP and Shift Register Reporting
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
A
%s*synth2,
Start Area Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
zFinished Area Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
zFinished Area Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Parallel Area Optimization  : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
�
%s*synth2�
�Finished Parallel Synthesis Optimization  : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
C
%s*synth2.
Start Timing Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
|Finished Timing Optimization : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-
Start Technology Mapping
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
{Finished Technology Mapping : Time (s): cpu = 00:00:15 ; elapsed = 00:00:17 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
<
%s*synth2'
Start IO Insertion
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
N
%s*synth29
%Start Flattening Before IO Insertion
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
Q
%s*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
E
%s*synth20
Start Final Netlist Cleanup
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Finished Final Netlist Cleanup
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
uFinished IO Insertion : Time (s): cpu = 00:00:16 ; elapsed = 00:00:18 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
A
%s*synth2,

Report Check Netlist: 
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Start Renaming Generated Instances
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:16 ; elapsed = 00:00:18 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
I
%s*synth24
 Start Rebuilding User Hierarchy
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:16 ; elapsed = 00:00:18 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
~---------------------------------------------------------------------------------
Start RAM, DSP and Shift Register Reporting
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished RAM, DSP and Shift Register Reporting
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Start Writing Synthesis Report
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
>
%s*synth2)

Report BlackBoxes: 
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
G
%s*synth22
| |BlackBox name |Instances |
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
>
%s*synth2)

Report Cell Usage: 
2default:defaulth px
?
%s*synth2*
+------+-----+------+
2default:defaulth px
?
%s*synth2*
|      |Cell |Count |
2default:defaulth px
?
%s*synth2*
+------+-----+------+
2default:defaulth px
?
%s*synth2*
|1     |BUFG |     1|
2default:defaulth px
?
%s*synth2*
|2     |LUT1 |     1|
2default:defaulth px
?
%s*synth2*
|3     |LUT2 |     2|
2default:defaulth px
?
%s*synth2*
|4     |LUT3 |     3|
2default:defaulth px
?
%s*synth2*
|5     |LUT4 |     8|
2default:defaulth px
?
%s*synth2*
|6     |LUT5 |     3|
2default:defaulth px
?
%s*synth2*
|7     |LUT6 |     4|
2default:defaulth px
?
%s*synth2*
|8     |FDCE |     3|
2default:defaulth px
?
%s*synth2*
|9     |FDRE |    10|
2default:defaulth px
?
%s*synth2*
|10    |IBUF |     3|
2default:defaulth px
?
%s*synth2*
|11    |OBUF |     5|
2default:defaulth px
?
%s*synth2*
+------+-----+------+
2default:defaulth px
B
%s*synth2-

Report Instance Areas: 
2default:defaulth px
K
%s*synth26
"+------+---------+-------+------+
2default:defaulth px
K
%s*synth26
"|      |Instance |Module |Cells |
2default:defaulth px
K
%s*synth26
"+------+---------+-------+------+
2default:defaulth px
K
%s*synth26
"|1     |top      |       |    43|
2default:defaulth px
K
%s*synth26
"+------+---------+-------+------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:16 ; elapsed = 00:00:18 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
o
%s*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 0 warnings.
2default:defaulth px
�
%s*synth2�
~Synthesis Optimization Runtime : Time (s): cpu = 00:00:00 ; elapsed = 00:00:15 . Memory (MB): peak = 456.473 ; gain = 271.020
2default:defaulth px
�
%s*synth2�
Synthesis Optimization Complete : Time (s): cpu = 00:00:16 ; elapsed = 00:00:18 . Memory (MB): peak = 456.473 ; gain = 291.668
2default:defaulth px
?
 Translating synthesized netlist
350*projectZ1-571h px
b
-Analyzing %s Unisim elements for replacement
17*netlist2
32default:defaultZ29-17h px
g
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px
H
)Preparing netlist for logic optimization
349*projectZ1-570h px
d
1Inserted %s IBUFs to IO ports without IO buffers.100*opt2
02default:defaultZ31-140h px
d
1Inserted %s OBUFs to IO ports without IO buffers.101*opt2
02default:defaultZ31-141h px
r
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px
{
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px
R
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
142default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px
[
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:162default:default2
00:00:172default:default2
511.5042default:default2
326.0512default:defaultZ17-268h px
�
sreport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.039 . Memory (MB): peak = 511.504 ; gain = 0.000
*commonh px
}
Exiting %s at %s...
206*common2
Vivado2default:default2,
Thu Nov 07 16:47:15 20192default:defaultZ17-206h px