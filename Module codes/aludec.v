module aludec (
    input [2:0] funct3,
    input funct7,
    input [6:0] opcode,
    input zero_flag,
    input sign_flag,
    output [2:0] alucontrol,
    output reg Pcsrc,
    output reg RegWrite,
    output reg [1:0] Immsrc,
    output reg Alusrc,
    output reg MemWrite,
    output reg Resultsrc
);
reg [2:0] temp;
reg [1:0] fop75;
reg Branch;
reg [1:0] aluop;
always@(*)
begin
 fop75={{opcode[5]},{funct7}};
   case(aluop) 
        2'b00:begin temp=3'b000;Pcsrc=0; end
        2'b01:begin
           case (funct3)
            3'b000:begin
                temp=3'b010;
                Pcsrc=(zero_flag & Branch);
            end 
            3'b001:begin
                temp=3'b010;
                Pcsrc=(!zero_flag & Branch);
            end 
            3'b100:begin
                temp=3'b010;
                Pcsrc=(sign_flag & Branch);
            end 
            default:begin temp=0;Pcsrc=0;end 
           endcase
        end
        2'b10:begin
           case(funct3)
           3'b000:begin
            if(fop75==2'b11)
            begin
                temp=3'b010;Pcsrc=0;
            end
            else begin
                temp=3'b000;Pcsrc=0;
            end
           end
           default:begin temp=funct3;Pcsrc=0;end
           endcase
        end
        default:begin temp=0;Pcsrc=0; end
    endcase
end
assign alucontrol=temp;
always@(*)begin
case (opcode)
    7'b0000011:begin
        RegWrite=1'b1;
        Immsrc=0;
       
        Alusrc=1'b1;
        MemWrite=0;
        Resultsrc=1'b1;
        Branch=0;
        aluop=0;
    end 
    7'b0100011:begin
        RegWrite=0;
        Immsrc=2'b01;
       
        Alusrc=1'b1;
        MemWrite=1'b1;
        Branch=0;
        aluop=0;
        Resultsrc=1'bx;
    end
    7'b0110011:begin
        RegWrite=1'b1;
        Immsrc=2'bxx;
        Alusrc=0;
        MemWrite=0;
        Resultsrc=0;
        
        Branch=0;
        aluop=2'b10;
    end
    7'b0010011:begin
        RegWrite=1'b1;
        Immsrc=0;
        Alusrc=1'b1;
        MemWrite=0;
        Resultsrc=0;
        Branch=0;
        
        aluop=2'b10;
    end
    7'b1100011:begin
        RegWrite=0;
        Immsrc=2'b10;
        Alusrc=0;
        MemWrite=0;
        Branch=1'b1;
        aluop=2'b01;
        
        Resultsrc=1'bx;
    end
    default: begin
        begin
        RegWrite=0;
        Immsrc=0;
        Alusrc=0;
        MemWrite=0;
        Resultsrc=0;
        Branch=0;
        aluop=0;
        
    end
    end
endcase end
endmodule //aludec