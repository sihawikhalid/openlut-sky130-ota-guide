# Systematic 5T OTA Design via $g_m/I_D$ & Open-LUT

A multi-part guide to systematic 5T Operational Transconductance Amplifier (OTA) design in SKY130 technology using the interactive **[Open-LUT](https://open-lut.app)** web app. This guide demonstrates how to translate target performance specifications into transistor dimensions ($W, L, g_m/I_D$) using the $g_m/I_D$ methodology, verified with **Ngspice** and **Xschem**.

---

## Overview & Supported Devices

The **Open-LUT** web application automates MOSFET parameter selection and device sizing using pre-characterized $g_m/I_D$ lookup tables generated from the SKY130 PDK.

* **Supported SKY130 Devices:**
  * **NMOS:** Standard (`nfet_01v8`), Low-$V_{TH}$ (`nfet_01v8_lvt`)
  * **PMOS:** Standard (`pfet_01v8`), Low-$V_{TH}$ (`pfet_01v8_lvt`), High-$V_{TH}$ (`pfet_01v8_hvt`)
* **Methodology Reference:** For details on how Open-LUT converges on device dimensions using design parameters, refer to the [Open-LUT Paper](https://open-lut.app/paper).

---

## Repository Structure

Each part of this series is organized in its own directory containing a dedicated guide, Ngspice simulation netlists, and schematic figures:

```text
.
├── README.md                 # Main overview & series directory (this file)
├── part1-basic/              # Part 1: Basic 5T OTA design
│   ├── README.md             # Part 1 tutorial guide
│   ├── cir/                  # Ngspice simulation files (.cir)
│   └── img/                  # Schematics and plots
└── part2-extended/           # Part 2: Extended 5T OTA design
    ├── README.md             # Part 2 tutorial guide
    ├── cir/                  # Ngspice simulation files (.cir)
    └── img/                  # Schematics and plots
```

---

## Series Directory

### 📁 [Part 1: Basic 5T OTA Sizing](./part1-basic/) ($A_{v,\mathrm{dc}}$, GBW, $I_{SS}$)

Serves as an introductory guide to the $g_m/I_D$ design workflow, focusing on achieving core Gain, Bandwidth, and Current specifications.

| Parameter / Specification | Target Value |
| :--- | :--- |
| **Technology / Supply Voltage ($V_{DD}$)** | 130 nm (SKY130) / 1.8 V |
| **Reference Current ($I_{bias}$) / Tail Current ($I_{SS}$)** | 10 µA / 20 µA |
| **Capacitive Load ($C_L$)** | 5 pF |
| **Open-Loop DC Gain ($A_{v,dc}$)** | $\ge 32	ext{ dB}$ |
| **Gain-Bandwidth Product ($	ext{GBW}$)** | $\ge 5	ext{ MHz}$ |

👉 **[Access Part 1 Guide & Simulation Files](./part1-basic/)**

---

### 📁 [Part 2: Extended 5T OTA Sizing (ICMR & CMRR Optimization)](./part2-extended/)

Extends the baseline 5T OTA design to meet common-mode voltage headroom and rejection specifications.

| Parameter / Specification | Target Value | Notes |
| :--- | :--- | :--- |
| **Baseline Specifications** | Same as Part 1 | Preserves $A_{v,dc}, 	ext{GBW}, I_{SS}, C_L$ |
| **Input Common-Mode Range ($	ext{ICMR}$)** | **0.70 V – 1.60 V** | Optimized via LVT input pair & PMOS load selection |
| **Common-Mode Rejection Ratio ($	ext{CMRR}$)** | **$\ge 70	ext{ dB}$** | Achieved via tail source $r_{o5}$ optimization |

👉 **[Access Part 2 Guide & Simulation Files](./part2-extended/)**


