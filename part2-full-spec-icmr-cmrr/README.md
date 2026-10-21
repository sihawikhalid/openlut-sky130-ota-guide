# Part 2: 5T OTA Sizing in SKY130 with ICMR and CMRR Constraints using Open-LUT

> A step-by-step guide extending the Open-LUT sizing methodology to meet Input Common-Mode Range (ICMR) and Common-Mode Rejection Ratio (CMRR) specifications for a 5T OTA in SkyWater 130nm PDK.

> [!NOTE]
> **Scope & Focus:** This guide demonstrates how to navigate and leverage Open-LUT to handle ICMR and CMRR constraints. While essential $g_m/I_D$ equations are included, primary focus is placed on tool execution and simulation verification in Ngspice and Xschem.

---

## 1. Design Specifications

This second part extends the 5T OTA design methodology introduced in Part 1 by incorporating strict Input Common-Mode Range ($ICMR$) and Common-Mode Rejection Ratio ($CMRR$) targets. **Table 1** summarizes the expanded specifications.

![Figure 1: 5-transistor (5T) Operational Transconductance Amplifier (OTA) Topology](img/fig1_5t_ota.png)
*Figure 1. 5-transistor (5T) Operational Transconductance Amplifier (OTA) topology.*

### Table 1: Design Specifications

| Specification Parameter | Symbol | Target Value |
| :--- | :---: | :---: |
| **PDK Technology** | - | SkyWater 130nm (SKY130) |
| **Supply Voltage** | $V_{DD}$ | $1.8\text{ V}$ |
| **Reference Current** | $I_{bias}$ | $10\,\mu\text{A}$ |
| **Tail Current** | $I_{SS}$ | $20\,\mu\text{A}$ |
| **Capacitive Load** | $C_L$ | $5\text{ pF}$ |
| **Open-Loop DC Gain** | $A_{V,DC}$ | $\ge 32\text{ dB}\ (39.81\text{ V/V})$ |
| **Gain-Bandwidth Product** | $GBW$ | $\ge 5\text{ MHz}$ |
| **Input Common-Mode Range** | $ICMR$ | $0.7\text{ V to } 1.6\text{ V}$ |
| **Common-Mode Rejection Ratio** | $CMRR$ | $\ge 70\text{ dB}\ (3162.28\text{ V/V})$ |

---

## 2. $V_{DS}$ Bias Allocation & ICMR Constraints

The $ICMR$ bounds of an NMOS-input 5T OTA dictate the minimum and maximum gate voltages for $M_1/M_2$:

$$V_{iCM,\min} > V_{GS1,2} + V_{ov5}$$

$$V_{iCM,\max} < V_{DD} - \vert{}V_{GS3,4}\vert{} + V_{th1,2} \approx V_{DD} - \vert{}V_{GS3,4}\vert{} + V_{GS1,2} + V_{ov1,2}$$

* **Lower Bound Limit:** For $V_{iCM,\min} = 0.7\text{ V}$ and allocating $V_{ov5} \approx 100\text{ mV}$, $V_{GS1,2}$ must satisfy $V_{GS1,2} < 0.6\text{ V}$. To achieve this low gate voltage while meeting the transconductance efficiency requirement, an LVT NMOS device (`sky130_nfet_01v8_lvt`) is selected for $M_1/M_2$.
* **Upper Bound Limit:** Targeting $V_{GS1,2} \approx 0.5\text{ V}$ and $V_{ov1,2} \approx 50\text{ mV}$ for design margin, achieving $V_{iCM,\max} = 1.6\text{ V}$ requires $\vert{}V_{GS3,4}\vert{} < 1.8 - 1.6 + 0.5 + 0.05 = 0.75\text{ V}$.
* **$V_{DS}$ Budget Allocation:** Tail transistor $M_5$ is assigned $V_{DS5} = 0.3\text{ V}$ ($> V_{ov5}$). Mirror loads $M_3/M_4$ (diode-connected) are allocated $V_{DS3,4} = \vert{}V_{GS3,4}\vert{} = 0.5\text{ V}$ ($< 0.75\text{ V}$). The remaining $1.0\text{ V}$ headroom is assigned to $V_{DS1,2}$. **Figure 2** illustrates the target bias allocation.

