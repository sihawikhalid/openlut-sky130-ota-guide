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
N 160 30 210 30 {lab=#net4}
N -40 -10 -40 -0 {lab=#net2}
N -40 -50 -40 -10 {lab=#net2}
N -180 30 -180 40 {lab=#net5}
N -40 80 -40 140 {lab=#net3}
N 120 80 120 140 {lab=#net3}
N 90 30 90 80 {lab=GND}
N 90 30 120 30 {lab=GND}
N -10 30 -10 80 {lab=GND}
N -40 30 -10 30 {lab=GND}
N 210 30 210 40 {lab=#net4}
N 120 140 120 160 {lab=#net3}
N -40 140 -40 160 {lab=#net3}
N -180 180 -180 190 {lab=GND}
N -180 100 -180 120 {lab=#net6}
N 40 260 40 270 {lab=GND}
N -100 230 -0 230 {lab=#net7}
N 40 180 40 200 {lab=#net3}
N 120 160 120 180 {lab=#net3}
N -40 160 -40 180 {lab=#net3}
N 210 100 210 110 {lab=#net6}
N 120 -30 280 -30 {lab=#net1}
N 280 30 280 50 {lab=GND}
N -270 230 -100 230 {lab=#net7}
N -310 260 -310 280 {lab=GND}
N 40 270 40 280 {lab=GND}
N -310 70 -310 90 {lab=VDD}
N -310 150 -310 200 {lab=#net7}
N -260 180 -260 230 {lab=#net7}
N -310 180 -260 180 {lab=#net7}
N -180 30 -80 30 {lab=#net5}
N -180 110 210 110 {lab=#net6}
N 40 230 70 230 {lab=GND}
N 70 230 70 270 {lab=GND}
N 40 270 70 270 {lab=GND}
N -340 230 -310 230 {lab=GND}
N -340 230 -340 270 {lab=GND}
N -340 270 -310 270 {lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} -60 30 0 0 {name=M1
L=0.4205
W=4.7300  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 20 230 0 0 {name=M5
L=1
W=10.5435  
nf=2 mult=1
model=nfet_01v8
spiceprefix=X
}
C {gnd.sym} 340 -40 0 0 {name=l1 lab=GND}
C {vsource.sym} 340 -110 0 0 {name=Vdd value=1.8 savecurrent=false}
C {vdd.sym} 340 -170 0 0 {name=l2 lab=VDD}
C {vdd.sym} 40 -170 0 0 {name=l3 lab=VDD}
C {gnd.sym} 40 280 0 0 {name=l4 lab=GND}
C {vsource.sym} -180 150 0 0 {name=Vcm value=1 savecurrent=false}
C {sky130_fd_pr/nfet_01v8.sym} 140 30 0 1 {name=M2
L=0.4205
W=4.7300 
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {code.sym} -410 -150 0 0 {*  To use this code block, set "spice_ignore" to false; Else, set to true

name=OP_Biasing only_toplevel=false spice_ignore=true value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt


* - Print the operating points
.op                 

.control
	save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm1.msky130_fd_pr__nfet_01v8[id]
	save @m.xm1.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm2.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm2.msky130_fd_pr__nfet_01v8[id]
	save @m.xm2.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[gm]
	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[id]
	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[gds]

	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[gm]
	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[id]
	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[gds]

	save @m.xm5.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm5.msky130_fd_pr__nfet_01v8[id]
	save @m.xm5.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm5.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm5.msky130_fd_pr__nfet_01v8[id]
	save @m.xm5.msky130_fd_pr__nfet_01v8[gds]

		
	save all
	
	run
	
	show xm1.msky130_fd_pr__nfet_01v8
	show xm2.msky130_fd_pr__nfet_01v8
	show xm3.msky130_fd_pr__pfet_01v8_lvt
	show xm4.msky130_fd_pr__pfet_01v8_lvt
	show xm5.msky130_fd_pr__nfet_01v8
	show xm6.msky130_fd_pr__nfet_01v8
	show all
	
		
.endc
"}
C {vsource.sym} -180 70 0 0 {name=Vip value="dc 0 ac 0.5" savecurrent=false}
C {vsource.sym} 210 70 0 0 {name=Vin value="dc 0 ac -0.5" savecurrent=false}
C {gnd.sym} -10 80 0 0 {name=l5 lab=GND}
C {gnd.sym} 90 80 0 0 {name=l6 lab=GND}
C {gnd.sym} -180 190 0 0 {name=l7 lab=GND}
C {capa.sym} 280 0 0 0 {name=C1
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 280 50 0 0 {name=l8 lab=GND}
C {code.sym} -280 -140 0 0 {*  To use this code block, set "spice_ignore" to false; Else, set to true

name=AC_analysis only_toplevel=false spice_ignore=true value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt



.control
		
	save all
	
	ac dec 20 1 100e6	

	meas ac dc_gain MAX vdb(net1) from=1 to=10
	let target_gain = dc_gain -3
	meas ac f_3db WHEN vdb(net1) = target_gain
	meas ac gbw WHEN vdb(net1) = 0
	
	let Av = vdb(net1)
	
	plot Av title 'DC Gain (Magnitude)'
	plot cph(net1)*180/pi title 'DC Gain (Phase)' 	
		
.endc
"}
C {code.sym} -550 -150 0 0 {*  To use this code block, set "spice_ignore" to false; Else, set to true

name=VCM_Sweep only_toplevel=false spice_ignore=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt


* - Sweep Vcm and find the optimal operating point (gm, gds, id, biasing, etc) 
.dc Vcm 0 1.8 0.1 


.control
	save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm1.msky130_fd_pr__nfet_01v8[id]
	save @m.xm1.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm2.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm2.msky130_fd_pr__nfet_01v8[id]
	save @m.xm2.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[gm]
	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[id]
	save @m.xm3.msky130_fd_pr__pfet_01v8_lvt[gds]

	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[gm]
	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[id]
	save @m.xm4.msky130_fd_pr__pfet_01v8_lvt[gds]

	save @m.xm5.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm5.msky130_fd_pr__nfet_01v8[id]
	save @m.xm5.msky130_fd_pr__nfet_01v8[gds]

	save @m.xm5.msky130_fd_pr__nfet_01v8[gm]
	save @m.xm5.msky130_fd_pr__nfet_01v8[id]
	save @m.xm5.msky130_fd_pr__nfet_01v8[gds]
	
	save all
	
	run
	
	let gm_1_2 = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
	let i5 = @m.xm5.msky130_fd_pr__nfet_01v8[id]
	
	plot gm_1_2 title 'VCM vs gm_12'
	plot i5 title 'VCM vs ISS'
	plot v(net2)-v(net3) title 'VCM vs Vds_12'
	plot v(vdd)-v(net2) title 'VCM vs Vds_34'
	plot v(net3) title 'VCM vs Vds_5'
		
.endc
"}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 100 -80 0 0 {name=M4
L=0.7495
W=1.9280
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} -20 -80 0 1 {name=M3
L=0.7495
W=1.9280
nf=1 mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -290 230 0 1 {name=M6
L=1
W=5.2720  
nf=2 mult=1
model=nfet_01v8
spiceprefix=X
}
C {gnd.sym} -310 280 0 0 {name=l9 lab=GND}
C {isource.sym} -310 120 0 0 {name=I0 value=10u}
C {vdd.sym} -310 70 0 0 {name=l10 lab=VDD}
