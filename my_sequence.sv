class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    my_sequence_item seq_item;

    function new(string name ="my_sequence");
        super.new(name);
    endfunction

    task pre_body;
        seq_item = my_sequence_item::type_id::create("seq_item");
    endtask

    task body;
        // reset the sequence item
        reset();

        for (int i = 0; i <500; i++) begin
            start_item(seq_item);
            seq_item.randomize();

            $display("---------------------------------------------------------------");
            `uvm_info("MY_SEQUENCE", $sformatf("TRANSACTION SENT TO DRIVER IS %s", seq_item.convert2string()), UVM_MEDIUM)
            $display("---------------------------------------------------------------");

          
            finish_item(seq_item);
        end
    endtask

    task reset();
        start_item(seq_item);
        seq_item.rst_n = 1'b1;
        finish_item(seq_item);
        #(1);
        // assert reset signal
        start_item(seq_item);
        seq_item.rst_n = 1'b0;
        finish_item(seq_item);
        #(1);
        // de-assert reset signal
        start_item(seq_item);
        seq_item.rst_n = 1'b1;
        finish_item(seq_item);
    endtask

endclass