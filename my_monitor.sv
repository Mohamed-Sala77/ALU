class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    uvm_analysis_port#(my_sequence_item) m_put_port;
    my_sequence_item sequence_item;
    virtual intf1 intf;

    function new(string name ="my_monitor" , uvm_component parent=null);
        super.new(name , parent);
    endfunction

    /*----------------------------------------------------------------------------*/
    /*  UVM Build Phases                                                          */
    /*----------------------------------------------------------------------------*/

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequence_item = my_sequence_item::type_id::create("sequence_item", this);
        m_put_port = new("m_put_port", this);

        if (!uvm_config_db#(virtual intf1)::get(this, "", "my_inf", intf))
            `uvm_fatal(get_full_name(), "Error in getting interface")
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction //connect_phase

    /*----------------------------------------------------------------------------*/
    /*  UVM Run Phases                                                            */
    /*----------------------------------------------------------------------------*/

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Getting the input at negedge of the clk
            @(posedge intf.clk);
            sequence_item.rst_n <= intf.rst_n;
            sequence_item.A <= intf.A;
            sequence_item.B <= intf.B;
            sequence_item.a_op <= intf.a_op;
            sequence_item.b_op <= intf.b_op;
            sequence_item.a_en <= intf.a_en;
            sequence_item.b_en <= intf.b_en;
            sequence_item.ALU_en <= intf.ALU_en;

            // Getting the output at negedge of the clk
            sequence_item.C <= intf.C;

            $display("---------------------------------------------------------------");
            `uvm_info(get_full_name(), $sformatf(" TRANSACTION RECEIVED IN MONITOR IS %s", sequence_item.convert2string()), UVM_LOW)
            $display("---------------------------------------------------------------");

            m_put_port.write(sequence_item);
        end
    endtask //run_phase
endclass