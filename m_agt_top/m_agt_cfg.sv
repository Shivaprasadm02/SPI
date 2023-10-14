class master_agt_cfg extends uvm_object;

`uvm_object_utils(master_agt_cfg)

virtual spi_m_if vif;

uvm_active_passive_enum is_active=UVM_ACTIVE;

function new(string name="master_agt_cfg");
  super.new(name);
endfunction

endclass