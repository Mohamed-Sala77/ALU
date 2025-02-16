module my_top;
    import uvm_pkg::*;
    `include "pack1.sv";

    bit clk;
    logic rst;

    parameter clk_period   = 10;

    // Instantiate the interface
    intf1 intf (clk);

    // Instantiate the DUT with the interface modport
    alu_si_vision dut (
        .clk(intf.clk),
        .rst_n(intf.rst_n),
        .ALU_en(intf.ALU_en),
        .a_en(intf.a_en),
        .b_en(intf.b_en),
        .A(intf.A),
        .B(intf.B),
        .a_op(intf.a_op),
        .b_op(intf.b_op),
        .C(intf.C)
    );

    initial begin
        uvm_config_db#(virtual intf1)::set(null, "uvm_test_top", "my_inf", intf);
        run_test("my_test");
    end

    always #(clk_period/2) clk = ~clk;

endmodule