`timescale 1ns / 10ps
module top;

    import spi_test_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh";

	bit clock;  
	always 
	#10 clock=!clock;     
	
   spi_m_if min(clock);
   spi_s_if sin(clock);
   
 //  spi_base_test test;
   
    spi_top DUV(
				.wb_clk_i(clock),
				.wb_rst_i(min.wb_rst_i),
				.wb_adr_i(min.wb_adr_i), 
				.wb_dat_i(min.wb_dat_i), 
				.wb_dat_o(min.wb_dat_o), 
				.wb_sel_i(min.wb_sel_i),
				.wb_we_i(min.wb_we_i),
				.wb_stb_i(min.wb_stb_i), 
				.wb_cyc_i(min.wb_cyc_i),
				.wb_ack_o(min.wb_ack_o),
				.wb_err_o(min.wb_err_o), 
				.wb_int_o(min.wb_int_o),
				
				.ss_pad_o(sin.ss_pad_o), 
				.sclk_pad_o(sin.sclk_pad_o), 
				.mosi_pad_o(sin.mosi_pad_o), 
				.miso_pad_i(sin.miso_pad_i)
					);
							   
    initial
	begin
		uvm_config_db #(virtual spi_m_if)::set(null,"*","min",min);
		uvm_config_db #(virtual spi_s_if)::set(null,"*","sin",sin);
	
		//test=new("test",this);
		run_test( );
    end  
	
endmodule