![Figure 2: Initial VDS Bias Allocation under ICMR Constraints](img/fig2_vds_allocation.png)
*Figure 2. Initial $V_{DS}$ Bias Allocation under ICMR constraints.*

---

## 3. Sizing Differential Input Pair ($M_1/M_2$)

Re-applying $GBW$ and gain constraints ($g_{m1,2} \ge 0.16\text{ mS}$, $(g_m/I_D)_{1,2} \ge 16\text{ S/A}$, $g_{ds1,2} \le 2\,\mu\text{S}$) with target margin $g_{m1,2} = 0.17\text{ mS}$ and $g_{ds1,2} = 1.5\,\mu\text{S}$:

> [!IMPORTANT]
> **CRITICAL OPEN-LUT WORKFLOW RULE:** Select your device and $V_{DS}$ bias, then click **`Update`** once to load the lookup tables for that setup. After this initial update, **always click the `Clear Form / Reset Plots` button before entering every new set of values!** Open-LUT preserves previous input fields and solution curves until explicitly reset. Entering new numbers into an uncleared form can lead to parameter conflicts or invalid extractions.

In Open-LUT, select device `sky130_nfet_01v8_lvt` and $V_{ds} = 1.0\text{ V}$, then click **Update** once. Entering $g_m = 0.17\text{ mS}$, $I_D = 0.01\text{ mA}$, and $g_{ds} = 0.0015\text{ mS}$ dynamically yields initial continuous channel dimensions.

To snap the channel length to the SKY130 layout grid ($0.005\,\mu\text{m}$ grid step), click **`Clear Form / Reset Plots`**, then enter $I_D = 0.01\text{ mA}$, $g_m = 0.17\text{ mS}$, and $L = 2.0755\,\mu\text{m}$ as the third parameter instead of $g_{ds}$. The final sizing dimensions and operating bias parameters for $M_1/M_2$ are summarized in **Table 2**.

### Table 2: Sizing and Biasing for $M_1/M_2$

| Parameter | $(g_m/I_D)_{1,2}$ | $L_{1,2}$ | $W_{1,2}$ | $g_{m1,2}$ | $g_{ds1,2}$ | $V_{ov1,2}$ | $V_{GS1,2}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $17\text{ S/A}$ | $2.0755\,\mu\text{m}$ | $22.5430\,\mu\text{m}$ | $0.17\text{ mS}$ | $1.5\,\mu\text{S}$ | $0.0548\text{ V}$ | $0.5174\text{ V}$ |

---

## 4. Sizing Current Mirror Loads ($M_3/M_4$)

With $V_{GS1,2} = 0.5174\text{ V}$ from Table 2, the upper-bound $V_{GS3,4}$ limit is updated: $\vert{}V_{GS3,4}\vert{} < 1.8 - 1.6 + 0.5174 + 0.0548 = 0.7722\text{ V}$. The allocated $V_{DS3,4} = V_{GS3,4} = 0.5\text{ V}$ remains fully valid. Furthermore, as established in Part 1, $M_3/M_4$ require $g_{ds3,4} \le 2\,\mu\text{S}$ to satisfy total DC open-loop gain requirements.

In Open-LUT, select `sky130_pfet_01v8_lvt` with the allocated $V_{ds} = 0.5\text{ V}$, then click **Update** once to extract the lookup tables. Examining the $V_{GS}$ vs $g_m/I_D$ characteristic (**Figure 3**) shows that achieving $V_{GS3,4} \approx 0.5\text{ V}$ restricts $g_m/I_D$ to the range of $6.5\text{--}11\text{ S/A}$.

