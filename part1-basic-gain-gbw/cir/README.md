# Circuit Simulation Files (Part 1)

The Xschem schematic file for the 5T OTA in Part 1 is designed using the SkyWater 130nm PDK. This guide is executed within the **IIC-OSIC-TOOLS** <sup>[[1]](#ref1)</sup> all-in-one Docker environment, with the SKY130 device libraries configured to point to their corresponding paths within the environment.

## Simulation Code Blocks

The schematic includes separate SPICE code blocks for:
1. **$V_{CM}$ DC Sweep (`.dc`):** Sweeps common-mode voltage to find the optimal $V_{CM}$ range for a valid operating point.
2. **DC Operating Point (`.op`):** Prints the detailed DC operating point parameters.
3. **AC Sweep (`.ac`):** Plots the open-loop gain magnitude ($A_V$) and phase response across frequency.

> **Execution Rule:** Run each code block individually with the others disabled. To enable a code block, open its **Properties** window in Xschem and set the `spice_ignore` attribute value to `false`. To disable it, set `spice_ignore` to `true`.

---

## Cloning the Repository

To clone this repository:
1. Ensure the Docker container is running and open a terminal in the working directory (`/foss/designs`) via the IIC-OSIC-TOOLS VNC desktop interface.
2. Execute the following command:

```bash
git clone [https://github.com/sihawikhalid/openlut-sky130-ota-guide.git](https://github.com/sihawikhalid/openlut-sky130-ota-guide.git)

```
## References

- <a id="ref1"></a> **[1]** Institute for Integrated Circuits and Quantum Computing, Johannes Kepler University Linz , "IIC-OSIC-TOOLS," GitHub, 2022. Accessed: Oct. 16, 2026. Available: [https://github.com/iic-jku/IIC-OSIC-TOOLS](https://github.com/iic-jku/IIC-OSIC-TOOLS)
