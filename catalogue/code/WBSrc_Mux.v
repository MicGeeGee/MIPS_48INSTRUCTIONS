module WBSrc_Mux(MEM_WB_Mult_Mux_o,MEM_WB_MEM_o,MEM_WB_PCPlusBy4,
                  isJal,isJalr,isRType,isLwPlus,WBSrc_Mux_o);
  input[31:0] MEM_WB_Mult_Mux_o;
  input[31:0] MEM_WB_MEM_o;
  input[31:0] MEM_WB_PCPlusBy4;
  input isJal;
  input isJalr;
  input isRType;
  input isLwPlus;

  output[31:0] WBSrc_Mux_o;
  
  assign WBSrc_Mux_o=(isLwPlus)?MEM_WB_MEM_o:((isJal||isJalr)?MEM_WB_PCPlusBy4:MEM_WB_Mult_Mux_o);
  
endmodule
