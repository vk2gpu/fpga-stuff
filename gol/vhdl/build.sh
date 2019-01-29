ghdl -a --std=08 gol_cell.vhd
ghdl -a --std=08 gol_cell_tb.vhd
ghdl -e --std=08 gol_cell
ghdl -e --std=08 gol_cell_tb

ghdl -a --std=08 gol.vhd
ghdl -a --std=08 gol_tb.vhd
ghdl -e --std=08 gol
ghdl -e --std=08 gol_tb
ghdl -r --std=08 gol_tb
