class spi_env_cfg extends uvm_object;
`uvm_object_utils(spi_env_cfg)

bit has_virtual_sequencer=1;
bit has_magent=1;
bit has_sagent=1;
bit has_scoreboard=1;

master_agt_cfg mas_cfg[];
slave_agt_cfg slv_cfg[];

int no_of_magent=1;
int no_of_sagent=1;

function new(string name="spi_env_cfg");
	super.new(name);
endfunction

endclass

