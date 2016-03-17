module Mult_Mux(ALUResult,ALU_mult_hi_o,ALU_mult_lo_o,isMfhi,isMflo,Mult_Mux_o);
  input[31:0] ALUResult;
  input[31:0] ALU_mult_hi_o;
  input[31:0] ALU_mult_lo_o;
  input isMfhi;
  input isMflo;
  output[31:0] Mult_Mux_o;
  
  assign Mult_Mux_o=isMfhi?ALU_mult_hi_o:(isMflo?ALU_mult_lo_o:ALUResult);
  
  
endmodule
