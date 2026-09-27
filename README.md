# FPGA-Based CNN Accelerator

An RTL-based Convolutional Neural Network (CNN) accelerator designed for FPGA implementation. The project implements a streaming 3x3 convolution datapath with parallel MAC computation, ReLU activation, and configurable quantization.

## Project Status

- RTL architecture implemented
- Individual RTL modules simulated and verified
- End-to-end CNN pipeline simulated and verified
- 3x3 sliding-window convolution verified
- Parallel MAC computation verified
- ReLU activation verified
- Configurable quantization verified
- CNN controller implemented and verified
- Output counter implemented and verified
- FPGA synthesis: Pending
- Cyclone V hardware validation: Pending

## Architecture

The accelerator follows a streaming CNN processing pipeline:

```text
Input Pixels
     |
     v
3x3 Sliding Window
(Line Buffers)
     |
     v
Parallel MAC Array
     |
     v
3x3 Convolution
     |
     v
ReLU Activation
     |
     v
Configurable Quantization
     |
     v
Quantized Output

A controller manages the processing operation, while an output counter tracks the number of valid CNN outputs.

RTL Modules
Module	Description
mac_unit.sv	Signed multiply-accumulate unit
mac_array.sv	Parallel MAC architecture
convolution_3x3.sv	3x3 convolution wrapper
sliding_window_3x3.sv	Streaming 3x3 window generation using line buffers
streaming_convolution.sv	Integrated streaming convolution datapath
relu.sv	ReLU activation function
quantizer.sv	Configurable right-shift quantization
cnn_controller.sv	Processing control logic
output_counter.sv	Counts valid CNN outputs
cnn_accelerator.sv	Top-level CNN accelerator
Verification

The RTL design was simulated using Icarus Verilog and waveform results were inspected using GTKWave.

A 5x5 test image was processed using a 3x3 all-ones convolution kernel.

Test Image
1   2   3   4   5
6   7   8   9   10
11  12  13  14  15
16  17  18  19  20
21  22  23  24  25
Convolution Results

The 3x3 convolution generated:

63   72   81
108  117  126
153  162  171
Quantized Results

Using a configurable quantization shift of 2:

15  18  20
27  29  31
38  40  42

The complete streaming pipeline was verified with 9 valid convolution outputs.

Key Features
Streaming 3x3 convolution
Line-buffer based sliding window
Parallel MAC computation
Signed 8-bit input and weight representation
32-bit convolution accumulation
ReLU activation
Configurable quantization
Processing controller
Output counting
Modular SystemVerilog RTL design
Tools Used
SystemVerilog
Icarus Verilog 12.0
GTKWave 3.3.108
Intel Quartus Prime Lite
Python
Repository Structure
FPGA-CNN-Accelerator/
|
├── rtl/
|   ├── mac_unit.sv
|   ├── mac_array.sv
|   ├── convolution_3x3.sv
|   ├── sliding_window_3x3.sv
|   ├── streaming_convolution.sv
|   ├── relu.sv
|   ├── quantizer.sv
|   ├── cnn_controller.sv
|   ├── output_counter.sv
|   └── cnn_accelerator.sv
|
├── tb/
|   └── Testbenches for RTL modules
|
├── sim/
|   └── Simulation files
|
└── README.md
Current Limitations

The RTL design has been simulated and verified, but physical FPGA implementation has not yet been completed.

The current hardware target is an Intel/Altera Cyclone V FPGA. The final Quartus project, FPGA pin assignments, synthesis results, timing analysis, and hardware validation are pending.

Future Work
Create the Intel Quartus FPGA project
Synthesize the RTL design
Map the design to the Cyclone V FPGA
Analyze FPGA resource utilization
Perform timing analysis
Validate the accelerator on physical FPGA hardware
Optimize the MAC architecture for improved throughput
Explore larger CNN layers and configurable image dimensions
Author

Shagun Gupta

B.Tech Electronics and Communication Engineering
Vellore Institute of Technology, Chennai