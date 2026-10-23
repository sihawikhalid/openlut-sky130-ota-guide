v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 120 -50 120 -0 {lab=#net1}
N -40 -160 -40 -110 {lab=VDD}
N -40 -160 120 -160 {lab=VDD}
N 120 -160 120 -110 {lab=VDD}
N 0 -80 80 -80 {lab=#net2}
N -40 -30 10 -30 {lab=#net2}
N 10 -80 10 -30 {lab=#net2}
N -70 -80 -40 -80 {lab=VDD}
N -70 -160 -70 -80 {lab=VDD}
N -70 -160 -40 -160 {lab=VDD}
N 120 -80 150 -80 {lab=VDD}
N 150 -160 150 -80 {lab=VDD}
N 120 -160 150 -160 {lab=VDD}
N -40 60 -40 80 {lab=#net3}
N -40 180 120 180 {lab=#net3}
N 120 60 120 80 {lab=#net3}
N 340 -170 340 -140 {lab=VDD}
N 340 -80 340 -40 {lab=GND}
N 40 -170 40 -160 {lab=VDD}
N 160 30 210 30 {lab=#net1}
N -40 -10 -40 -0 {lab=#net2}
N -40 -50 -40 -10 {lab=#net2}
N -180 30 -180 40 {lab=#net4}
N -40 80 -40 140 {lab=#net3}
N 120 80 120 140 {lab=#net3}
N 90 30 90 80 {lab=GND}
N 90 30 120 30 {lab=GND}
N -10 30 -10 80 {lab=GND}
N -40 30 -10 30 {lab=GND}
N 120 140 120 160 {lab=#net3}
N -40 140 -40 160 {lab=#net3}
N -180 180 -180 190 {lab=GND}
N -180 100 -180 120 {lab=#net4}
N 40 260 40 270 {lab=GND}
N -100 230 -0 230 {lab=#net5}
N 40 180 40 200 {lab=#net3}
N 120 160 120 180 {lab=#net3}
N -40 160 -40 180 {lab=#net3}
N -270 230 -100 230 {lab=#net5}
N -310 260 -310 280 {lab=GND}
N 40 270 40 280 {lab=GND}
N -310 70 -310 90 {lab=VDD}
N -310 150 -310 200 {lab=#net5}
N -260 180 -260 230 {lab=#net5}
N -310 180 -260 180 {lab=#net5}
N -180 30 -80 30 {lab=#net4}
N 40 230 70 230 {lab=GND}
N 70 230 70 270 {lab=GND}
N 40 270 70 270 {lab=GND}
N -340 230 -310 230 {lab=GND}
N -340 230 -340 270 {lab=GND}
N -340 270 -310 270 {lab=GND}
N -180 40 -180 100 {lab=#net4}
N 210 -20 210 30 {lab=#net1}
N 120 -20 210 -20 {lab=#net1}
C {gnd.sym} 340 -40 0 0 {name=l1 lab=GND}
C {vsource.sym} 340 -110 0 0 {name=Vdd value=1.8 savecurrent=false}
C {vdd.sym} 340 -170 0 0 {name=l2 lab=VDD}
C {vdd.sym} 40 -170 0 0 {name=l3 lab=VDD}
C {gnd.sym} 40 280 0 0 {name=l4 lab=GND}
C {vsource.sym} -180 150 0 0 {name=Vcm value=0.85 savecurrent=false}
C {gnd.sym} -10 80 0 0 {name=l5 lab=GND}
C {gnd.sym} 90 80 0 0 {name=l6 lab=GND}
C {gnd.sym} -180 190 0 0 {name=l7 lab=GND}
C {gnd.sym} -310 280 0 0 {name=l9 lab=GND}
C {isource.sym} -310 120 0 0 {name=I0 value=10u}
C {vdd.sym} -310 70 0 0 {name=l10 lab=VDD}
C {code.sym} -340 -160 0 0 {*  To use this code block, set "spice_ignore" to false; Else, set to true

name=VCM_Vs_Sweep only_toplevel=false spice_ignore=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.control
	
	
	save all
	
	* - Sweep Vcm 
	dc Vcm 0 1.8 0.001
	
	* Get Vdiff
	let vdiff = v(net1) - v(net4)
	
	plot v(net1) v(net4) title 'ICMR Transfer Characteristic'
	plot vdiff title 'Tracking Deviation Error'

	meas dc vicm_min find v(net1) when vdiff=0.010 fall=1
	meas dc vicm_max find v(net1) when vdiff=-0.010 fall=1
		
.endc
"}
C {sky130_fd_pr/nfet_01v8.sym} 20 230 0 0 {name=M5
L=2.7470
W=42.0700  
nf=5 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 100 -80 0 0 {name=M4
L=1.213
W=23.8550
nf=3 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} -20 -80 0 1 {name=M3
L=1.213
W=23.8550
nf=3 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -290 230 0 1 {name=M6
L=2.7470
W=21.0350  
nf=3 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} -60 30 0 0 {name=M1
L=2.0755
W=22.5430
nf=3 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 140 30 0 1 {name=M2
L=2.0755
W=22.5430
nf=3 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
