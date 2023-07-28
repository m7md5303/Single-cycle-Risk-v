module regfile (
    input clk,
    input reg_reset,
    input [4:0]A1,
    input [4:0]A2,
    input [4:0]A3,
    input WE3,
    input [31:0] WD3,
    output [31:0]RD1,
    output [31:0] RD2
);
reg [31:0] regfilemem [31:0];
integer i;
always@(posedge clk or negedge reg_reset)begin
    if(!reg_reset)begin
        for(i=0;i<32;i=i+1)begin
           regfilemem[i]<=0;
    end
end
else if((WE3)&&(reg_reset))begin
    regfilemem[A3]<=WD3;
end
end
assign RD1=regfilemem[A1];
assign RD2=regfilemem[A2];
endmodule //regfile