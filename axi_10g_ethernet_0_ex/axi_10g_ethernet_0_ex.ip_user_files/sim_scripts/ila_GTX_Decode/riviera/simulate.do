onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ila_GTX_Decode -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ila_GTX_Decode xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ila_GTX_Decode.udo}

run -all

endsim

quit -force
