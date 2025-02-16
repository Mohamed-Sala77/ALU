class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)

    // Declare variables to store the sequence item and counts
    my_sequence_item sequence_item;
    my_sequence_item expected_item;
    mailbox #(my_sequence_item) m_mbx;
    mailbox #(my_sequence_item) exp_mbx;
    model ref_model;
    int correct_count;
    int error_count;
    event run;


    uvm_analysis_imp#(my_sequence_item, my_scoreboard) m_put_imp;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        m_mbx = new();
        exp_mbx = new();
        ref_model = new(m_mbx, exp_mbx);
        correct_count = 0;
        error_count = 0;
    endfunction

    // UVM Build Phases
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequence_item = my_sequence_item::type_id::create("sequence_item", this);
        expected_item = my_sequence_item::type_id::create("expected_item", this);
        m_put_imp = new("m_put_imp", this);
    endfunction

    /*---  UVM Run Phases ---*/
    /*----------------------------------------------------------------------------*/
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @(run);
            m_mbx.put(sequence_item);
            ref_model.modeling();
            exp_mbx.get(expected_item);
            compare(sequence_item, expected_item);
            
        end
    endtask // run_phase

    function void write(my_sequence_item t);
        sequence_item = t;
        ->run;
    endfunction // write

    // report phase will be executed after all run_phase is completed
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase",$sformatf("Total successful transactions: %0d", correct_count), UVM_MEDIUM);
        `uvm_info("report_phase",$sformatf("Total failed transactions: %0d", error_count), UVM_MEDIUM);
    endfunction // report_phase

////____________________________Coparison 
task compare(input my_sequence_item sequence_item, input my_sequence_item expected_item);
    // Compare actual and expected results using assertions
    Output_check : assert(sequence_item.C == expected_item.C) else begin
        error_count++;
        `uvm_error("MISMATCH COMPARE",$sformatf("Mismatch: Actual C=%0d, expected C=%0d",
                                        sequence_item.C, expected_item.C));
    end
    if (sequence_item.C == expected_item.C) begin
        `uvm_info("MATCHED COMPARE",$sformatf("Value of C = %0d",sequence_item.C), UVM_MEDIUM);
        correct_count++;
    end
endtask

endclass