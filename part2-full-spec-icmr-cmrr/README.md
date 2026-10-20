# Part 2: 5T OTA Sizing in SKY130 with ICMR and CMRR Constraints using Open-LUT

> A step-by-step guide extending the Open-LUT sizing methodology to meet Input Common-Mode Range (ICMR) and Common-Mode Rejection Ratio (CMRR) specifications for a 5T OTA in SkyWater 130nm PDK.

> [!NOTE]
> **Scope & Focus:** This guide demonstrates how to navigate and leverage Open-LUT to handle ICMR and CMRR constraints. While essential $g_m/I_D$ equations are included, primary focus is placed on tool execution and simulation verification in Ngspice and Xschem.

---

## 1. Design Specifications

This second part extends the 5T OTA design methodology introduced in Part 1 by incorporating strict Input Common-Mode Range ($ICMR$) and Common-Mode Rejection Ratio ($CMRR$) targets. **Table 1** summarizes the expanded specifications.

### Table 1: Design Specifications

| Specification Parameter | Symbol | Target Value |
| :--- | :---: | :---: |
| **PDK Technology** | - | SkyWater 130nm (SKY130) |
| **Supply Voltage** | $V_{DD}$ | $1.8\\text{ V}$ |
| **Reference Current** | $I_{bias}$ | $10\\,\mu\\text{A}$ |
| **Tail Current** | $I_{SS}$ | $20\\,\mu\\text{A}$ |
| **Capacitive Load** | $C_L$ | $5\\text{ pF}$ |
| **Open-Loop DC Gain** | $A_{V,DC}$ | $\\ge 32\\text{ dB}\\ (39.81\\text{ V/V})$ |
| **Gain-Bandwidth Product** | $GBW$ | $\\ge 5\\text{ MHz}$ |
| **Input Common-Mode Range** | $ICMR$ | $0.7\\text{ V to } 1.6\\text{ V}$ |
| **Common-Mode Rejection Ratio** | $CMRR$ | $\\ge 70\\text{ dB}\\ (3162.28\\text{ V/V})$ |

---

## 2. $V_{DS}$ Bias Allocation & ICMR Constraints

The $ICMR$ bounds of an NMOS-input 5T OTA dictate the minimum and maximum gate voltages for $M_1/M_2$:

$$V_{iCM,\\min} > V_{GS1,2} + V_{ov5}$$

$$V_{iCM,\\max} < V_{DD} - \vert{}V_{GS3,4}\vert{} + V_{th1,2} \\approx V_{DD} - \vert{}V_{GS3,4}\vert{} + V_{GS1,2} + V_{ov1,2}$$

* **Lower Bound Limit:** For $V_{iCM,\\min} = 0.7\\text{ V}$ and allocating $V_{ov5} \\approx 100\\text{ mV}$, $V_{GS1,2}$ must satisfy $V_{GS1,2} < 0.6\\text{ V}$. To achieve this at the required transconductance efficiency, an LVT NMOS device (`sky130_nfet_01v8_lvt`) is selected for $M_1/M_2$.
* **Upper Bound Limit:** Targeting $V_{GS1,2} \\approx 0.5\\text{ V}$ and $V_{ov1,2} \\approx 50\\text{ mV}$ for design margin, achieving $V_{iCM,\\max} = 1.6\\text{ V}$ requires $\vert{}V_{GS3,4}\vert{} < 1.8 - 1.6 + 0.5 + 0.05 = 0.75\\text{ V}$.
* **$V_{DS}$ Budget Allocation:** Tail transistor $M_5$ is assigned $V_{DS5} = 0.3\\text{ V}$ ($> V_{ov5}$). Mirror loads $M_3/M_4$ (diode-connected) are allocated $V_{DS3,4} = \vert{}V_{GS3,4}\vert{} = 0.5\\text{ V}$ ($< 0.75\\text{ V}$). The remaining $1.0\\text{ V}$ headroom is assigned to $V_{DS1,2}$. **Figure 1** illustrates the target bias allocation.

![Figure 1: Initial VDS Bias Allocation under ICMR Constraints](img/fig1_vds_allocation.png)
*Figure 1. Initial $V_{DS}$ Bias Allocation under ICMR constraints.*

---

## 3. Sizing Differential Input Pair ($M_1/M_2$)

