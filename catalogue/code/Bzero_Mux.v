module Bzero_Mux(RegFile_o_2,isBlezPlus,Bzero_Mux_o);
  input[31:0] RegFile_o_2;
  input isBlezPlus;
  output[31:0] Bzero_Mux_o;
  
  assign Bzero_Mux_o=isBlezPlus?32'b0:RegFile_o_2;
endmodule
    