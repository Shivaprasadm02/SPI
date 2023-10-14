class spi_base_test extends uvm_test;
	`uvm_component_utils(spi_base_test)
	
	spi_env envh;
	//vbase_seq vseqh;
	spi_env_cfg m_cfg;
	master_agt_cfg mas_cfg[];
	slave_agt_cfg slv_cfg[];
	
	bit has_magent = 1;
	bit has_sagent = 1;
	bit has_virtual_sequencer = 1;
	bit has_scoreboard = 1;
	int no_of_magent = 1;
	int no_of_sagent = 1;
	
	function new(string name="spi_base_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	m_cfg=spi_env_cfg::type_id::create("m_cfg");
	if(has_magent)
		m_cfg.mas_cfg=new[no_of_magent];
	if(has_sagent)
		m_cfg.slv_cfg=new[no_of_sagent];
		
		spi_config();
		
		uvm_config_db#(spi_env_cfg)::set(this,"*","env_cfg",m_cfg);
		$display("env cfg set in test :%p",m_cfg);
		super.build_phase(phase);
		envh=spi_env::type_id::create("envh",this);
	endfunction
	
	function void spi_config();
		if(has_magent)
		begin
			mas_cfg=new[no_of_magent];
			foreach(mas_cfg[i])
			begin
				mas_cfg[i]=master_agt_cfg::type_id::create($sformatf("mas_cfg[%0d]",i),this);
				if(!uvm_config_db#(virtual spi_m_if)::get(this,"","min",mas_cfg[i].vif))
					`uvm_fatal(get_type_name,"unable to get in test mas_cfg")
				mas_cfg[i].is_active=UVM_ACTIVE;
				m_cfg.mas_cfg[i]=mas_cfg[i];
			end
		end
		if(has_sagent)
		begin
			slv_cfg=new[no_of_sagent];
			foreach(slv_cfg[i])
			begin
				slv_cfg[i]=slave_agt_cfg::type_id::create($sformatf("slv_cfg[%0d]",i),this);
				if(!uvm_config_db#(virtual spi_s_if)::get(this,"","sin",slv_cfg[i].vif))
					`uvm_fatal(get_type_name,"unable to get in test slv_cfg")
				slv_cfg[i].is_active=UVM_ACTIVE;
				m_cfg.slv_cfg[i]=slv_cfg[i];
			end
		end
		
	m_cfg.no_of_magent = no_of_magent;
	m_cfg.no_of_sagent = no_of_sagent;
	m_cfg.has_magent = has_magent;
	m_cfg.has_sagent = has_sagent;
	
	endfunction
	/*
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		vseqh = vbase_seq::type_id::create("vseqh");
		vseqh.start(envh.v_seqrh);
		#50;
		phase.drop_objection(this);
	endtask
	*/
endclass

//--------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------

class testcase1 extends spi_base_test;

	`uvm_component_utils(testcase1)

	mas_vseq1 vs1;
	int ctrl;

function new(string name = "testcase1",uvm_component parent);
	super.new(name,parent);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl[6:0] = 7'b0000000; //CHAR_LENGTH-128
	ctrl[7] = 1'b0;  	//Reserved bit
	ctrl[8] = 1'b1;  	//GO_BUSY 
	ctrl[9] = 1'b1;  	//RX_NEG 
	ctrl[10] = 1'b0;  	//TX_NEG 
	ctrl[11] = 1'b1;  	//LSB 
	ctrl[12] = 1'b1;  	//IE
	ctrl[13] = 1'b1; 	//ASS
	ctrl[31:14] = 18'b0;  	//Reserved

	//setting the ctrl register data into configuration data
	uvm_config_db #(int) :: set(this,"*","int",ctrl);	
	$display("ctrl set in test1 : %p",ctrl);
endfunction 

task run_phase(uvm_phase phase);
	//creating object for virtual sequence
	$display("run started in test-1");
	vs1 = mas_vseq1::type_id::create("vs1");	
	phase.raise_objection(this);
	//starting virtual sequence onto virtual sequencer
	$display("starting vs1 on vseqr in test-1");
	vs1.start(envh.v_seqrh);
	phase.drop_objection(this);
	$display("run ended in test-1");	
endtask

endclass

///------------------------------------------------------------///
///-----------------------testcase-2---------------------------///
///------------------------------------------------------------///

class testcase2 extends spi_base_test;

	`uvm_component_utils(testcase2)

	mas_vseq2 vs2;
	int ctrl;

function new(string name = "testcase2",uvm_component parent);
	super.new(name,parent);
endfunction  

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl[6:0] = 7'b1110101; //CHAR_LENGTH-20
	ctrl[7] = 1'b0;  	//Reserved bit
	ctrl[8] = 1'b1;  	//GO_BUSY 
	ctrl[9] = 1'b0;  	//RX_NEG 
	ctrl[10] = 1'b1;  	//TX_NEG 
	ctrl[11] = 1'b0;  	//LSB 
	ctrl[12] = 1'b1;  	//IE
	ctrl[13] = 1'b0; 	//ASS
	ctrl[31:14] = 18'b0;  	//Reserved

	//setting the ctrl register data into configuration data
	uvm_config_db #(int) :: set(this,"*","int",ctrl);	
	$display("ctrl set in test2 : %p",ctrl);
endfunction 

task run_phase(uvm_phase phase);
	//creating object for virtual sequence
	$display("run started in test-2");
	vs2 = mas_vseq2::type_id::create("vs2");	
	phase.raise_objection(this);
	//starting virtual sequence onto virtual sequencer
	$display("starting vs2 on vseqr in test-2");
	vs2.start(envh.v_seqrh);
	phase.drop_objection(this);
	$display("run ended in test-2");	
endtask

endclass

///------------------------------------------------------------///
///-----------------------testcase-3---------------------------///
///------------------------------------------------------------///

class testcase3 extends spi_base_test;

	`uvm_component_utils(testcase3)

	mas_vseq3 vs3;
	int ctrl;

function new(string name = "testcase3",uvm_component parent);
	super.new(name,parent);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ctrl[6:0] = 7'b1010111; //CHAR_LENGTH-40
	ctrl[7] = 1'b0;  	//Reserved bit
	ctrl[8] = 1'b1;  	//GO_BUSY 
	ctrl[9] = 1'b0;  	//RX_NEG 
	ctrl[10] = 1'b1;  	//TX_NEG 
	ctrl[11] = 1'b0;  	//LSB 
	ctrl[12] = 1'b1;  	//IE
	ctrl[13] = 1'b1; 	//ASS
	ctrl[31:14] = 18'b0;  	//Reserved

	//setting the ctrl register data into configuration data
	uvm_config_db #(int) :: set(this,"*","int",ctrl);	
	$display("ctrl set in test3 : %p",ctrl);
endfunction 

task run_phase(uvm_phase phase);
	//creating object for virtual sequence
	$display("run started in test-3");
	vs3 = mas_vseq3::type_id::create("vs3");	
	phase.raise_objection(this);
	//starting virtual sequence onto virtual sequencer
	$display("starting vs3 on vseqr in test-3");
	vs3.start(envh.v_seqrh);
	phase.drop_objection(this);
	$display("run ended in test-3");	
endtask

endclass



