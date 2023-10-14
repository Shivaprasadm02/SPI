class vbase_seq extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(vbase_seq)
	
	m_seqr mseqrh[];
	s_seqr sseqrh[];
	
	virtual_sequencer vsqrh;
	
	spi_env_cfg m_cfg;
	
 	function new(string name = "vbase_seq");
		super.new(name);
	endfunction
	
	task body();
		if(!uvm_config_db #(spi_env_cfg) ::get(null,get_full_name(),"env_cfg",m_cfg))
			`uvm_fatal("VBASE CONFIG","unable to GET");

		mseqrh = new[m_cfg.no_of_magent];
		sseqrh = new[m_cfg.no_of_sagent];
 
		if(!($cast(vsqrh,m_sequencer)))
			`uvm_error("BODY", "Error in $cast of virtual sequencer")
		foreach(mseqrh[i])  
			mseqrh[i] = vsqrh.mseqrh[i];
		foreach(sseqrh[i])
			sseqrh[i] = vsqrh.sseqrh[i];
	endtask

endclass 

//-------------sequence-1 ////----------

class mas_vseq1 extends vbase_seq;

`uvm_object_utils(mas_vseq1)
mas_seq1 mseq1;
slv_seq1 sseq1;
mas_rdseq1 rdseq1;

	function new(string name = "mas_vseq1");
		super.new(name);
	endfunction

	task body();
		super.body;
		mseq1 = mas_seq1 :: type_id :: create("mseq1");
		sseq1 = slv_seq1 :: type_id :: create("sseq1");
		rdseq1 = mas_rdseq1 :: type_id :: create("rdseq1");
fork
		if(m_cfg.has_magent)
		begin
		foreach(mseqrh[i])  
			begin
			mseq1.start(mseqrh[i]);	
				$display("mseq1 started on mseqrh");		
			end				
		end
		
		if(m_cfg.has_sagent)
		begin
		foreach(sseqrh[i])  
			begin
			sseq1.start(sseqrh[i]);
			$display("sseq1 started on sseqrh");
			end
		end
join
foreach(mseqrh[i])  
	begin
			rdseq1.start(mseqrh[i]);
			$display("rdseq1 started on mseqrh");
		end
/*
	fork		
			seq1.start(mseqrh[0]);	
				//$display("seq1 started on mseqrh");		
		
			seq5.start(sseqrh[0]);
			//$display("seq5 started on sseqrh");
	join
			rdseq1.start(mseqrh[0]);
			//$display("rdseq1 started on mseqrh");
*/		

endtask
 
endclass 

//------sequence-2////-------//

class mas_vseq2 extends vbase_seq;

`uvm_object_utils(mas_vseq2)
mas_seq2 mseq2;
slv_seq2 sseq2;

	function new(string name = "mas_vseq2");
		super.new(name);
	endfunction

	task body();
		super.body;
		mseq2 = mas_seq2 :: type_id :: create("mseq2");
		sseq2 = slv_seq2 :: type_id :: create("sseq2");
	fork	
		if(m_cfg.has_magent)
		begin
			for(int i=0;i<m_cfg.no_of_magent;i++)
			begin
				mseq2.start(mseqrh[i]);
			end	
		end
		if(m_cfg.has_sagent)
		begin
			for(int i=0;i<m_cfg.no_of_sagent;i++)
			begin
				sseq2.start(sseqrh[i]);
			end	
		end
	join
	endtask
 
endclass 

//------sequence-3////-------//

class mas_vseq3 extends vbase_seq;

`uvm_object_utils(mas_vseq3)
mas_seq3 mseq3;
slv_seq3 sseq3;

	function new(string name = "mas_vseq3");
		super.new(name);
	endfunction

	task body();
		super.body;
		mseq3 = mas_seq3 :: type_id :: create("mseq3");
		sseq3 = slv_seq3 :: type_id :: create("sseq3");
	fork
		if(m_cfg.has_magent)
		begin
			for(int i=0;i<m_cfg.no_of_magent;i++)
			begin
				mseq3.start(mseqrh[i]);
			end
		end
		if(m_cfg.has_sagent)
		begin
			for(int i=0;i<m_cfg.no_of_sagent;i++)
			begin
				sseq3.start(sseqrh[i]);
			end
		end
	join
	endtask
 
endclass

//------sequence-4////-------//

class mas_vseq4 extends vbase_seq;

`uvm_object_utils(mas_vseq4)
mas_seq4 seq4;

	function new(string name = "mas_vseq4");
		super.new(name);
	endfunction

	task body();
		super.body;
		seq4 = mas_seq4 :: type_id :: create("seq4");
		if(m_cfg.has_magent)
		begin
			for(int i=0;i<m_cfg.no_of_magent;i++)
			begin
				seq4.start(mseqrh[i]);
			end
		end
	endtask
 
endclass

//------sequence-5////-------//

class slv_vseq5 extends vbase_seq;

`uvm_object_utils(slv_vseq5)
slv_seq1 seq8;

	function new(string name = "slv_vseq5");
		super.new(name);
	endfunction

	task body();
		super.body;
		seq8 = slv_seq1 :: type_id :: create("seq8");
		if(m_cfg.has_sagent)
		begin
			for(int i=0;i<m_cfg.no_of_sagent;i++)
			begin
				seq8.start(sseqrh[i]);
			end
		end
	endtask
 
endclass

//------sequence-6////-------//

class slv_vseq6 extends vbase_seq;

`uvm_object_utils(slv_vseq6)
slv_seq2 seq6;

	function new(string name = "slv_vseq6");
		super.new(name);
	endfunction

	task body();
		super.body;
		seq6 = slv_seq2 :: type_id :: create("seq6");
		if(m_cfg.has_sagent)
		begin
			for(int i=0;i<m_cfg.no_of_sagent;i++)
			begin
				seq6.start(sseqrh[i]);
			end
		end
	endtask
 
endclass

//------sequence-7////-------//

class slv_vseq7 extends vbase_seq;

`uvm_object_utils(slv_vseq7)
slv_seq3 seq7;

	function new(string name = "slv_vseq7");
		super.new(name);
	endfunction

	task body();
		super.body;
		seq7 = slv_seq3 :: type_id :: create("seq7");
		if(m_cfg.has_sagent)
		begin
			for(int i=0;i<m_cfg.no_of_sagent;i++)
			begin
				seq7.start(sseqrh[i]);
			end
		end
	endtask
 
endclass



