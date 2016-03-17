module Shamt_Mux(Shamt,RegFile_o_1,isSllPlus,Shamt_Mux_o);
  input[4:0] Shamt;
  input[31:0] RegFile_o_1;
  input isSllPlus;
  
  output[31:0] Shamt_Mux_o;
  
  assign Shamt_Mux_o=isSllPlus?{26'b0,Shamt}:RegFile_o_1;
  
  
endmodule
