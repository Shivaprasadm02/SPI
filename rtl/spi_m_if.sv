interface spi_m_if(input bit clk);

bit wb_clk_i;
bit wb_rst_i;
bit wb_we_i;
bit [4:0] wb_adr_i;
bit [31:0] wb_dat_i;
bit [31:0] wb_dat_o;
bit [3:0] wb_sel_i;
bit wb_stb_i;
bit wb_cyc_i;

bit wb_err_o;
bit wb_ack_o;
bit wb_int_o;

	clocking spi_m_drv_cb@(posedge clk);
		default input #1 output #1;
		output wb_clk_i,wb_rst_i,wb_we_i,wb_adr_i,wb_dat_i,wb_sel_i,wb_stb_i,wb_cyc_i;
		input wb_dat_o,wb_ack_o,wb_int_o,wb_err_o;
	endclocking
	
	clocking spi_m_mon_cb@(negedge clk);
		default input #1 output #1;
		input wb_clk_i,wb_rst_i,wb_we_i,wb_adr_i,wb_dat_i,wb_sel_i,wb_stb_i,wb_cyc_i,
		wb_dat_o,wb_ack_o,wb_int_o,wb_err_o;
	endclocking
	
	modport MDR_MP(clocking spi_m_drv_cb);
	modport MMON_MP(clocking spi_m_mon_cb);
	
endinterface