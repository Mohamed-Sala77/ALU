class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(my_sequence_item)
    
    function new(string name = "my_sequence_item");
        super.new(name);
    endfunction

    rand bit  ALU_en;
    rand bit  a_en;
    rand bit  b_en;
    rand bit signed [4:0] A;
    rand bit signed [4:0] B;
    rand bit  [2:0] a_op;
    rand bit  [1:0] b_op;
    bit rst_n;
    logic signed [5:0] C;

    virtual function string convert2string();
        return $sformatf("\nTransaction:\t rst_n =%0b \tALU_en = %0b   ,\ta_en = %0b   ,\tb_en = %0b   ,\tA = %0d   ,\tB = %0d   ,\ta_op = %0d   ,\tb_op = %0d   ,\tC = %0d\n", 
            rst_n,ALU_en, a_en, b_en, A, B, a_op, b_op, C);
    endfunction
endclass