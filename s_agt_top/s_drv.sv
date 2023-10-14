class s_drv extends uvm_driver#(s_xtn);

`uvm_component_utils(s_drv)
virtual spi_s_if.SDR_MP vif;
slave_agt_cfg s_agt_cfg;

int ctrl;
bit[6:0]char_len;
bit lsb;
bit drv_edge;
int i;

function new(string name="s_drv",uvm_component parent);
	super.new(name,parent);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(slave_agt_cfg)::get(this,"","slv_agt_cfg",s_agt_cfg))
		`uvm_fatal(get_type_name(),"Cannot get the s_agt_cfg into s_drv, Have you set it?")
	`uvm_info(get_type_name(),"This is build_phase in slave_dirver",UVM_LOW)
	if(!uvm_config_db #(int) :: get(this,"*","int",ctrl))
		`uvm_fatal("ctrl_cfg","getting ctrl frm config failed")
	$display("got ctrl frm test :%t",ctrl);
	char_len=ctrl[6:0];
	drv_edge=ctrl[9];
	lsb=ctrl[11];
endfunction

function void connect_phase(uvm_phase phase);
	vif = s_agt_cfg.vif;
endfunction : connect_phase

task run_phase(uvm_phase phase);	
	forever 
		begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask

task send_to_dut(s_xtn xtn);
	$display("run phase started in slv drv");
	if(ctrl[9])
		begin	
		  if (char_len == 0) 
			begin
                if (lsb) 
				begin
                    for (i = 0; i <= 127; i++)
					begin
                        @(posedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
                else 
				begin
                    for (i = 127; i>=0 ; i--) 
					begin
                        @(posedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
			end
          else 
			begin
                if (lsb)
				begin
                    for (i = 0; i < char_len; i++) 
					begin
                        @(posedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                            $display("from drv miso[%0d] = %b at %t",i,xtn.miso[i],$time);
                    end
                end
                else 
				begin
                    for (i = char_len-1; i >= 0; i--)
					begin
                        @(posedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
            end
		end
	else
		begin 
		if (char_len == 0) 
		begin
                if (lsb) 
				begin
                    for (i = 0; i<128; i++)
					begin
                        @(negedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
                else 
				begin
                    for (i = 127; i>=0 ; i--) 
					begin
                        @(negedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
            end
            else 
			begin
                if (lsb) 
				begin
                    for (i = 0; i < char_len; i++) 
					begin
                        @(negedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                            $display("from drv miso[%0d] = %b at %t",i,xtn.miso[i],$time);
                    end
                end
                else 
				begin
                    for (i = char_len-1; i >= 0; i--) 
					begin
                        @(negedge vif.spi_s_drv_cb.sclk_pad_o)
                            vif.spi_s_drv_cb.miso_pad_i <= xtn.miso[i];
                    end
                end
            end
		
		end
		`uvm_info("SLAVE_DRIVER",$sformatf("Printnig from Slave Driver : \n %s",xtn.sprint()),UVM_LOW)
endtask

endclass