Re-applying $GBW$ and gain constraints ($g_{m1,2} \\ge 0.16\\text{ mS}$, $(g_m/I_D)_{1,2} \\ge 16\\text{ S/A}$, $g_{ds1,2} \\le 2\\,\\mu\\text{S}$) with target margin $g_{m1,2} = 0.17\\text{ mS}$ and $g_{ds1,2} = 1.5\\,\\mu\\text{S}$:

Remember to click **`Clear Form / Reset Plots`** first. Select `sky130_nfet_01v8_lvt` at $V_{ds} = 1.0\\text{ V}$ and enter $g_m = 0.17\\text{ mS}$, $I_D = 0.01\\text{ mA}$, and $g_{ds} = 0.0015\\text{ mS}$ into Open-LUT. Grid-snapped dimensions and extracted parameters are summarized in **Table 2**.

### Table 2: Sizing and Biasing for $M_1/M_2$

| Parameter | $(g_m/I_D)_{1,2}$ | $L_{1,2}$ | $W_{1,2}$ | $g_{m1,2}$ | $g_{ds1,2}$ | $V_{ov1,2}$ | $V_{GS1,2}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $17\\text{ S/A}$ | $2.0755\\,\\mu\\text{m}$ | $22.5430\\,\\mu\\text{m}$ | $0.17\\text{ mS}$ | $1.5\\,\\mu\\text{S}$ | $0.0548\\text{ V}$ | $0.5174\\text{ V}$ |

---

## 4. Sizing Current Mirror Loads ($M_3/M_4$)

With $V_{GS1,2} = 0.5174\\text{ V}$ from Table 2, the upper-bound $V_{GS3,4}$ limit is updated: $\vert{}V_{GS3,4}\vert{} < 1.8 - 1.6 + 0.5174 + 0.0548 = 0.7722\\text{ V}$. The allocated $V_{DS3,4} = V_{GS3,4} = 0.5\\text{ V}$ remains fully valid.

Clear the form using **`Clear Form / Reset Plots`**, select `sky130_pfet_01v8_lvt` at $V_{ds} = 0.5\\text{ V}$, and click **Update**. Examining $g_m/I_D$ vs $V_{GS}$ (**Figure 2**) shows the target range corresponds to $g_m/I_D \\approx 6.5\\text{--}11\\text{ S/A}$.

![Figure 2: gm/ID vs VGS for sky130_pfet_01v8_lvt at Vds = 0.5 V](img/fig2_pmos_lvt_gm_id.png)
*Figure 2. $g_m/I_D$ vs $V_{GS}$ for `sky130_pfet_01v8_lvt` at $V_{ds} = 0.5\\text{ V}$.*

Iterate the inputting of $g_m/I_D$ values within the $6.5\\text{--}11\\text{ S/A}$ range across trial runs until $V_{GS3,4} = 0.5000\\text{ V}$ is achieved. At $g_m/I_D = 10.5\\text{ S/A}$, $V_{GS3,4} = 0.5077\\text{ V} \\approx 0.5\\text{ V}$ is matched. Finalized parameters are listed in **Table 3**.

### Table 3: Sizing and Biasing for $M_3/M_4$

| Parameter | $(g_m/I_D)_{3,4}$ | $L_{3,4}$ | $W_{3,4}$ | $g_{m3,4}$ | $g_{ds3,4}$ | $V_{ov3,4}$ | $V_{GS3,4}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $10.5\\text{ S/A}$ | $1.2130\\,\\mu\\text{m}$ | $23.8550\\,\\mu\\text{m}$ | $0.1050\\text{ mS}$ | $1.5\\,\\mu\\text{S}$ | $0.1519\\text{ V}$ | $0.5077\\text{ V}$ |

---

## 5. Sizing Tail Source ($M_5$) & Mirror ($M_6$) under CMRR Constraint

* **Lower-bound check:** $V_{ov5} < V_{iCM,\\min} - V_{GS1,2} = 0.7 - 0.5174 = 0.1826\\text{ V}$. The target $V_{ov5} \\approx 100\\text{ mV}$ is confirmed.
* **CMRR Constraint:** With $CMRR = A_{V,DC} / A_{V,CM} \\ge 70\\text{ dB}\\ (3162.28\\text{ V/V})$, the allowable common-mode gain is:

$$A_{V,CM} \\le \\frac{39.81}{3162.28} = 0.0126\\text{ V/V}$$

