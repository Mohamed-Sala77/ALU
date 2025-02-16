class my_subscriber extends uvm_subscriber #(my_sequence_item);
    `uvm_component_utils(my_subscriber)

    my_sequence_item sequence_item;

    covergroup group_1;
        coverpoint sequence_item.ALU_en;
        coverpoint sequence_item.a_en;
        coverpoint sequence_item.b_en;
        coverpoint sequence_item.A ;
        coverpoint sequence_item.B ;
        coverpoint sequence_item.a_op { bins A_OP[] = {[0:8]}; } 
        coverpoint sequence_item.b_op { bins B_OP[] = {[0:4]}; }

        // Cross coverage
        cross sequence_item.ALU_en, sequence_item.a_en, sequence_item.b_en;
    endgroup

    function new(string name = "my_subscriber", uvm_component parent = null);
        super.new(name, parent);
       group_1 = new();
    endfunction

    /*----------------------------------------------------------------------------*/
    /*  UVM Build Phases                                                          */
    /*----------------------------------------------------------------------------*/

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequence_item = my_sequence_item::type_id::create("sequence_item", this);
    endfunction // build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction // connect_phase

    /*----------------------------------------------------------------------------*/
    /*  UVM Run Phases                                                            */
    /*----------------------------------------------------------------------------*/

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask // run_phase

    function void write(my_sequence_item t);
        sequence_item = t;

         $display("---------------------------------------------------------------");
         $display(" TRANSACTION RECEIVED IN Subscriber IS %p", sequence_item.convert2string());
         $display("---------------------------------------------------------------");

        group_1.sample();
    endfunction // write
endclass