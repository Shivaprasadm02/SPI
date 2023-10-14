class m_agt_top extends uvm_env;

`uvm_component_utils(m_agt_top);

m_agt magth[];
spi_env_cfg m_cfg;

function new(string name="m_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_env_cfg)::get(this,"","env_cfg",m_cfg))
		`uvm_fatal(get_full_name,"cannot get in master agent top")
	if(m_cfg.has_magent)
	begin	
		magth=new[m_cfg.no_of_magent];
		foreach(magth[i])
		begin
			magth[i]=m_agt::type_id::create($sformatf("magth[%0d]",i),this);
			uvm_config_db#(master_agt_cfg)::set(this,"*","mas_agt_cfg",m_cfg.mas_cfg[i]);
			$display("mas_cfg set in m top : %p",m_cfg);
		end
	end		
endfunction

endclass


/*
class m_agt_top extends uvm_env;

`uvm_component_utils(m_agt_top);

m_agt magth[];
spi_env_cfg m_cfg;

function new(string name="m_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_env_cfg)::get(this,"","env_cfg",m_cfg));
		`uvm_fatal(get_full_name,"cannot get in mas agt top");
	magth=new[m_cfg.no_of_magt];
	foreach(magth[i])
		magth[i]=m_agt::type_id::create($sformatf("magth[%0d]",i),this);
endfunction

endclass
*/