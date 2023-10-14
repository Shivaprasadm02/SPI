class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item) ;
   
	`uvm_component_utils(virtual_sequencer)	

	m_seqr mseqrh[];
	s_seqr sseqrh[];
	spi_env_cfg m_cfg;

	function new(string name = "virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(spi_env_cfg)::get(this,"","env_cfg",m_cfg))
			`uvm_fatal(get_full_name,"get config error");
		mseqrh = new[m_cfg.no_of_magent];
		sseqrh = new[m_cfg.no_of_sagent];
		foreach(mseqrh[i])
			mseqrh[i]=m_seqr::type_id::create($sformatf("m_seqrh[%0d]",i),this);
		foreach(sseqrh[i])
			sseqrh[i]=s_seqr::type_id::create($sformatf("s_seqrh[%0d]",i),this);	
	endfunction
	
endclass



