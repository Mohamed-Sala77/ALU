class my_driver extends uvm_driver #(my_sequence_item);
    `uvm_component_utils(my_driver)

    my_sequence_item sequence_item;
    virtual intf1 intf;

    function new(string name ="my_driver" , uvm_component parent=null);
        super.new(name , parent);
    endfunction

    /*----------------------------------------------------------------------------*/
    /*  UVM Build Phases                                                          */
    /*----------------------------------------------------------------------------*/

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequence_item = my_sequence_item::type_id::create("sequence_item", this);

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
            seq_item_port.get_next_item(sequence_item);
            @(negedge intf.clk);
            $display("---------------------------------------------------------------");
            `uvm_info(get_full_name(), $sformatf(" TRANSACTION RECEIVED IN DRIVER IS %s", sequence_item.convert2string()), UVM_LOW)
            $display("---------------------------------------------------------------");
            intf.A <= sequence_item.A;
            intf.B <= sequence_item.B;
            intf.a_op <= sequence_item.a_op;
            intf.b_op <= sequence_item.b_op;
            intf.a_en <= sequence_item.a_en;
            intf.b_en <= sequence_item.b_en;
            intf.ALU_en <= sequence_item.ALU_en;
            intf.rst_n <= sequence_item.rst_n;

            seq_item_port.item_done();
        end
    endtask //run_phase
endclass