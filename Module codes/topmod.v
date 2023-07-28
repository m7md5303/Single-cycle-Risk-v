module topmod (input inclk0,
input pcasyncreset,
input pcload,
output tx_serial);
wire Pcsrc;
wire [31:0] extout;
wire [31:0] outpc;
wire [31:0] instruction;
wire zero_flag;
wire sign_flag;
wire [2:0] alucontrol;
wire RegWrite;
wire Alusrc;
wire MemWrite;
wire Resultsrc;
wire [1:0] aluop;
wire [1:0] Immsrc;
wire clku;
wire outu;
wire clk;
wire [31:0] RD;


pc pcm(
    .clk(clk),
    .asyncreset(pcasyncreset),
    .load(pcload),
    .Pcsrc(Pcsrc),
    .extout(extout),
    .outpc(outpc)
);
instmem instmemm(
    .A(outpc),
    .instruction(instruction)
);
aludec aludecm(
    .opcode(instruction[6:0]),
    .funct3(instruction[14:12]),
    .funct7(instruction[30]),
    .Pcsrc(Pcsrc),
    .Resultsrc(Resultsrc),
    .MemWrite(MemWrite),
    .alucontrol(alucontrol),
    .Alusrc(Alusrc),
    .Immsrc(Immsrc),
    .RegWrite(RegWrite),
    .zero_flag(zero_flag),
    .sign_flag(sign_flag)
);
wire reg_reset;
wire [31:0] WD3;
wire [31:0] RD1;
wire [31:0] RD2;
regfile regfilem(
    .clk(clk),
    .WE3(RegWrite),
    .A1(instruction[19:15]),
    .A2(instruction[24:20]),
    .A3(instruction[11:7]),
    .WD3(WD3),
    .RD1(RD1),
    .RD2(RD2),
    .reg_reset(pcasyncreset)
);
wire [31:0]aluin2;
wire [31:0] immext1;
assign immext1={{20{instruction[31]}},{instruction[31:20]}};
wire [31:0] immext2;
assign immext2={{20{instruction[31]}},{instruction[31:25]},{instruction[11:7]}};
wire [31:0] immext3;
assign immext3={{20{instruction[31]}},{instruction[7]},{instruction[30:25]},{instruction[11:8]},{1'b0}};
signext signextm(
    .immext1(immext1),
    .immext2(immext2),
    .immext3(immext3),
    .Immsrc(Immsrc),
    .extout(extout)
);
mux mux1(
.in1(extout),
.in2(RD2),
.sel(Alusrc),
.outmux(aluin2)
);
wire [31:0] aluresult;
alu alum(
    .first_operand(RD1),
    .second_operand(aluin2),
    .oper_sel(alucontrol),
    .zero_flag(zero_flag),
    .sign_flag(sign_flag),
    .alu_out(aluresult)
);

datamem datamemm(
    .clk(clk),
    .WE(MemWrite),
    .A(aluresult),
    .WD(RD2),
    .RD(RD)
);
mux mux2(
    .in1(RD),
    .in2(aluresult),
    .sel(Resultsrc),
    .outmux(WD3)
);
endmodule //topmod