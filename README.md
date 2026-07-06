# 🚦 Traffic Light Controller with Pedestrian Priority using FPGA

A real-time FPGA-based Traffic Light Controller designed using **Verilog HDL** and implemented on the **Basys-3 FPGA Board**. The system automates traffic signal sequencing while providing **pedestrian priority**, **emergency override**, and a **seven-segment countdown display** for improved road safety.

---

## 📌 Project Overview

Traditional traffic lights operate using fixed timing and cannot immediately respond to pedestrian requests or emergency situations. This project addresses these limitations by implementing an intelligent traffic light controller capable of:

- Automatic traffic light sequencing
- Pedestrian priority using a push button
- Emergency override functionality
- Countdown timer display
- FPGA-based real-time implementation

The complete system is designed using **Finite State Machine (FSM)** architecture and implemented in **Verilog HDL**.

---

## ✨ Features

- 🚗 Automatic Green → Yellow → Red traffic sequence
- 🚶 Pedestrian priority button
- 🚨 Emergency override mode
- ⏱ Seven-segment countdown display
- ⚡ Real-time FPGA implementation
- 🔄 FSM-based control logic
- 🛡 Button debouncing
- 🕒 1 Hz clock generation from 100 MHz FPGA clock
- 🧩 Modular Verilog design

---

# System Architecture

```
                    +----------------+
                    | 100 MHz Clock  |
                    +--------+-------+
                             |
                      Clock Divider
                             |
                       1 Hz Tick Signal
                             |
      +----------------------+----------------------+
      |                                             |
Pedestrian Button                          Emergency Button
      |                                             |
Debounce Circuit                          Debounce Circuit
      |                                             |
      +----------------------+----------------------+
                             |
                     Traffic Light FSM
                             |
        +----------+----------+-----------+
        |          |          |           |
   Car LEDs    Ped LEDs   Countdown   State Control
                           Display
```

---

# Finite State Machine (FSM)

```
GREEN
   |
   V
YELLOW
   |
   V
RED
   |
   +--------------------+
   |                    |
Pedestrian?             |
   |                    |
   V                    |
Pedestrian Crossing     |
   |                    |
   +--------------------+
            |
            V
         GREEN

Emergency Button
      |
      V
Emergency State
(All Traffic Red)
```

---

# Hardware Used

| Component | Description |
|------------|-------------|
| FPGA Board | Digilent Basys-3 |
| FPGA Device | Artix-7 XC7A35T |
| LEDs | Vehicle & Pedestrian Signals |
| Push Buttons | Pedestrian & Emergency Input |
| Seven Segment Display | Countdown Timer |

---

# Software Tools

- Vivado Design Suite
- Verilog HDL
- Waveform Simulator (Vivado)

---

# Project Directory

```
Traffic-Light-Controller/
│
├── rtl/
│   ├── traffic_light_top.v
│   ├── traffic_fsm.v
│   ├── one_sec_tick.v
│   ├── ped_button.v
│   ├── emer_button.v
│   ├── seven_seg_display.v
│
├── constraints/
│   └── basys3.xdc
│
├── simulation/
│   ├── tb_traffic_light.v
│   └── waveform.png
│
├── images/
│   ├── block_diagram.png
│   ├── rtl.png
│   ├── hardware.jpg
│
└── README.md
```

---

# Working Principle

## Normal Operation

```
GREEN (5 s)
      ↓
YELLOW (3 s)
      ↓
RED (5 s)
      ↓
Repeat
```

---

## Pedestrian Mode

1. User presses the pedestrian button.
2. Controller finishes the current transition safely.
3. Vehicle signal turns RED.
4. Pedestrian signal turns GREEN.
5. Countdown timer starts.
6. Normal operation resumes after countdown.

---

## Emergency Mode

Whenever the emergency button is pressed:

- All vehicle traffic immediately stops.
- Red light is activated.
- Normal traffic sequence is suspended.
- System resumes normal operation after emergency is cleared.

---

# Key Modules

### Clock Divider
Generates a stable **1 Hz** clock from the onboard **100 MHz** FPGA clock.

---

### Pedestrian Button Module

- Button debouncing
- Single pulse generation
- Pedestrian request synchronization

---

### Emergency Module

- Highest priority control
- Immediate traffic halt
- Safe recovery mechanism

---

### Traffic FSM

Controls

- Traffic signals
- Pedestrian signals
- State transitions
- Timing control

---

### Seven Segment Display

Displays

- Countdown timer
- Current state information

---

# Simulation

The design was verified using Vivado Simulator.

Simulation confirms:

- Correct state transitions
- Proper timing sequence
- Pedestrian priority
- Emergency override
- Countdown operation

---

# Hardware Implementation

Successfully implemented on the **Digilent Basys-3 FPGA Board**.

Verified Features

- Correct LED operation
- Accurate countdown display
- Stable FSM transitions
- Real-time hardware performance

---

# Results

✔ Normal traffic cycle works correctly

✔ Pedestrian request handled safely

✔ Emergency override functions properly

✔ Countdown display synchronized

✔ Successful FPGA implementation

---

# Future Improvements

- Adaptive traffic control using vehicle sensors
- IoT-enabled monitoring
- Communication between multiple traffic junctions
- AI/ML-based traffic prediction
- Camera-based vehicle detection
- Emergency vehicle detection using image processing

---

# Learning Outcomes

During this project the following concepts were learned:

- Verilog HDL
- Finite State Machine Design
- FPGA Prototyping
- Clock Division
- Button Debouncing
- Seven Segment Display Interfacing
- RTL Design
- Vivado Design Flow
- Hardware Debugging
- Timing Analysis

---

# Applications

- Smart Cities
- Urban Traffic Management
- Educational FPGA Projects
- Embedded Digital Systems
- Intelligent Transportation Systems

---

# Author

**Laksana A**

Electronics and Communication Engineering

Sri Eshwar College of Engineering

Winter Internship @ NIELIT Calicut

---

# License

This project is developed for educational and research purposes.
