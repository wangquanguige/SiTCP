onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+GTX_ROD_Link -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.GTX_ROD_Link xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {GTX_ROD_Link.udo}

run -all

endsim

quit -force
