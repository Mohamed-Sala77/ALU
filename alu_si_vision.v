module alu_si_vision (
    input wire clk,          // System Clock
    input wire rst_n,        // Active-low reset
    input wire ALU_en,       // System enable
    input wire a_en,         // A operations enable
    input wire b_en,         // B operations enable
    input wire signed [4:0] A,      // 5-bit signed input A (-15 to +15)
    input wire signed [4:0] B,      // 5-bit signed input B (-15 to +15)
    input wire [2:0] a_op,   // A operation select
    input wire [1:0] b_op,   // B operation select
    output reg signed [5:0] C       // 6-bit signed output (-31 to +31)
);
    reg [5:0] result;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            C <= 6'b0;
        end 
        else 
            C <= result;
    end

    always @(*) begin
        
        if (!ALU_en) begin
            result = 6'b0;
        end

        else 
            begin
        case ({a_en,b_en})
            2'b00 : begin
               result = 6'b0; 
            end

            2'b10 : begin
               case (a_op)
                     3'd0 : result = A+B;
                     3'd1 : result = A-B;
                     3'd2 : result = A^B;
                     3'd3 : result = A&B;
                     3'd4 : result = A&B;
                     3'd5 : result = A|B;
                     3'd6 : result = A~^B;
                default:  result = 6'b0;        // the null case
               endcase 
            end

            2'b01 : begin
                case (b_op)
                     2'd0 : result = ~(A&B);
                     2'd1 : result = A+B;
                     2'd2 :  result = A+B;
                default:  result = 6'b0;        // the null case
                endcase
                
            end

            2'b11 : begin
                case (b_op)
                2'd0 : result = A^B;
                2'd1 : result = A~^B;
                2'd2 :  result = A-1;
                2'd3 :  result = B+2;
           endcase
            end


          
        endcase
    end
end

    
endmodule