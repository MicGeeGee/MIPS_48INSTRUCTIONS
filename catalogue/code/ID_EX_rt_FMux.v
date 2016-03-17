module ID_EX_rt_FMux(ID_EX_rt,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    ID_EX_rt_FUnit_o,
    ID_EX_rt_FMux_o
    );
    
    input[31:0] ID_EX_rt;
    input[31:0] EX_MEM_Mult_Mux_o;
    input[31:0] EX_MEM_PCPlusBy4;
    input[31:0] WBSrc_Mux_o;
    
    input[1:0] ID_EX_rt_FUnit_o;
    
    output[31:0] ID_EX_rt_FMux_o;
    
    reg[31:0] Mux_reg;
    
    assign ID_EX_rt_FMux_o=Mux_reg;
    initial
      Mux_reg<=0;
    always@(ID_EX_rt or EX_MEM_Mult_Mux_o or EX_MEM_PCPlusBy4 or WBSrc_Mux_o or ID_EX_rt_FUnit_o)
      case(ID_EX_rt_FUnit_o)
        0:Mux_reg<=ID_EX_rt;
        1:Mux_reg<=EX_MEM_Mult_Mux_o;
        2:Mux_reg<=EX_MEM_PCPlusBy4;
        3:Mux_reg<=WBSrc_Mux_o;
      endcase
      
        
    
    
    
    
      
endmodule





