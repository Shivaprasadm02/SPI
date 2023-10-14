class s_xtn extends uvm_sequence_item;

`uvm_object_utils(s_xtn);

rand bit[127:0] miso;
bit[127:0] mosi;
bit s_clk;
bit ss_pad_i;

function void do_print(uvm_printer printer);
	super.do_print(printer);
	printer.print_field("miso",this.miso,128,UVM_HEX);
	printer.print_field("mosi",this.mosi,128,UVM_HEX);
	printer.print_field("s_clk",this.s_clk,1,UVM_HEX);
	printer.print_field("ss_pad",this.ss_pad_i,1,UVM_HEX);
endfunction

endclass
