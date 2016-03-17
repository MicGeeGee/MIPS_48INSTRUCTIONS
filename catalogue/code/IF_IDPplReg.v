module IF_IDPplReg(PCPlusBy4,InstrMem_o,IF_IDWrite_en,Flush_en,
          IF_ID_PCPlusBy4,IF_ID_Instr,CLK);
  input[31:0] PCPlusBy4;
  input[31:0] InstrMem_o;

  input CLK;
  input IF_IDWrite_en;
  input Flush_en;
  
  output[31:0] IF_ID_PCPlusBy4;
  output[31:0] IF_ID_Instr;

  
  reg[31:0]  Reg1;
  reg[31:0]  Reg2;
  
 
  assign IF_ID_PCPlusBy4=Reg1;
  assign IF_ID_Instr=Reg2;

  
  initial
    begin
      Reg1<=0;
      Reg2<=0;
    end
  
  
  always@(posedge CLK)
    begin
      if(IF_IDWrite_en)
        begin
          Reg1<=PCPlusBy4;
          Reg2<=InstrMem_o;

        end
      if(Flush_en)
        Reg2<=0;
    end
    
endmodule
  
  
