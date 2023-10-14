class s_base_seq extends uvm_sequence#(s_xtn);
`uvm_object_utils(s_base_seq);

	function new(string name="s_base_seq");
		super.new(name);
	endfunction

endclass

class slv_seq1 extends s_base_seq;
`uvm_object_utils(slv_seq1);

function new(string name="slv_seq1");
	super.new(name);
endfunction

task body();		
	req=s_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {miso==128'h200;});
	//assert(req.randomize());
	finish_item(req);
endtask

endclass

class slv_seq2 extends s_base_seq;
`uvm_object_utils(slv_seq2);

function new(string name="slv_seq2");
	super.new(name);
endfunction

task body();		
	req=s_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {miso==128'd1456;});
	finish_item(req);
endtask

endclass

class slv_seq3 extends s_base_seq;
`uvm_object_utils(slv_seq3);

function new(string name="slv_seq3");
	super.new(name);
endfunction

task body();		
	req=s_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {miso==128'd10;});
	finish_item(req);
endtask

endclass