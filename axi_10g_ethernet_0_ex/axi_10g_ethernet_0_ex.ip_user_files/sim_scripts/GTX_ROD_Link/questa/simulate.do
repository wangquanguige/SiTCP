onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib GTX_ROD_Link_opt

do {wave.do}

view wave
view structure
view signals

do {GTX_ROD_Link.udo}

run -all

quit -force
