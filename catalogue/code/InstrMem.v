module InstrMem(addr,instr);
  //It need not be writen, so there's no CLK.
  input[31:0] addr;
  output[31:0] instr;
  
  reg[7:0] Mem[24576:0];
  
  initial
    begin
      Mem[0]<=0;
      Mem[1]<=0;
      Mem[2]<=0;
      Mem[3]<=0;
      $readmemb("Bytes.txt",Mem,'h3000);
    end
    
  assign instr={Mem[addr[31:0]],Mem[addr[31:0]+1],Mem[addr[31:0]+2],Mem[addr[31:0]+3]};
endmodule