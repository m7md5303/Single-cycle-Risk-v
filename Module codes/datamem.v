module datamem (
    input clk,
    input WE,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD
);
reg [31:0] datamemry [31:0];
always@(posedge clk)begin
    if(WE)begin
        datamemry[A]<=WD;
    end
end
assign RD=datamemry[A];
endmodule //datamem