![Figure 3: gm/ID vs VGS for sky130_pfet_01v8_lvt at Vds = 0.5 V](img/fig3_pmos_lvt_gm_id.png)
*Figure 3. $g_m/I_D$ vs $V_{GS}$ for `sky130_pfet_01v8_lvt` at $V_{ds} = 0.5\text{ V}$.*

Entering a branch current $I_D = 0.01\text{ mA}\ (10\,\mu\text{A})$ and an initial $g_m/I_D = 6.5\text{ S/A}$ dynamically updates the achievable range bounds for $g_{ds}$ in Open-LUT (**Figure 4**). This confirms that the required $g_{ds} < 2\,\mu\text{S}$ (target $1.5\,\mu\text{S}$) is indeed attainable within this $g_m/I_D$ operating range.

![Figure 4: Open-LUT Range Bounds for M3/M4 at ID = 10 µA and Vds = 0.5 V](img/fig4_openlut_m34.png)
*Figure 4. Open-LUT range bounds for $M_3/M_4$ at $I_D = 10\,\mu\text{A}$ and $V_{ds} = 0.5\text{ V}$.*

An initial entry of $I_D = 0.01\text{ mA}$, $g_m/I_D = 6.5\text{ S/A}$, and $g_{ds} = 0.0015\text{ mS}\ (1.5\,\mu\text{S})$ into Open-LUT yields a $V_{GS}$ that deviates from $0.5\text{ V}$. To resolve this bias discrepancy and match $V_{GS3,4}$ to the allocated $V_{DS3,4} = 0.5\text{ V}$, click **`Clear Form / Reset Plots`** and iterate $g_m/I_D$ values across the $6.5\text{--}11\text{ S/A}$ range. A $V_{GS3,4}$ of $0.5077\text{ V} \approx 0.5\text{ V}$ is successfully attained at $g_m/I_D = 10.5\text{ S/A}$.

Clearing the form once more and entering $I_D = 0.01\text{ mA}$, $g_m/I_D = 10.5\text{ S/A}$, and the layout-grid-snapped channel length $L = 1.2130\,\mu\text{m}$ extracts the finalized dimensions and operating point summarized in **Table 3**.

### Table 3: Sizing and Biasing for $M_3/M_4$

| Parameter | $(g_m/I_D)_{3,4}$ | $L_{3,4}$ | $W_{3,4}$ | $g_{m3,4}$ | $g_{ds3,4}$ | $V_{ov3,4}$ | $V_{GS3,4}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $10.5\text{ S/A}$ | $1.2130\,\mu\text{m}$ | $23.8550\,\mu\text{m}$ | $0.1050\text{ mS}$ | $1.5\,\mu\text{S}$ | $0.1519\text{ V}$ | $0.5077\text{ V}$ |

---

## 5. Sizing Tail Source ($M_5$) & Mirror ($M_6$) under CMRR Constraint

* **Lower-bound check:** $V_{ov5} < V_{iCM,\min} - V_{GS1,2} = 0.7 - 0.5174 = 0.1826\text{ V}$. The target $V_{ov5} \approx 100\text{ mV}$ is confirmed to fall well within the allowable lower limit.
* **CMRR Constraint:** With $CMRR = A_{V,DC} / A_{V,CM} \ge 70\text{ dB}\ (3162.28\text{ V/V})$, the allowable common-mode gain is constrained by:

$$A_{V,CM} \le \frac{39.81}{3162.28} = 0.0126\text{ V/V}$$

Expressing common-mode gain as $A_{V,CM} \approx \frac{g_{m1,2}}{g_{m3,4} \cdot \left(1 + \frac{2g_{m1,2}}{g_{ds5}}\right)}$ and solving for output conductance $g_{ds5}$:

$$g_{ds5} \le \frac{2 \cdot g_{m1,2}}{\frac{g_{m1,2}}{0.0126 \cdot g_{m3,4}} - 1} = 2.67\,\mu\text{S}$$

