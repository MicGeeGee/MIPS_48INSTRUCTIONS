module ID_EXPplReg(PCPlusBy4,StallMux_o,Shamt_Mux_o,IF_ID_rt_FMux_o,SignEXUnit_o,
      ID_EX_PCPlusBy4,ID_EX_Instr,ID_EX_rs,ID_EX_rt,ID_EX_SignEX_o,Stall_en,
      CLK);

      input CLK;
      input Stall_en;
     
      input[31:0] PCPlusBy4;
      input[31:0] StallMux_o;
      input[31:0] Shamt_Mux_o;
      input[31:0] IF_ID_rt_FMux_o;
      input[31:0] SignEXUnit_o;
      
     
      
      output[31:0] ID_EX_PCPlusBy4;
      output[31:0] ID_EX_Instr;
      output[31:0] ID_EX_rs;
      output[31:0] ID_EX_rt;
      output[31:0] ID_EX_SignEX_o;      

      
      reg[31:0] Reg1;
      reg[31:0] Reg2;
      reg[31:0] Reg3;
      reg[31:0] Reg4;
      reg[31:0] Reg5;
      
    
     
      assign ID_EX_PCPlusBy4=Reg1;
      assign ID_EX_Instr=Reg2;
      assign ID_EX_rs=Reg3;      
      assign ID_EX_rt=Reg4;
      assign ID_EX_SignEX_o=Reg5;
      
      
      initial
        begin
          Reg1<=0;
          Reg2<=0;
          Reg3<=0;
          Reg4<=0;
          Reg5<=0;
        end
  
      
      
      always@(posedge CLK)
        begin
          Reg1<=PCPlusBy4;
          Reg2<=StallMux_o;
          Reg3<=Stall_en?0:Shamt_Mux_o;//sll-- all 0   beq
          Reg4<=Stall_en?0:IF_ID_rt_FMux_o;//
          Reg5<=Stall_en?0:SignEXUnit_o;//
          
        end
endmodule
      
      
      
      
      