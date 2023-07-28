module pc (
    input clk,
    input Pcsrc,
    input asyncreset,
    input load,
    input [31:0] extout,
    output reg [31:0] outpc);
always@(posedge clk or  negedge asyncreset)
begin
    if(!asyncreset)
    outpc<=0;
    else begin
        if(load) begin
            case (Pcsrc)
                1'b0:outpc<=outpc+3'b100;
                2'b1:outpc<=outpc+extout; 
                default: outpc<=outpc;
            endcase
        end
        else
            outpc<=outpc;
    end
end


endmodule //pc