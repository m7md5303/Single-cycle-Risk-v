module alu (
    input [31:0] first_operand,
    input [31:0] second_operand,
    input [2:0] oper_sel,
    output reg zero_flag,
    output reg sign_flag,
    output reg [31:0] alu_out
);
    always@(*)begin
        case (oper_sel)
            3'b000:alu_out=first_operand+second_operand;
            3'b001:alu_out=first_operand<<second_operand;
            3'b010:alu_out=first_operand-second_operand;
            3'b100:alu_out=first_operand^second_operand;
            3'b101:alu_out=first_operand>>second_operand;
            3'b110:alu_out=first_operand|second_operand; 
            3'b111:alu_out=first_operand&second_operand;
            default: alu_out=0;
        endcase
        sign_flag=alu_out[31];
        if(~(alu_out))
        begin
            zero_flag=1'b1;
        end
        else begin
            zero_flag=1'b0;
        end
    end
endmodule
