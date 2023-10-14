class m_drv extends uvm_driver#(m_xtn);

`uvm_component_utils(m_drv)
virtual spi_m_if.MDR_MP vif;
master_agt_cfg m_agt_cfg;

function new(string name="m_drv",uvm_component parent);
	super.new(name,parent);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(master_agt_cfg)::get(this,"","mas_agt_cfg",m_agt_cfg))
		`uvm_fatal(get_type_name(),"Cannot get the m_agt_cfg into m_drv, Have you set it?")
	`uvm_info(get_type_name(),"This is build_phase in Master_dirver",UVM_LOW)
endfunction

function void connect_phase(uvm_phase phase);
	vif = m_agt_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
	@(vif.spi_m_drv_cb);
		vif.spi_m_drv_cb.wb_rst_i<=1'b1;
		//During reset state the signals strb and cyc should be low
		vif.spi_m_drv_cb.wb_stb_i <= 1'b0;
		vif.spi_m_drv_cb.wb_cyc_i <= 1'b0;
	@(vif.spi_m_drv_cb);
		vif.spi_m_drv_cb.wb_rst_i <= 1'b0;	
	forever 
		begin
		seq_item_port.get_next_item(req);
		//calling the user-defined task to send data to DUT
		send_to_dut(req);
		//sending acknowledgement to sequence that data is received and processed successfully
		seq_item_port.item_done();
	end
`uvm_info("MASTER_DRIVER",$sformatf("Printnig from Master Driver : \n %s",req.sprint()),UVM_LOW)
endtask

task send_to_dut(m_xtn xtn);
	//`uvm_info("MASTER_DRIVER",$sformatf("Printnig from Master Driver : \n %s",xtn.sprint()),UVM_LOW)
	
	@(vif.spi_m_drv_cb);
//To load the data into SPI(DUT) the signals stb and cyc should be high
	vif.spi_m_drv_cb.wb_stb_i <= 1'b1;
	vif.spi_m_drv_cb.wb_cyc_i <= 1'b1;
	vif.spi_m_drv_cb.wb_we_i<=xtn.we;
	vif.spi_m_drv_cb.wb_dat_i<=xtn.din;
	vif.spi_m_drv_cb.wb_adr_i<=xtn.addr;
//Have to drive sel signal to decide which bytes of register can store data
	vif.spi_m_drv_cb.wb_sel_i<=4'b1111;
$display("std running in master drv ");
`uvm_info("MASTER_DRIVER",$sformatf("Printnig from std of  Master Driver : \n %s",req.sprint()),UVM_LOW)
//Once data is received by SPI we have to disable stb and cyc signals
//For that we have to wait until we receive acknowledgement signal from SPI
	wait(vif.spi_m_drv_cb.wb_ack_o);
//`uvm_info("MASTER_DRIVER",$sformatf("Printnig from Master Driver : \n %s",xtn.sprint()),UVM_LOW)
		//@(vif.spi_m_drv_cb);       //Waiting until ack becomes 1
	vif.spi_m_drv_cb.wb_stb_i <= 1'b0;
	vif.spi_m_drv_cb.wb_cyc_i <= 1'b0;
$display("std complete in master drv");
endtask

endclass
