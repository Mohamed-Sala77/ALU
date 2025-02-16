##**** before you run the do file change the diroctory from file->change diroctory to the recent file 

## for quit the last simulation
quit -sim

## for compile the files "we here compile with f files for more general case "
vlog -coveropt 3 +cover +acc -sv my_top.sv -v alu_si_vision.v

## for run the simulation
vsim -coverage -novopt -suppress 12110 my_top -c -do "coverage save -onexit -directive -codeAll cover_repo.ucdb"

## Add interface signals to the waveform
add wave -position insertpoint sim:/my_top/intf/clk
add wave -position insertpoint sim:/my_top/intf/A
add wave -position insertpoint sim:/my_top/intf/B
add wave -position insertpoint sim:/my_top/intf/a_op
add wave -position insertpoint sim:/my_top/intf/b_op
add wave -position insertpoint sim:/my_top/intf/a_en
add wave -position insertpoint sim:/my_top/intf/b_en
add wave -noupdate -height 60 -divider "divider"
add wave -position insertpoint sim:/my_top/intf/ALU_en
add wave -position insertpoint sim:/my_top/intf/rst_n
add wave -position insertpoint sim:/my_top/intf/C

## for run the simulation 
run -all

## for generate the report
coverage report -details -output coverage_report.txt
vcover report -html cover_repo.ucdb
