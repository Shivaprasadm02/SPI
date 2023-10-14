class m_agt extends uvm_agent;

`uvm_component_utils(m_agt);

m_drv mdrvh;
m_mon mmonh;
m_seqr mseqrh;
master_agt_cfg m_cfg;

function new(string name = "m_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction
  
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(master_agt_cfg)::get(this,"","mas_agt_cfg",m_cfg))
		`uvm_fatal(get_full_name,"cannot get cfg in m agt");
	mmonh=m_mon::type_id::create("mmonh",this);
	if(m_cfg.is_active==UVM_ACTIVE)
	begin
		mdrvh=m_drv::type_id::create("mdrvh",this);
		mseqrh=m_seqr::type_id::create("mseqrh",this);
	end
endfunction

function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(m_cfg.is_active==UVM_ACTIVE)
			mdrvh.seq_item_port.connect(mseqrh.seq_item_export);
	endfunction

endclass