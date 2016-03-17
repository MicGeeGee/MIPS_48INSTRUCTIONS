module Compare(rs1,rs2,IF_ID_instr,Compare_o);
  input[31:0] rs1;
  input[31:0] rs2;
  input[31:0] IF_ID_instr;


  output Compare_o;
  
  reg Compare_reg;
  assign Compare_o=Compare_reg;
  initial
    Compare_reg=0;
  always@(rs1 or rs2 or IF_ID_instr)
    begin
      Compare_reg=0;
      case(IF_ID_instr[31:26])
        
        6'b000100:Compare_reg=(rs1==rs2);//beq
        6'b000101:Compare_reg=(rs1!=rs2);//bne
        6'b000110:Compare_reg=((rs1[31]==1)||(rs1==0));//blez
        6'b000111:Compare_reg=((rs1[31]==0)&&(rs1!=0));//bgtz
        6'b000001:Compare_reg=IF_ID_instr[20:16]?(rs1[31]==0):(rs1[31]==1);//bgez or bltz
        
      endcase
    end
  
    
  
endmodule
