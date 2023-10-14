class s_agt extends uvm_agent;
`uvm_component_utils(s_agt);

s_drv sdrvh;
s_mon smonh;
s_seqr sseqrh;
slave_agt_cfg m_cfg;

function new(string name = "s_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(slave_agt_cfg)::get(this,"","slv_agt_cfg",m_cfg))
		`uvm_fatal(get_full_name,"cannot get cfg in slave agt");
smonh=s_mon::type_id::create("smonh",this);
if(m_cfg.is_active==UVM_ACTIVE)
begin
sdrvh=s_drv::type_id::create("sdrvh",this);
sseqrh=s_seqr::type_id::create("sseqrh",this);
end
endfunction

function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(m_cfg.is_active==UVM_ACTIVE)
			sdrvh.seq_item_port.connect(sseqrh.seq_item_export);
endfunction

endclass