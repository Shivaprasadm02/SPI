class s_mon extends uvm_monitor;

	`uvm_component_utils(s_mon)
	uvm_analysis_port #(s_xtn) s_mon_port;
	
virtual spi_s_if.SMON_MP vif;
slave_agt_cfg s_agt_cfg;
s_xtn data;
  
int ctrl;
bit[6:0]char_len;
bit lsb;
bit drv_edge;
int i;

function new(string name="s_mon",uvm_component parent);
	super.new(name,parent);
s_mon_port = new("s_mon_port",this);
endfunction 

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(slave_agt_cfg)::get(this,"","slv_agt_cfg",s_agt_cfg))
		`uvm_fatal(get_type_name(),"Cannot get the s_agt_cfg into s_mon, Have you set it?")
	`uvm_info(get_type_name(),"This is build_phase in slave_monitor",UVM_LOW)
	if(!uvm_config_db #(int) :: get(this,"","int",ctrl))
		`uvm_fatal("ctrl_cfg","getting ctrl frm config failed")
	char_len=ctrl[6:0];
	drv_edge=ctrl[9];
	lsb=ctrl[11];
	data = s_xtn::type_id::create("data");
endfunction

function void connect_phase(uvm_phase phase);
    vif = s_agt_cfg.vif;
    super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);        
    forever
		begin
        collect_data();
		end
endtask
    
task collect_data;
//s_xtn data;
//data=s_xtn::type_id::create("data");
 //repeat(10)
    @(vif.spi_s_mon_cb);
        if (drv_edge) 
		begin
            if (char_len == 0) 
			begin
                if (lsb) 
				begin
                    for (i = 0; i <= 127; i++) 
					begin
                        @(negedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                    end
                end
                else 
				begin
                    for (i = 127; i>=0 ; i--)
					begin
                        @(negedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                    end
                end
            end
            else
			begin
                if (lsb) 
				begin
                    for (i = 0; i < char_len; i++) 
					begin
                        @(negedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                            $display("from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
                    end
                end
                else 
				begin
                    for (i = char_len-1; i >= 0; i--) 
					begin
                        @(negedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                            $display("AAAA from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
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
                        @(posedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                    end
                end
                else 
				begin
                    for (i = 127; i>=0 ; i--) 
					begin
                        @(posedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                    end
                end
            end
            else
			begin
                if (lsb) 
				begin
                    for (i = 0; i < char_len; i++) 
					begin
                        @(posedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                            $display("from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
                    end
                end
                else 
				begin
                    for (i = char_len-1; i >= 0; i--) 
					begin
                        @(posedge vif.spi_s_mon_cb.sclk_pad_o)
                            data.miso[i] = vif.spi_s_mon_cb.miso_pad_i;
                            data.mosi[i] = vif.spi_s_mon_cb.mosi_pad_o;
                    end
                end
            end
        end
        s_mon_port.write(data);
        //data.print();
        //$display("from s_mon t=%t", $time);
		`uvm_info("SLAVE_MONITOR",$sformatf("Printnig from Slave Monitor : \n %s",data.sprint()),UVM_LOW)
endtask

endclass