# Systematic 5T OTA Design via $g_m/I_D$ & Open-LUT

A multi-part guide to systematic 5T Operational Transconductance Amplifier (OTA) design using SkyWater's open-source 130nm PDK (SKY130)[^1] and the interactive **[Open-LUT](http://www.open-lut.org)** [^2] web app. A multi-part guide to systematic 5T Operational Transconductance Amplifier (OTA) design in SKY130 technology using the interactive **[Open-LUT](http://www.open-lut.org)** [^1] web app. This guide demonstrates how to translate target performance specifications into transistor dimensions ($W, L$) using the $g_m/I_D$ methodology, verified with **Ngspice** and **Xschem**.

---

## Overview & Supported Devices

The **Open-LUT** web application automates MOSFET parameter selection and device sizing using pre-characterized $g_m/I_D$ lookup tables generated from the SKY130 PDK.

* **Supported SKY130 Devices:**
  * **NMOS:** Standard (`nfet_01v8`), Low-V<sub>TH</sub> (`nfet_01v8_lvt`)
  * **PMOS:** Standard (`pfet_01v8`), Low-V<sub>TH</sub> (`pfet_01v8_lvt`), High-V<sub>TH</sub> (`pfet_01v8_hvt`)
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

### 📁 [Part 1: Basic 5T OTA Sizing](./part1-basic-gain-gbw/) ($A_{v,\mathrm{dc}}$, $GBW$, $I_{SS}$)

Serves as an introductory guide to the $g_m/I_D$ design workflow, focusing on achieving core Gain, Bandwidth, and Current specifications.

| Parameter / Specification | Target Value |
| :--- | :--- |
| **Technology / Supply Voltage ($V_{DD}$)** | 130 nm (SKY130) / 1.8 V |
| **Reference Current ($I_{bias}$) / Tail Current ($I_{SS}$)** | 10 µA / 20 µA |
| **Capacitive Load ($C_L$)** | 5 pF |
| **Open-Loop DC Gain ($A_{v,dc}$)** | $\ge 32	 { dB}$ |
| **Gain-Bandwidth Product (GBW)** | $\ge 5	 { MHz}$ |

👉 **[Access Part 1 Guide & Simulation Files](./part1-basic/)**

---

### 📁 [Part 2: Extended 5T OTA Sizing](./part2-extended/) ($ICMR$ & $CMRR$ Optimization)

Extends the baseline 5T OTA design to meet common-mode voltage headroom and rejection specifications.

| Parameter / Specification | Target Value | Notes |
| :--- | :--- | :--- |
| **Baseline Specifications** | Same as Part 1 | Preserves $A_{v,dc}, 	{GBW}, I_{SS}, C_L$ |
| **Input Common-Mode Range (ICMR)** | **0.70 V – 1.60 V** | Optimized via LVT input pair & PMOS load selection |
| **Common-Mode Rejection Ratio (CMRR)** | **$\ge 70	{ dB}$** | Achieved via tail source $r_{o5}$ optimization |

👉 **[Access Part 2 Guide & Simulation Files](./part2-extended/)**

## References
[^1]: "SKY’s the Limit with the SKY130 Open-Source PDK." Skywater. https://www.[skywatertechnology.com/sky130-open-source-pdk/](https://www.skywatertechnology.com/skys-the-limit-with-the-sky130-open-source-pdk/) (accessed Oct. 10, 2025).
[^2]: S. Khalid, S. Maestre, and K. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," *2025 10th International Conference on Integrated Circuits and Microsystems (ICICM)*, Hefei, China, 2025.
