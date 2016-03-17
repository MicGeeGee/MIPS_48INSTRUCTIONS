module IF_ID_rs_FMux(RegFile_o_1,ID_EX_PCPlusBy4,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    IF_ID_rs_FUnit_o,
    IF_ID_rs_FMux_o
    );
    

    input[31:0] RegFile_o_1;
    input[31:0] ID_EX_PCPlusBy4;
    input[31:0] EX_MEM_Mult_Mux_o;
    input[31:0] EX_MEM_PCPlusBy4;
    input[31:0] WBSrc_Mux_o;
    
    input[2:0] IF_ID_rs_FUnit_o;
    
    output[31:0] IF_ID_rs_FMux_o;
    
    reg[31:0] Mux_reg;
    
    
    assign IF_ID_rs_FMux_o=Mux_reg;
    
    
    initial
      begin
        Mux_reg<=0;
      end
    
    always@( RegFile_o_1 or IF_ID_rs_FUnit_o or ID_EX_PCPlusBy4 or EX_MEM_Mult_Mux_o or EX_MEM_PCPlusBy4 or WBSrc_Mux_o)
      begin
        case(IF_ID_rs_FUnit_o)
          0:Mux_reg<=RegFile_o_1;
          1:Mux_reg<=ID_EX_PCPlusBy4;
          2:Mux_reg<=EX_MEM_Mult_Mux_o;
          3:Mux_reg<=EX_MEM_PCPlusBy4;
          4:Mux_reg<=WBSrc_Mux_o;
        endcase
      end
        
    
    
    
    
      
endmodule


