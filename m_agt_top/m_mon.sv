class m_mon extends uvm_monitor;

`uvm_component_utils(m_mon)
virtual spi_m_if.MMON_MP vif;
master_agt_cfg m_agt_cfg;

uvm_analysis_port #(m_xtn) m_mon_port;

function new(string name="m_mon",uvm_component parent);
	super.new(name,parent);
	m_mon_port = new("m_mon_port",this);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(master_agt_cfg)::get(this,"","mas_agt_cfg",m_agt_cfg))
		`uvm_fatal(get_type_name(),"Cannot get the m_agt_cfg into m_mon, Have you set it?")
	`uvm_info(get_type_name(),"This is build_phase in Master_Monitor",UVM_LOW)
endfunction

function void connect_phase(uvm_phase phase);
	vif = m_agt_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
forever
	begin
		collect_data();
	end
endtask

task collect_data();
//creating handle for master transaction class to collect data from dut
m_xtn m_data;
m_data=m_xtn::type_id::create("m_data");
//Initially waiting for 1 clock cycle
@(vif.spi_m_mon_cb)
//waiting until ack signal is HIGH to collect data from DUT
//while(vif.spi_m_mon_cb.wb_ack_o!=1)
	wait(vif.spi_m_mon_cb.wb_ack_o)
	@(vif.spi_m_mon_cb)
//First we have to sample we and addr signals based on which we store the din in corresponding registers
	m_data.we=vif.spi_m_mon_cb.wb_we_i;
	m_data.addr=vif.spi_m_mon_cb.wb_adr_i;
	begin
	if(m_data.addr == 5'h0 && m_data.we == 1'b1)
		m_data.Tx0 = vif.spi_m_mon_cb.wb_dat_i;

	else if(m_data.addr == 5'h4 && m_data.we == 1'b1)
		m_data.Tx1 = vif.spi_m_mon_cb.wb_dat_i;

	else if(m_data.addr == 5'h8 && m_data.we == 1'b1)
		m_data.Tx2 = vif.spi_m_mon_cb.wb_dat_i;

	else if(m_data.addr == 5'hc && m_data.we == 1'b1)
		m_data.Tx3 = vif.spi_m_mon_cb.wb_dat_i;

	//To retrieve data from any one of the Rx Registers

	else if(m_data.addr == 5'h0 && m_data.we == 1'b0)
		m_data.Rx0 = vif.spi_m_mon_cb.wb_dat_o;

	else if(m_data.addr == 5'h4 && m_data.we == 1'b0)
		m_data.Rx1 = vif.spi_m_mon_cb.wb_dat_o;

	else if(m_data.addr == 5'h8 && m_data.we == 1'b0)
		m_data.Rx2 = vif.spi_m_mon_cb.wb_dat_o;

	else if(m_data.addr == 5'hc && m_data.we == 1'b0)
		m_data.Rx3 = vif.spi_m_mon_cb.wb_dat_o;

	//sampling the CTRL,DIVIDER and SS registers

	else if(m_data.addr == 5'h10 && m_data.we == 1'b1)
		m_data.ctrl = vif.spi_m_mon_cb.wb_dat_i;

	else if(m_data.addr == 5'h14 && m_data.we == 1'b1)
		m_data.divider = vif.spi_m_mon_cb.wb_dat_i;

	else if(m_data.addr == 5'h18 && m_data.we == 1'b1)
		m_data.ss = vif.spi_m_mon_cb.wb_dat_i;
	end	
`uvm_info("MASTER_MONITOR",$sformatf("Printing from Master Monitor : \n %s",m_data.sprint()),UVM_LOW)
	m_mon_port.write(m_data);
$display("------pushed m_data to monport----");
endtask
endclass
