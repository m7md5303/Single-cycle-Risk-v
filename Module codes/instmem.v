module instmem (
    input [31:0] A,
    output [31:0] instruction
);
   reg [31:0] instrmemry [0:63];
   assign instruction=instrmemry[A];
endmodule //instmem