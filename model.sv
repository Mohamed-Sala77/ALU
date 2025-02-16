//------------------------------------------------------------------------------
//-- Building reference model with mailboxes 
//------------------------------------------------------------------------------

class model;

my_sequence_item seq_item;
my_sequence_item expected_seq_item;
mailbox #(my_sequence_item) seq_mbx;
mailbox #(my_sequence_item) exp_mbx;


// Constructor
function new(mailbox #(my_sequence_item) seq_mbx, mailbox #(my_sequence_item) exp_mbx);
    this.seq_mbx = seq_mbx;
    this.exp_mbx = exp_mbx;
    seq_item = new();
    expected_seq_item = new();
    endfunction //new()

    task modeling();
        
        seq_mbx.get(seq_item);

        $display("---------------------------------------------------------------");
        `uvm_info("MODEL", $sformatf(" TRANSACTION RECEIVED IN Model IS %p", seq_item.convert2string()), UVM_LOW)
        $display("---------------------------------------------------------------");


        if (seq_item.rst_n == 1'b0) begin
            expected_seq_item.C = 6'b0;
        end
        else if (seq_item.ALU_en == 1'b0) begin
            expected_seq_item.C = 6'b0;
        end
         else begin
            case ({seq_item.a_en, seq_item.b_en})
                2'b00: begin
                    expected_seq_item.C = 6'b0;
                end
                2'b10: begin
                    case (seq_item.a_op)
                        3'd0: expected_seq_item.C = seq_item.A + seq_item.B;
                        3'd1: expected_seq_item.C = seq_item.A - seq_item.B;
                        3'd2: expected_seq_item.C = seq_item.A ^ seq_item.B;
                        3'd3: expected_seq_item.C = seq_item.A & seq_item.B;
                        3'd4: expected_seq_item.C = seq_item.A & seq_item.B;
                        3'd5: expected_seq_item.C = seq_item.A | seq_item.B;
                        3'd6: expected_seq_item.C = seq_item.A ~^ seq_item.B;
                        default: expected_seq_item.C = 6'b0;
                    endcase
                end
                2'b01: begin
                    case (seq_item.b_op)
                        2'd0: expected_seq_item.C = ~(seq_item.A & seq_item.B);
                        2'd1: expected_seq_item.C = seq_item.A + seq_item.B;
                        2'd2: expected_seq_item.C = seq_item.A + seq_item.B;
                        default: expected_seq_item.C = 6'b0;
                    endcase
                end
                2'b11: begin
                    case (seq_item.b_op)
                        2'd0: expected_seq_item.C = seq_item.A ^ seq_item.B;
                        2'd1: expected_seq_item.C = seq_item.A ~^ seq_item.B;
                        2'd2: expected_seq_item.C = seq_item.A - 1;
                        2'd3: expected_seq_item.C = seq_item.B+2;
                        default: expected_seq_item.C = 6'b0;
                    endcase
                end
            endcase
        end

        exp_mbx.put(expected_seq_item);
        expected_seq_item = new();
        
    endtask
endclass //model