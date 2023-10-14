class spi_env extends uvm_env;
`uvm_component_utils(spi_env);

m_agt_top magth;
s_agt_top sagth;

spi_sb sbh;
virtual_sequencer v_seqrh;

spi_env_cfg m_cfg;

function new(string name="spi_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_env_cfg)::get(this,"","env_cfg",m_cfg))
	`uvm_fatal(get_full_name,"err at get in env");
	
	if(m_cfg.has_magent)
		magth=m_agt_top::type_id::create("magth",this);
		
	if(m_cfg.has_sagent)
		sagth=s_agt_top::type_id::create("sagth",this);
	
	if(m_cfg.has_virtual_sequencer)
		v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);
	
	if(m_cfg.has_scoreboard)
		sbh=spi_sb::type_id::create("spi_sb",this);
endfunction

function void connect_phase(uvm_phase phase);	
	super.connect_phase(phase);
		if(m_cfg.has_virtual_sequencer) 
		begin
			if(m_cfg.has_magent)
			foreach(m_cfg.mas_cfg[i])
				v_seqrh.mseqrh[i]=magth.magth[i].mseqrh;
			if(m_cfg.has_sagent)
			foreach(m_cfg.slv_cfg[i])
				v_seqrh.sseqrh[i]=sagth.sagth[i].sseqrh;
		end 
		
		if(m_cfg.has_scoreboard) 
		begin
			if(m_cfg.has_magent)
				for(int i=0;i<m_cfg.no_of_magent;i++)
					magth.magth[i].mmonh.m_mon_port.connect(sbh.m_fifo.analysis_export);		
			if(m_cfg.has_sagent)
				for(int i=0;i<m_cfg.no_of_sagent;i++) 
					sagth.sagth[i].smonh.s_mon_port.connect(sbh.s_fifo.analysis_export);
		end
		
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction

endclass

/*
class spi_env extends uvm_env;
`uvm_component_utils(spi_env);

m_agt_top magth;
s_agt_top sagth;

spi_sb sbh;
virtual_sequencer v_seqrh;

spi_env_cfg m_cfg;

function new(string name="spi_env",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_env_cfg)::get(this,"","env_cfg",m_cfg))
	`uvm_fatal(get_full_name,"err at get in env");
	
	if(m_cfg.has_magent)
	begin	
		magth=m_agt_top::type_id::create("magth",this);
		foreach(m_cfg.mas_cfg[i])
		uvm_config_db#(master_agt_cfg)::set(this,"*","mas_agt_cfg",m_cfg.mas_cfg[i]);
	end

	if(m_cfg.has_sagent)
	begin
		sagth=s_agt_top::type_id::create("sagth",this);
		foreach(m_cfg.slv_cfg[i])
		uvm_config_db#(slave_agt_cfg)::set(this,"*","slv_agt_cfg",m_cfg.slv_cfg[i]);
	end

	if(m_cfg.has_virtual_sequencer)
		v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);
	
	if(m_cfg.has_scoreboard)
		sbh=spi_sb::type_id::create("spi_sb",this);
endfunction

function void connect_phase(uvm_phase phase);

endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction

endclass
*/