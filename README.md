# FPGA-CNN-Accelerator

\# FPGA-Based CNN Accelerator



An RTL-based CNN accelerator designed for FPGA implementation, featuring parallel MAC computation, streaming 3×3 convolution, ReLU activation, and configurable quantization.



\## Project Status



\- RTL architecture implemented

\- Individual RTL modules simulated and verified

\- End-to-end CNN pipeline simulated

\- 3×3 sliding-window convolution verified

\- Parallel MAC computation verified

\- ReLU activation verified

\- Configurable quantization verified

\- Controller and output counter verified

\- FPGA synthesis: Pending

\- Cyclone V hardware validation: Pending



\## Architecture



The accelerator follows a streaming CNN datapath:



Input Pixels  

↓  

3×3 Sliding Window / Line Buffer  

↓  

Parallel MAC Array  

↓  

3×3 Convolution  

↓  

ReLU Activation  

↓  

Configurable Quantization  

↓  

Quantized Output



A controller manages the processing operation, while an output counter tracks the generated convolution outputs.



\## RTL Modules



| Module | Description |

|---|---|

| `mac\_unit.sv` | Signed multiply-accumulate unit |

| `mac\_array.sv` | Parallel MAC architecture |

| `convolution\_3x3.sv` | 3×3 convolution wrapper |

| `sliding\_window\_3x3.sv` | Streaming 3×3 window generation using line buffers |

| `streaming\_convolution.sv` | Integrated convolution datapath |

| `relu.sv` | ReLU activation |

| `quantizer.sv` | Configurable right-shift quantization |

| `cnn\_controller.sv` | Processing control logic |

| `output\_counter.sv` | Counts valid CNN outputs |

| `cnn\_accelerator.sv` | Top-level CNN accelerator |



\## Verification



The design was verified using a 5×5 test image and a 3×3 all-ones kernel.



The convolution produced:



```text

63  72  81

108 117 126

153 162 171



With a quantization shift of 2, the corresponding quantized outputs were:



15 18 20

27 29 31

38 40 42



The complete streaming pipeline was verified using Icarus Verilog and GTKWave.



\##Tools Used

SystemVerilog

Icarus Verilog

GTKWave

Intel Quartus Prime Lite

Python

Repository Structure

FPGA-CNN-Accelerator/

│

├── rtl/

│   ├── mac\_unit.sv

│   ├── mac\_array.sv

│   ├── convolution\_3x3.sv

│   ├── sliding\_window\_3x3.sv

│   ├── streaming\_convolution.sv

│   ├── relu.sv

│   ├── quantizer.sv

│   ├── cnn\_controller.sv

│   ├── output\_counter.sv

│   └── cnn\_accelerator.sv

│

├── tb/

│   └── Testbenches for RTL modules

│

├── sim/

│   └── Simulation files and waveforms

│

└── README.md

\##Future Work

Synthesize the design using Intel Quartus Prime

Map the accelerator to an Intel/Altera Cyclone V FPGA

Perform timing and resource utilization analysis

Validate the design on physical FPGA hardware

Optimize the MAC architecture and datapath for improved throughput