Expressing common-mode gain as $A_{V,CM} \\approx \\frac{g_{m1,2}}{g_{m3,4} \\cdot \\left(1 + \\frac{2g_{m1,2}}{g_{ds5}}\\right)}$ and solving for $g_{ds5}$:

$$g_{ds5} \\le \\frac{2 \\cdot g_{m1,2}}{\\frac{g_{m1,2}}{0.0126 \\cdot g_{m3,4}} - 1} = 2.67\\,\\mu\\text{S}$$

Clear the form using **`Clear Form / Reset Plots`**, then query Open-LUT for `sky130_nfet_01v8` at $V_{ds} = 0.3\\text{ V}$. Enter $I_D = 0.02\\text{ mA}$ and iterate $g_m/I_D$ within the $14\\text{--}17\\text{ S/A}$ range to evaluate attainable $g_{ds}$ bounds. At $g_m/I_D = 16\\text{ S/A}$, $g_{ds5} = 2.3\\,\\mu\\text{S}$ ($< 2.67\\,\\mu\\text{S}$) and $V_{ov5} = 0.1034\\text{ V}$ are achieved (**Table 4**).

### Table 4: Sizing and Biasing for $M_5$

| Parameter | $(g_m/I_D)_5$ | $L_5$ | $W_5$ | $g_{m5}$ | $g_{ds5}$ | $V_{ov5}$ | $V_{GS5}$ |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Value** | $16\\text{ S/A}$ | $2.7470\\,\\mu\\text{m}$ | $42.0700\\,\\mu\\text{m}$ | $0.3200\\text{ mS}$ | $2.3\\,\\mu\\text{S}$ | $0.1034\\text{ V}$ | $0.6508\\text{ V}$ |

Mirror transistor $M_6$ is scaled to $(W/L)_6 = 21.0350 / 2.7470\\,\\mu\\text{m}$.

---

## 6. Verification in Xschem & Ngspice

Simulation setup for Part 2 is shown in **Figure 3** (schematic files in `./cir/` subfolder). DC common-mode sweeping (**Figures 4 & 5**) identifies $V_{CM} = 0.85\\text{ V}$ as the optimal bias point.

![Figure 3: Xschem Simulation Setup for Part 2 Verification](img/fig3_xschem_setup.png)
*Figure 3. Xschem simulation setup for Part 2 verification.*

![Figure 4: Transconductance gm1,2 vs VCM](img/fig4_gm_vcm.png)
*Figure 4. Transconductance $g_{m1,2}$ vs $V_{CM}$.*

![Figure 5: Tail Current ISS vs VCM](img/fig5_iss_vcm.png)
*Figure 5. Tail current $I_{SS}$ vs $V_{CM}$.*

**Table 5** compares Open-LUT pre-simulation predictions with Ngspice operating point results at $V_{CM} = 0.85\\text{ V}$.

### Table 5: Open-LUT vs. Simulated Operating Point ($V_{CM} = 0.85\\text{ V}$)

| Operating Parameter | Open-LUT Value | Simulated Value (Ngspice) |
| :--- | :---: | :---: |
| $g_{m1,2}$ | $0.1700\\text{ mS}$ | $0.1776\\text{ mS}$ |
| $g_{ds1,2}$ | $1.5000\\,\\mu\\text{S}$ | $1.3710\\,\\mu\\text{S}$ |
| $V_{ov1,2}$ | $0.0548\\text{ V}$ | $0.0866\\text{ V}$ |
| $V_{GS1,2}$ | $0.5174\\text{ V}$ | $0.5597\\text{ V}$ |
| $V_{DS1,2}$ | $1.0000\\text{ V}$ | $0.9208\\text{ V}$ |
| $I_{D1,2}$ | $10.000\\,\\mu\\text{A}$ | $9.9681\\,\\mu\\text{A}$ |
| $g_{m3,4}$ | $0.1050\\text{ mS}$ | $0.1161\\text{ mS}$ |
| $g_{ds3,4}$ | $1.5000\\,\\mu\\text{S}$ | $1.4780\\,\\mu\\text{S}$ |
| $V_{ov3,4}$ | $0.1519\\text{ V}$ | $0.1415\\text{ V}$ |
| $V_{GS3,4}$ | $0.5077\\text{ V}$ | $0.5889\\text{ V}$ |
| $V_{DS3,4}$ | $0.5000\\text{ V}$ | $0.5889\\text{ V}$ |
| $I_{D3,4}$ | $10.000\\,\\mu\\text{A}$ | $9.9681\\,\\mu\\text{A}$ |
| $g_{m5}$ | $0.3200\\text{ mS}$ | $0.3271\\text{ mS}$ |
| $g_{ds5}$ | $2.3000\\,\\mu\\text{S}$ | $2.3550\\,\\mu\\text{S}$ |
| $V_{ov5}$ | $0.1034\\text{ V}$ | $0.1048\\text{ V}$ |
| $V_{GS5}$ | $0.6508\\text{ V}$ | $0.6377\\text{ V}$ |
| $V_{DS5}$ | $0.3000\\text{ V}$ | $0.2627\\text{ V}$ |
| $I_{D5}$ | $20.000\\,\\mu\\text{A}$ | $19.9361\\,\\mu\\text{A}$ |

