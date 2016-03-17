module MEM_WBPplReg(EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,dataMem_o,
        MEM_WB_PCPlusBy4,MEM_WB_Instr,MEM_WB_Mult_Mux_o,MEM_WB_dataMem_o,
        CLK);

        input CLK;
        

        input[31:0] EX_MEM_PCPlusBy4;
        input[31:0] EX_MEM_Instr;
        input[31:0] EX_MEM_Mult_Mux_o;
        input[31:0] dataMem_o;

        output[31:0] MEM_WB_PCPlusBy4;
        output[31:0] MEM_WB_Instr;
        output[31:0] MEM_WB_Mult_Mux_o;
        output[31:0] MEM_WB_dataMem_o;

        
        reg[31:0] Reg1;
        reg[31:0] Reg2;
        reg[31:0] Reg3;
        reg[31:0] Reg4;

        
        assign MEM_WB_PCPlusBy4=Reg1;
        assign MEM_WB_Instr=Reg2;
        assign MEM_WB_Mult_Mux_o=Reg3;
        assign MEM_WB_dataMem_o=Reg4;

        
        initial
          begin
            Reg1<=0;
            Reg2<=0;
            Reg3<=0;
            Reg4<=0;

          end 
        
        always@(posedge CLK)
          begin
            Reg1<=EX_MEM_PCPlusBy4;
            Reg2<=EX_MEM_Instr;
            Reg3<=EX_MEM_Mult_Mux_o;
            Reg4<=dataMem_o;

          end
endmodule
  