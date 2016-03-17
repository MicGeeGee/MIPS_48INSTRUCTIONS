//`timescale 1ns/1ns

module TestBench;
  reg CLK;
  reg PowerSwch;
  
  initial // ?1?clock generator
        begin
            CLK = 0;
            PowerSwch = 1;
            forever #10 CLK = !CLK; //Tclk = 20
        end
          
  s_mips mips(CLK,PowerSwch);
endmodule