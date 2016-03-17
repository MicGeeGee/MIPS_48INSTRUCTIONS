module EX_MEM_rt_FMux(EXE_MEM_rt,WBSrc_Mux_o,
    EX_MEM_rt_FUnit_o,
    EX_MEM_rt_FMux_o
    );
    
    input[31:0] EXE_MEM_rt;
    input[31:0] WBSrc_Mux_o;
    
    input EX_MEM_rt_FUnit_o;
    
    output[31:0] EX_MEM_rt_FMux_o;
    
    reg[31:0] Mux_reg;
    
    assign EX_MEM_rt_FMux_o=Mux_reg;
    initial
      Mux_reg<=0;
    always@(EXE_MEM_rt or WBSrc_Mux_o or EX_MEM_rt_FUnit_o)
      case(EX_MEM_rt_FUnit_o)
        0:Mux_reg<=EXE_MEM_rt;
        1:Mux_reg<=WBSrc_Mux_o;
      endcase
      
        
    
    
    
    
      
endmodule





