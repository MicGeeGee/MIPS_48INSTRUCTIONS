module ALUSrcMux(ID_EX_rs2,ID_EX_SignEx_o,isRType,ALUSrcMux_o);
  input[31:0] ID_EX_rs2;
  input[31:0] ID_EX_SignEx_o;
  input isRType;
  
  output[31:0] ALUSrcMux_o;
  
  assign ALUSrcMux_o=isRType?ID_EX_rs2:ID_EX_SignEx_o;
endmodule
//has been changed.  
  
  


