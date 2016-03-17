module SL2Unit(addr,addr_sl);
  input[31:0] addr;
  output[31:0] addr_sl;
  
  assign addr_sl={addr[29:0],2'b00};
endmodule