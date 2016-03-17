module EX_MEMPplReg(PCPlusBy4,ID_EX_Instr,Mult_Mux_o,ID_EX_rt_FMux_o,
              EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,EX_MEM_ID_EX_rt_FMux_o,
              CLK);

        input CLK;
        
        
        input[31:0] PCPlusBy4;
        input[31:0] ID_EX_Instr;
        input[31:0] Mult_Mux_o;
        input[31:0] ID_EX_rt_FMux_o;
        
        
        output[31:0] EX_MEM_PCPlusBy4;
        output[31:0] EX_MEM_Instr;
        output[31:0] EX_MEM_Mult_Mux_o;
        output[31:0] EX_MEM_ID_EX_rt_FMux_o;
        
        reg[31:0] Reg1;
        reg[31:0] Reg2;
        reg[31:0] Reg3;
        reg[31:0] Reg4;
        
        
        assign EX_MEM_PCPlusBy4=Reg1;
        assign EX_MEM_Instr=Reg2;
        assign EX_MEM_Mult_Mux_o=Reg3;      
        assign EX_MEM_ID_EX_rt_FMux_o=Reg4;
        
        
        
        initial
        begin
          Reg1<=0;
          Reg2<=0;
          Reg3<=0;
          Reg4<=0;
          
        
        end
        
        
        always@(posedge CLK)
          begin
            Reg1<=PCPlusBy4;
            Reg2<=ID_EX_Instr;
            Reg3<=Mult_Mux_o;
            Reg4<=ID_EX_rt_FMux_o;
      
          end
endmodule
        