In Open-LUT, select `sky130_nfet_01v8` at $V_{ds} = 0.3\text{ V}$ and click **Update** once. Enter $I_D = 0.02\text{ mA}$ and iterate $g_m/I_D$ within the $14\text{--}17\text{ S/A}$ range (clicking **`Clear Form / Reset Plots`** before each entry) to evaluate attainable $g_{ds}$ bounds. At $g_m/I_D = 16\text{ S/A}$, $g_{ds5} = 2.3\,\mu\text{S}$ ($< 2.67\,\mu\text{S}$) and $V_{ov5} = 0.1034\text{ V}$ are achieved. Snapping to layout grid yields the finalized parameters in **Table 4**.

### Table 4: Sizing and Biasing for $M_5$

| Parameter | $(g_m/I_D)_5$ | $L_5$ | $W_5$ | $g_{m5}$ | $g_{ds5}$ | $V_{ov5}$ | $V_{GS5}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $16\text{ S/A}$ | $2.7470\,\mu\text{m}$ | $42.0700\,\mu\text{m}$ | $0.3200\text{ mS}$ | $2.3\,\mu\text{S}$ | $0.1034\text{ V}$ | $0.6508\text{ V}$ |

Mirror transistor $M_6$ carries $I_{bias} = 10\,\mu\text{A}$ (half of $I_{SS}$) and is scaled to $(W/L)_6 = 21.0350 / 2.7470\,\mu\text{m}$.

---

## 6. Verification in Xschem & Ngspice

The design was verified using Xschem and Ngspice within the IIC-OSIC-TOOLS Docker environment. The simulation setup is shown in **Figure 5**, with schematic files provided in the `./cir/` subfolder.

![Figure 5: Xschem Simulation Setup for Part 2 Verification](img/fig5_xschem_setup.png)
*Figure 5. Xschem simulation setup for Part 2 verification.*

A critical step in design validation is ensuring that all transistors operate at their intended DC operating points under appropriate common-mode biasing ($V_{CM}$). To evaluate the valid bias window, a DC common-mode sweep (`.dc VCM 0 1.8V`) is performed, tracking input transconductance $g_{m1,2}$ (**Figure 6**) and tail current $I_{D5}$ ($I_{SS}$, **Figure 7**).

![Figure 6: Transconductance gm1,2 vs VCM](img/fig6_gm_vcm.png)
*Figure 6. Transconductance $g_{m1,2}$ vs $V_{CM}$.*

![Figure 7: Tail Current ISS vs VCM](img/fig7_iss_vcm.png)
*Figure 7. Tail current $I_{SS}$ vs $V_{CM}$.*

The sweep plots confirm that maintaining $g_{m1,2} \ge 0.17\text{ mS}$ and holding $I_{D5} \le 20\,\mu\text{A}$ are satisfied across the target $ICMR$ window ($0.7\text{ V to } 1.6\text{ V}$). Iterative DC operating point evaluations identify $V_{CM} = 0.85\text{ V}$ as the optimal common-mode bias. **Table 5** confirms close agreement between Open-LUT predictions and Ngspice DC operating point simulation results at $V_{CM} = 0.85\text{ V}$.

### Table 5: Open-LUT vs. Simulated Operating Point ($V_{CM} = 0.85\text{ V}$)

