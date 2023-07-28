module mux (
    input sel,
    input [31:0]in1,
    input [31:0]in2,
    output reg [31:0] outmux
);
always@(*)begin
    if(sel)
    outmux=in1;
    else outmux=in2;
end
endmodule //writedata