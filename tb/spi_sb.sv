class spi_sb extends uvm_scoreboard;
	`uvm_component_utils(spi_sb)
	
	spi_env_cfg m_cfg;
    m_xtn mxtn;
    s_xtn sxtn;
    uvm_tlm_analysis_fifo #(m_xtn) m_fifo;
    uvm_tlm_analysis_fifo #(s_xtn) s_fifo;

	int ctrl;
	bit [127:0]l_Tx,l_Rx;
	bit [127:0]l_mosi,l_miso;
	bit [6:0] char_len;
    bit drv_edge;
    bit lsb;
    int i;
	
	
	  covergroup spi_cov;
        option.per_instance = 1;

        Char_Len: coverpoint mxtn.ctrl [6:0]{
                            bins low      = {[1:32]};
                            bins low_mid  = {[33:64]};
                            bins high_mid = {[65:96]};
                            bins max_high     = {0,[97:127]};}

        Drv_Edge: coverpoint mxtn.ctrl [10:9]{
                            bins Rx = {2'b01};
                            bins Tx = {2'b10};}

        LSB: coverpoint mxtn.ctrl [11];     

        Auto_sel: coverpoint mxtn.ctrl [13]; 

        Divider: coverpoint mxtn.divider{
                            bins div_low  = {[0:2]};
                            bins div_mid  = {[3:5]};
                            bins div_high = {[6:8]};
                            bins div_max  = {[9:11]};}

        Slave_Sel: coverpoint mxtn.ss{
                            bins SS_low = {[0:63]};
                            bins SS_mid = {[64:127]};
                            bins SS_high = {[128:191]};
                            bins SS_full = {[192:256]};}

        ASSXLSB: cross Auto_sel, LSB;
    endgroup
	
	
	function new(string name="spi_sb",uvm_component parent);
		super.new(name,parent);
		m_fifo = new("m_fifo",this);
        s_fifo = new("s_fifo",this);
        spi_cov = new();
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db #(spi_env_cfg)::get(this, "", "env_cfg",m_cfg))
            `uvm_fatal("CONFIG","Getting config database failed")
        if (!uvm_config_db #(int)::get(this,"","int",ctrl))
            `uvm_fatal("CONFIG","Getting config database failed")

        char_len = ctrl [6:0];
        drv_edge = ctrl [9];
        lsb = ctrl [11];
	endfunction
	
	task run_phase(uvm_phase phase);
        forever
            fork 
                begin
                    m_fifo.get(mxtn);
                    mxtn.print();
                end 
                begin
                    s_fifo.get(sxtn);
                    sxtn.print();
                end
            join_any
    endtask
	/*
	    function void check_phase(uvm_phase phase);

        this.TX_Reg = {m_xtn.TX[3], m_xtn.TX[2], m_xtn.TX[1], m_xtn.TX[0]};
        this.RX_Reg = {m_xtn.RX[3], m_xtn.RX[2], m_xtn.RX[1], m_xtn.RX[0]};
        $display("RXXXX = %b",RX_Reg);
        s_xtn.print();
        spi_cov.sample();

        if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i <= 127; i++) begin
                        if (TX_Reg[i] == s_xtn.mosi[i] 
                            && RX_Reg[i] == s_xtn.miso[i])
                            $display("********Data Match*******");
                        else 
                            $display("######## Data Mis-match ####### \n at %d bit.", i);
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        if (TX_Reg[i] == s_xtn.mosi[i] 
                            && RX_Reg[i] == s_xtn.miso[i])
                            $display("********Data Match*******");
                        else 
                            $display("######## Data Mis-match ####### \n at %d bit.",i);
                    end
                end
        end
        else begin
            if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        if (RX_Reg[i] == s_xtn.miso[i]) // (TX_Reg[i] == s_xtn.mosi[i])
                            $display("********A Data Match*******");
                        else 
                            $display("######## Data Mis-match ####### \n at %d bit.",i);
                    end
                end
                else begin
                    for (i = char_len-1; i >=0; i--) begin
                        if //(TX_Reg[i] == s_xtn.mosi[i]) &&
                            (RX_Reg[i] == s_xtn.miso[i])
                            $display("********Data Match*******");
                        else 
                            $display("######## Data Mis-match ####### \n at %d bit.",i);
                    end
                end
        end
*/
	
endclass