AC frequency response and CMRR curves are presented in **Figures 6 & 7**.

![Figure 6: AC Magnitude Response](img/fig6_ac_response.png)
*Figure 6. AC magnitude response.*

![Figure 7: Common-Mode Rejection Ratio (CMRR) vs Frequency](img/fig7_cmrr_response.png)
*Figure 7. Common-Mode Rejection Ratio ($CMRR$) vs frequency.*

**ICMR Verification:** The OTA is configured as a unity-gain follower (**Figure 8**). Sweeping $V_{CM}$ and evaluating output tracking error ($< 10\\text{ mV}$) confirms the operational range of $0.628\\text{ V}$ to $1.653\\text{ V}$ (**Figure 9**). **Table 6** demonstrates full compliance with all specs.

![Figure 8: 5T OTA Configured as Unity-Gain Follower for ICMR Test](img/fig8_unity_gain_follower.png)
*Figure 8. 5T OTA configured as unity-gain follower for ICMR testing.*

![Figure 9: Output Tracking Error Plot across VCM Sweep](img/fig9_tracking_error.png)
*Figure 9. Output tracking error plot across $V_{CM}$ sweep.*

### Table 6: Simulation Results vs. Specifications

| Specification Parameter | Target Requirement | Simulated Performance |
| :--- | :---: | :---: |
| **Open-Loop DC Gain ($A_{V,DC}$)** | $\\ge 32.00\\text{ dB}$ | $35.84\\text{ dB}$ |
| **Gain-Bandwidth Product ($GBW$)** | $\\ge 5.00\\text{ MHz}$ | $5.56\\text{ MHz}$ |
| **Tail Current ($I_{SS}$)** | $\\le 20.00\\,\\mu\\text{A}$ | $19.9361\\,\\mu\\text{A}$ |
| **Common-Mode Rejection Ratio ($CMRR$)** | $\\ge 70.00\\text{ dB}$ | $77.27\\text{ dB}$ |
| **Input Common-Mode Range ($ICMR$)** | $0.70\\text{ V to } 1.60\\text{ V}$ | $0.628\\text{ V to } 1.653\\text{ V}$ |

---

## 7. Conclusion

By integrating ICMR and CMRR bounds into the $V_{DS}$ allocation phase, Open-LUT achieves accurate sizing for complex specifications in a single pass. Complete schematic files are provided in the `./cir/` subfolder.
"""

def save_raw_md_docx(filename, content):
    doc = docx.Document()
    for section in doc.sections:
        section.top_margin = Inches(1.0)
        section.bottom_margin = Inches(1.0)
        section.left_margin = Inches(1.0)
        section.right_margin = Inches(1.0)
        
    style = doc.styles['Normal']
    style.font.name = 'Consolas'
    style.font.size = Pt(9.5)
    style.font.color.rgb = RGBColor(34, 34, 34)

    lines = content.split('\n')
    for line in lines:
        p = doc.add_paragraph()
        p.paragraph_format.space_before = Pt(0)
        p.paragraph_format.space_after = Pt(2)
        r = p.add_run(line)
        r.font.name = 'Consolas'
        r.font.size = Pt(9.5)
        
    doc.save(filename)
    print(f"{filename} saved.")

save_raw_md_docx("Part_1_GitHub_Script.docx", part1_md)
save_raw_md_docx("Part_2_GitHub_Script.docx", part2_md)
