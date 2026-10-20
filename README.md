# Systematic 5T OTA Design via $g_m/I_D$ & Open-LUT

A multi-part, tool-focused guide demonstrating how to use **[Open-LUT](http://www.open-lut.org)** [^1] to facilitate and accelerate $g_m/I_D$ transistor sizing for 5T OTAs in SkyWater's open-source 130nm PDK ([SKY130](https://www.skywatertechnology.com/skys-the-limit-with-the-sky130-open-source-pdk/))[^2], with design results verified using **Ngspice** and **Xschem**.

> [!NOTE]
> **Scope & Target Audience:** This guide focuses on **how to navigate and apply Open-LUT** as a CAD tool to streamline transistor sizing. It assumes basic familiarity with $g_m/I_D$ methodology <sup>[[3]](#ref3)</sup> <sup>[[4]](#ref3)</sup> <sup>[[5]](#ref3)</sup>.

## Overview & Supported Devices

The **Open-LUT** web application automates MOSFET parameter selection and device sizing using pre-characterized $g_m/I_D$ lookup tables generated from the SKY130 PDK.

* **Supported SKY130 Devices:**
  * **NMOS:** Standard (`nfet_01v8`), Low-V<sub>TH</sub> (`nfet_01v8_lvt`)
  * **PMOS:** Standard (`pfet_01v8`), Low-V<sub>TH</sub> (`pfet_01v8_lvt`), High-V<sub>TH</sub> (`pfet_01v8_hvt`)
* **Methodology Reference:** For details on how Open-LUT converges on device dimensions using design parameters, refer to the [Open-LUT Paper](https://ieeexplore.ieee.org/abstract/document/11316023).

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

## Series Directory

### 📁 [Part 1: Basic 5T OTA Sizing](./part1-basic-gain-gbw/) ($A_{v,\mathrm{dc}}$, $GBW$, $I_{SS}$)

Serves as a practical walkthrough on using Open-LUT to execute $g_m/I_D$-based device sizing, showing how to extract transistor dimensions ($W, L$) from basic specifications ($A_{v,dc}$, $\text{GBW}$, $I_{SS}$).

| Parameter / Specification | Target Value |
| :--- | :--- |
| **Technology / Supply Voltage ($V_{DD}$)** | 130 nm (SKY130) / 1.8 V |
| **Reference Current ($I_{bias}$) / Tail Current ($I_{SS}$)** | 10 µA / 20 µA |
| **Capacitive Load ($C_L$)** | 5 pF |
| **Open-Loop DC Gain ($A_{v,dc}$)** | $\ge 32	 { dB}$ |
| **Gain-Bandwidth Product (GBW)** | $\ge 5	 { MHz}$ |

### 📁 [Part 2: Extended 5T OTA Sizing](./part2-full-spec-icmr-cmrr/) ($ICMR$ & $CMRR$ Optimization)

Extends the baseline 5T OTA design to meet common-mode voltage headroom and rejection specifications.

| Parameter / Specification | Target Value | Notes |
| :--- | :--- | :--- |
| **Baseline Specifications** | Same as Part 1 | Preserves $A_{v,dc}, 	{GBW}, I_{SS}, C_L$ |
| **Input Common-Mode Range (ICMR)** | **0.7 V – 1.6 V** | Optimized via LVT input pair & PMOS load selection |
| **Common-Mode Rejection Ratio (CMRR)** | **$\ge 70	{ dB}$** | Achieved via tail source $r_{ds5}$ $(\frac{1}{g_{ds5}})$ optimization |

## Citation

If you use Open-LUT or this guide in your work, please cite the following paper:

S. A. Khalid, S. E. Maestre and K. M. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," 2025 10th International Conference on Integrated Circuits and Microsystems (ICICM), Hefei, China, 2025, pp. 344-353, doi: [10.1109/ICICM66614.2025.11316023](https://doi.org/10.1109/ICICM66614.2025.11316023).

```bibtex
@inproceedings{khalid2025openlut,
   author    = {Khalid, S. A. and Maestre, S. E. and Madrid-Khalid, K. M.},
   title     = {{Open-LUT: Interactive $g_m/I_D$ Lookup Tables for MOSFET Sizing in Open-Source PDKs}},
   booktitle = {2025 10th International Conference on Integrated Circuits and Microsystems (ICICM)},
   address   = {Hefei, China},
   year      = {2025},
   pages     = {344--353},
   doi       = {10.1109/ICICM66614.2025.11316023}
}
```

## References

[^1]: S. A. Khalid, S. E. Maestre and K. M. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," *2025 10th International Conference on Integrated Circuits and Microsystems (ICICM)*, Hefei, China, 2025, pp. 344-353, doi: [10.1109/ICICM66614.2025.11316023](https://doi.org/10.1109/ICICM66614.2025.11316023).
[^2]: "SKY’s the Limit with the SKY130 Open-Source PDK." Skywater. https://www.skywatertechnology.com/sky130-open-source-pdk/ (accessed Oct. 10, 2025).

[^3] S. A. Khalid, S. E. Maestre, and K. M. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," *2025 10th ICICM*, 2025, pp. 344-353, doi: [10.1109/ICICM66614.2025.11316023](https://doi.org/10.1109/ICICM66614.2025.11316023).

[^4] S. A. Khalid, S. E. Maestre, and K. M. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," *2025 10th ICICM*, 2025, pp. 344-353, doi: [10.1109/ICICM66614.2025.11316023](https://doi.org/10.1109/ICICM66614.2025.11316023).

[^5] S. A. Khalid, S. E. Maestre, and K. M. Madrid-Khalid, "Open-LUT: Interactive gm/ID Lookup Tables for MOSFET Sizing in Open-Source PDKs," *2025 10th ICICM*, 2025, pp. 344-353, doi: [10.1109/ICICM66614.2025.11316023](https://doi.org/10.1109/ICICM66614.2025.11316023).



