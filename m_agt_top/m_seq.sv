class m_base_seq extends uvm_sequence#(m_xtn);
`uvm_object_utils(m_base_seq);

int ctrl1;

function new(string name="m_base_seq");
	super.new(name);
endfunction

endclass

class mas_seq1 extends m_base_seq;
`uvm_object_utils(mas_seq1);

function new(string name="mas_seq1");
	super.new(name);
endfunction

task body();

if(!uvm_config_db#(int)::get(null,get_full_name(),"int",ctrl1))
		`uvm_fatal(get_type_name(),"Cannot get data into ctrl inside sequence.Have you set it?")
		
	req=m_xtn::type_id::create("req");
	
	//Tx0
	start_item(req);
	assert(req.randomize() with {addr==5'h0;we==1'b1;din==32'h0000_0001;});
	finish_item(req);
	$display("tx0 done");
	//Tx1
	start_item(req);
	assert(req.randomize() with {addr==5'h4;we==1'b1;din==32'h0000_0010;});
	finish_item(req);
	
	$display("tx1 done");
	//Tx2
	start_item(req);
	assert(req.randomize() with {addr==5'h8;we==1'b1;din==32'h0000_0100;});
	finish_item(req);
	
	$display("tx2 done");
	//Tx3
	start_item(req);
	assert(req.randomize() with {addr==5'hc;we==1'b1;din==32'h0000_1000;});
	finish_item(req);
	
	$display("tx3 done");
	//ctrl
	start_item(req);
	assert(req.randomize() with {addr == 5'h10; we == 1'b1;din == ctrl1;});
	finish_item(req);

	$display("ctrl done");
	//divider 
	start_item(req);
	assert(req.randomize() with {addr == 5'h14; we == 1'b1; din[31:16] == 16'h0; din[15:0] == 16'h16;});
	finish_item(req);
	$display("divider done");
	//ss
	start_item(req);
	assert(req.randomize() with {addr == 5'h18; we == 1'b1; din[31:8] == 24'h0; din[7:0] == 8'h32;});
	finish_item(req);
	$display("ss done");
endtask

endclass

class mas_rdseq1 extends m_base_seq;
`uvm_object_utils(mas_rdseq1);

function new(string name="mas_rdseq1");
	super.new(name);
endfunction

  task body();
        super.body();
       req=m_xtn::type_id::create("req");
	   /*
        foreach (req.Rx[i])
		begin 
            start_item(req);
            assert(req.randomize with {addr == ('h4*i);
                                       we == 0;});
            finish_item(req);
        end
		*/
	//Rx0
	start_item(req);
	assert(req.randomize() with {addr==5'h0;we==1'b0;});
	finish_item(req);
	
	//Rx1
	start_item(req);
	assert(req.randomize() with {addr==5'h4;we==1'b0;});
	finish_item(req);
	
	//Rx2
	start_item(req);
	assert(req.randomize() with {addr==5'h8;we==1'b0;});
	finish_item(req);
	
	//Rx3
	start_item(req);
	assert(req.randomize() with {addr==5'hc;we==1'b0;});
	finish_item(req);
	endtask
endclass

class mas_seq2 extends m_base_seq;
`uvm_object_utils(mas_seq2);

function new(string name="mas_seq2");
	super.new(name);
endfunction


task body();

if(!uvm_config_db#(int)::get(null,get_full_name(),"int",ctrl1))
		`uvm_fatal(get_type_name(),"Cannot get data into ctrl inside sequence.Have you set it?")
		
	req=m_xtn::type_id::create("req");
	
	//Tx0
	start_item(req);
	assert(req.randomize() with {addr==5'h0;we==1'b1;din==32'h0000_0001;});
	finish_item(req);
	$display("tx0 done");
	//Tx1
	start_item(req);
	assert(req.randomize() with {addr==5'h4;we==1'b1;din==32'h0000_0010;});
	finish_item(req);
	
	$display("tx1 done");
	//Tx2
	start_item(req);
	assert(req.randomize() with {addr==5'h8;we==1'b1;din==32'h0000_0100;});
	finish_item(req);
	
	$display("tx2 done");
	//Tx3
	start_item(req);
	assert(req.randomize() with {addr==5'hc;we==1'b1;din==32'h0000_1000;});
	finish_item(req);
	
	$display("tx3 done");
	//ctrl
	start_item(req);
	assert(req.randomize() with {addr == 5'h10; we == 1'b1;din == ctrl1;});
	finish_item(req);

	$display("ctrl done");
	//divider 
	start_item(req);
	assert(req.randomize() with {addr == 5'h14; we == 1'b1; din[31:16] == 16'h0; din[15:0] == 16'h16;});
	finish_item(req);
	$display("divider done");
	//ss
	start_item(req);
	assert(req.randomize() with {addr == 5'h18; we == 1'b1; din[31:8] == 24'h0; din[7:0] == 8'h32;});
	finish_item(req);
	$display("ss done");
endtask
endclass

class mas_seq3 extends m_base_seq;
`uvm_object_utils(mas_seq3);

function new(string name="mas_seq3");
	super.new(name);
endfunction


task body();

if(!uvm_config_db#(int)::get(null,get_full_name(),"int",ctrl1))
		`uvm_fatal(get_type_name(),"Cannot get data into ctrl inside sequence.Have you set it?")
		
	req=m_xtn::type_id::create("req");
	
	//Tx0
	start_item(req);
	assert(req.randomize() with {addr==5'h0;we==1'b1;din==32'h0000_0001;});
	finish_item(req);
	$display("tx0 done");
	//Tx1
	start_item(req);
	assert(req.randomize() with {addr==5'h4;we==1'b1;din==32'h0000_0010;});
	finish_item(req);
	
	$display("tx1 done");
	//Tx2
	start_item(req);
	assert(req.randomize() with {addr==5'h8;we==1'b1;din==32'h0000_0100;});
	finish_item(req);
	
	$display("tx2 done");
	//Tx3
	start_item(req);
	assert(req.randomize() with {addr==5'hc;we==1'b1;din==32'h0000_1000;});
	finish_item(req);
	
	$display("tx3 done");
	//ctrl
	start_item(req);
	assert(req.randomize() with {addr == 5'h10; we == 1'b1;din == ctrl1;});
	finish_item(req);

	$display("ctrl done");
	//divider 
	start_item(req);
	assert(req.randomize() with {addr == 5'h14; we == 1'b1; din[31:16] == 16'h0; din[15:0] == 16'h16;});
	finish_item(req);
	$display("divider done");
	//ss
	start_item(req);
	assert(req.randomize() with {addr == 5'h18; we == 1'b1; din[31:8] == 24'h0; din[7:0] == 8'h32;});
	finish_item(req);
	$display("ss done");
endtask

endclass

class mas_seq4 extends m_base_seq;
`uvm_object_utils(mas_seq4);

function new(string name="mas_seq4");
	super.new(name);
endfunction


task body();

if(!uvm_config_db#(int)::get(null,get_full_name(),"int",ctrl1))
		`uvm_fatal(get_type_name(),"Cannot get data into ctrl inside sequence.Have you set it?")
		
	req=m_xtn::type_id::create("req");
	
	//Tx0
	start_item(req);
	assert(req.randomize() with {addr==5'h0;we==1'b1;din==32'h0000_0001;});
	finish_item(req);
	$display("tx0 done");
	//Tx1
	start_item(req);
	assert(req.randomize() with {addr==5'h4;we==1'b1;din==32'h0000_0010;});
	finish_item(req);
	
	$display("tx1 done");
	//Tx2
	start_item(req);
	assert(req.randomize() with {addr==5'h8;we==1'b1;din==32'h0000_0100;});
	finish_item(req);
	
	$display("tx2 done");
	//Tx3
	start_item(req);
	assert(req.randomize() with {addr==5'hc;we==1'b1;din==32'h0000_1000;});
	finish_item(req);
	
	$display("tx3 done");
	//ctrl
	start_item(req);
	assert(req.randomize() with {addr == 5'h10; we == 1'b1;din == ctrl1;});
	finish_item(req);

	$display("ctrl done");
	//divider 
	start_item(req);
	assert(req.randomize() with {addr == 5'h14; we == 1'b1; din[31:16] == 16'h0; din[15:0] == 16'h16;});
	finish_item(req);
	$display("divider done");
	//ss
	start_item(req);
	assert(req.randomize() with {addr == 5'h18; we == 1'b1; din[31:8] == 24'h0; din[7:0] == 8'h32;});
	finish_item(req);
	$display("ss done");
endtask

endclass

class mas_seq5 extends m_base_seq;
endclass