| Operating Parameter | Open-LUT Value | Simulated Value (Ngspice) |
| :--- | :---: | :---: |
| $g_{m1,2}$ | $0.1700\text{ mS}$ | $0.1776\text{ mS}$ |
| $g_{ds1,2}$ | $1.5000\,\mu\text{S}$ | $1.3710\,\mu\text{S}$ |
| $V_{ov1,2}$ | $0.0548\text{ V}$ | $0.0866\text{ V}$ |
| $V_{GS1,2}$ | $0.5174\text{ V}$ | $0.5597\text{ V}$ |
| $V_{DS1,2}$ | $1.0000\text{ V}$ | $0.9208\text{ V}$ |
| $I_{D1,2}$ | $10.000\,\mu\text{A}$ | $9.9681\,\mu\text{A}$ |
| $g_{m3,4}$ | $0.1050\text{ mS}$ | $0.1161\text{ mS}$ |
| $g_{ds3,4}$ | $1.5000\,\mu\text{S}$ | $1.4780\,\mu\text{S}$ |
| $V_{ov3,4}$ | $0.1519\text{ V}$ | $0.1415\text{ V}$ |
| $V_{GS3,4}$ | $0.5077\text{ V}$ | $0.5889\text{ V}$ |
| $V_{DS3,4}$ | $0.5000\text{ V}$ | $0.5889\text{ V}$ |
| $I_{D3,4}$ | $10.000\,\mu\text{A}$ | $9.9681\,\mu\text{A}$ |
| $g_{m5}$ | $0.3200\text{ mS}$ | $0.3271\text{ mS}$ |
| $g_{ds5}$ | $2.3000\,\mu\text{S}$ | $2.3550\,\mu\text{S}$ |
| $V_{ov5}$ | $0.1034\text{ V}$ | $0.1048\text{ V}$ |
| $V_{GS5}$ | $0.6508\text{ V}$ | $0.6377\text{ V}$ |
| $V_{DS5}$ | $0.3000\text{ V}$ | $0.2627\text{ V}$ |
| $I_{D5}$ | $20.000\,\mu\text{A}$ | $19.9361\,\mu\text{A}$ |

AC frequency response and CMRR curves are evaluated in **Figures 8 & 9**.

![Figure 8: AC Magnitude Response](img/fig8_ac_response.png)
*Figure 8. AC magnitude response.*

![Figure 9: Common-Mode Rejection Ratio (CMRR) vs Frequency](img/fig9_cmrr_response.png)
*Figure 9. Common-Mode Rejection Ratio ($CMRR$) vs frequency.*

To verify $ICMR$ experimentally, the OTA is configured as a unity-gain follower (**Figure 10**). Sweeping $V_{CM}$ from $0$ to $1.8\text{ V}$ and measuring output tracking error ($< 10\text{ mV}$) confirms an operational range of $0.628\text{ V}$ to $1.653\text{ V}$ (**Figure 11**). **Table 6** demonstrates full compliance with all performance targets.

![Figure 10: 5T OTA Configured as Unity-Gain Follower for ICMR Test](img/fig10_unity_gain_follower.png)
*Figure 10. 5T OTA configured as unity-gain follower for ICMR testing.*

![Figure 11: Output Tracking Error Plot across VCM Sweep](img/fig11_tracking_error.png)
*Figure 11. Output tracking error plot across $V_{CM}$ sweep.*

### Table 6: Simulation Results vs. Specifications

| Specification Parameter | Target Requirement | Simulated Performance |
| :--- | :---: | :---: |
| **Open-Loop DC Gain ($A_{V,DC}$)** | $\ge 32.00\text{ dB}$ | $35.84\text{ dB}$ |
| **Gain-Bandwidth Product ($GBW$)** | $\ge 5.00\text{ MHz}$ | $5.56\text{ MHz}$ |
| **Tail Current ($I_{SS}$)** | $\le 20.00\,\mu\text{A}$ | $19.9361\,\mu\text{A}$ |
| **Common-Mode Rejection Ratio ($CMRR$)** | $\ge 70.00\text{ dB}$ | $77.27\text{ dB}$ |
| **Input Common-Mode Range ($ICMR$)** | $0.70\text{ V to } 1.60\text{ V}$ | $0.628\text{ V to } 1.653\text{ V}$ |

---

## 7. Conclusion

Building upon the single-pass framework established in Part 1, the elimination of time-consuming simulation-in-the-loop workflows still applies when incorporating strict $ICMR$ and $CMRR$ constraints. By translating system-level common-mode specifications directly into $V_{DS}$ headroom budgets and output conductance limits, deterministic, single-pass device sizing is fully maintained without relying on trial-and-error simulation loops. Complete schematic files for simulation and verification in Xschem and Ngspice are available in the `./cir/` subfolder.
