class m_xtn extends uvm_sequence_item;

	//Factory registration
	`uvm_object_utils(m_xtn)

	rand bit [4:0] addr;
	rand bit we;
	rand bit [31:0] din;

	bit [31:0] dout;
	bit[3:0] sel;
	bit strb;
	bit cyc;
	bit ack;
	bit intr;
	bit err;

	int Tx0,Tx1,Tx2,Tx3;   	//Transmission Register
	int Rx0,Rx1,Rx2,Rx3;   	//Receving Registers

	int ctrl; 		//CTRL Register
	int divider; 		//DIVIDER register
	int ss; 		//SLAVE SELECT Register

	function new(string name = "m_xtn");
		super.new(name);
	endfunction 

	function void do_print(uvm_printer printer);
		super.do_print(printer);
//			    string name 		bit stream value 		bits		radix for print
	printer.print_field("addr",			this.addr,			5,		UVM_HEX);
	printer.print_field("we",			this.we,			1,		UVM_HEX);
	printer.print_field("din",			this.din,			32,		UVM_HEX);
	printer.print_field("dout",			this.dout,			32,		UVM_HEX);
	printer.print_field("sel",			this.sel,			4,		UVM_HEX);
	printer.print_field("strb",			this.strb,			1,		UVM_HEX);
	printer.print_field("cyc",			this.cyc,			1,		UVM_HEX);
	printer.print_field("ack",			this.ack,			1,		UVM_HEX);
	printer.print_field("intr",			this.intr,			1,		UVM_HEX);
	printer.print_field("err",			this.err,			1,		UVM_HEX);
	printer.print_field("Tx0",			this.Tx0,			32,		UVM_HEX);
	printer.print_field("Tx1",			this.Tx1,			32,		UVM_HEX);
	printer.print_field("Tx2",			this.Tx2,			32,		UVM_HEX);
	printer.print_field("Tx3",			this.Tx3,			32,		UVM_HEX);
	printer.print_field("Rx0",			this.Rx0,			32,		UVM_HEX);
	printer.print_field("Rx1",			this.Rx1,			32,		UVM_HEX);
	printer.print_field("Rx2",			this.Rx2,			32,		UVM_HEX);
	printer.print_field("Rx3",			this.Rx3,			32,		UVM_HEX);
	printer.print_field("ctrl",			this.ctrl,			32,		UVM_DEC);
	printer.print_field("divider",		this.divider,			32,		UVM_HEX);
	printer.print_field("ss",			this.ss,			32,		UVM_HEX);
endfunction 

endclass
