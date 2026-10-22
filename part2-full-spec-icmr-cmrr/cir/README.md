# Circuit Simulation Files (Part 2)

The Xschem schematic files for the 5T OTA in Part 2 are designed using the SkyWater 130nm PDK. This guide is executed within the **IIC-OSIC-TOOLS** <sup>[[1]](#ref1)</sup> all-in-one Docker environment, with the SKY130 device libraries configured to point to their corresponding locations within the environment.

Two schematics are used in this guide:
1. **Open-Loop OTA Schematic:** Validates the DC operating point, AC frequency response, and CMRR.
2. **Unity-Gain Follower Schematic:** Validates the Input Common-Mode Range (ICMR).

## 1. Main OTA Schematic

The first schematic includes separate SPICE code blocks for:
1. **$V_{CM}$ DC Sweep (`.dc`):** Sweeps common-mode voltage to find the optimal $V_{CM}$ range for an acceptable operating point.
2. **DC Operating Point (`.op`):** Prints the detailed DC operating point parameters.
3. **AC Analysis (`.ac`):** Plots the open-loop frequency response (gain magnitude $A_V$ and phase).
4. **CMRR Analysis (`.ac`):** Plots and measures the Common-Mode Rejection Ratio ($CMRR$) across frequency.

> **Execution Rule:** Run each code block individually with the others disabled. To enable a code block, open its **Properties** window in Xschem and set the `spice_ignore` attribute value to `false`. Otherwise, set it to `true`.


## 2. Unity-Gain Follower Schematic

The second schematic contains a single code block that performs a DC sweep on $V_{CM}$ (`.dc`) to measure output tracking error and determine the operational input common-mode range.

## References

- <a id="ref1"></a> **[1]** Institute for Integrated Circuits and Quantum Computing, Johannes Kepler University Linz , "IIC-OSIC-TOOLS," GitHub, 2022. Accessed: Oct. 16, 2026. Available: [https://github.com/iic-jku/IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS)
