module StallMux(Stall_en,Instr,StallMux_o);
          input Stall_en;
          input[31:0] Instr;
          
          output[31:0] StallMux_o;          

          
          
          assign StallMux_o=Stall_en?0:Instr;
          
          
          
endmodule
//has been reformed.