module JumpMux(PCJump,BranchMux_o,
  Jump_en,addr_o);
  input[31:0] PCJump;
  input[31:0] BranchMux_o;
  input Jump_en;
  output[31:0] addr_o;
  //1-Jump 0-No jumping
  assign addr_o=!Jump_en?BranchMux_o:PCJump;
  
  
endmodule
