module RegDstMux(MEM_WB_Instr20to16,
        MEM_WB_Instr15to11,isJal,isRType,RegDstMux_o);
  input[4:0] MEM_WB_Instr20to16;
  input[4:0] MEM_WB_Instr15to11;
  input isJal;
  input isRType;
        
  output[4:0] RegDstMux_o;
        
  
  assign RegDstMux_o=isJal?31:(isRType?MEM_WB_Instr15to11:MEM_WB_Instr20to16);
  
endmodule
//has been changed.