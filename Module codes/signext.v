module signext (
    input [31:0] immext1,
    input [31:0] immext2,
    input [31:0] immext3,
    input [1:0] Immsrc,
    output reg [31:0] extout
);
reg [31:0] immext;
always@(*)begin 
     case (Immsrc)
        2'b00:immext=immext1;
        2'b01:immext=immext2;
        2'b10:immext=immext3; 
        default: immext=0;
    endcase
   extout=immext;
end
endmodule //signext