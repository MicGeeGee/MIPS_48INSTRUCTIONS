module s_mips(CLK,PowerSwch);
  input CLK;
  input PowerSwch;
  
  
  DataPathNControl dataPathNControl(CLK,PowerSwch);
endmodule
  