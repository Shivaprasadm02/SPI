class s_agt_top extends uvm_env;

`uvm_component_utils(s_agt_top)

spi_env_cfg m_cfg;
s_agt sagth[];

function new(string name="s_agt_top",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
/*
	super.build_phase(phase);
	sagth=new[no_of_sagt];
	foreach(sagth[i])
		sagth[i]=s_agt::type_id::create($sformatf("sagth[%0d]",i),this);
*/
super.build_phase(phase);
	if(!uvm_config_db#(spi_env_cfg)::get(this,"","env_cfg",m_cfg))
		`uvm_fatal(get_full_name,"cannot get in slv agt top")
	if(m_cfg.has_sagent)
	begin	
		sagth=new[m_cfg.no_of_sagent];
		foreach(sagth[i])
		begin
			sagth[i]=s_agt::type_id::create($sformatf("sagth[%0d]",i),this);
			uvm_config_db#(slave_agt_cfg)::set(this,"*","slv_agt_cfg",m_cfg.slv_cfg[i]);
		end
	end		
endfunction

endclass