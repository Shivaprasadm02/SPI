interface spi_s_if(input bit clk);

bit [31:0]ss_pad_o;
bit sclk_pad_o;
bit mosi_pad_o;
bit miso_pad_i;

	clocking spi_s_drv_cb@(posedge clk);
		default input #1 output #1;
		input ss_pad_o, sclk_pad_o, mosi_pad_o;
		output miso_pad_i;
	endclocking
	
	clocking spi_s_mon_cb@(negedge clk);
		default input #1 output #1;
		input ss_pad_o, sclk_pad_o, mosi_pad_o, miso_pad_i;
	endclocking
	
	modport SDR_MP(clocking spi_s_drv_cb);
	modport SMON_MP(clocking spi_s_mon_cb);
	
endinterface



