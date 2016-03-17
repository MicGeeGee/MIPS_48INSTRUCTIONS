module PCSrcMux(ADD4_o,RegFile_o_1,NPC_o,isJOrJal,Compare_o,isJrOrJalr,PCSrcMux_o);
  input[31:0] ADD4_o;
  input[31:0] RegFile_o_1;
  input[31:0] NPC_o;

  input isJOrJal;
  input Compare_o;
  input isJrOrJalr;
      
  output[31:0] PCSrcMux_o;
  
  assign PCSrcMux_o=(isJOrJal||Compare_o)?NPC_o:(isJrOrJalr?RegFile_o_1:ADD4_o);
  
  
  

endmodule

//has been reformed.
//Its output is the input of PC.

//isJumpOrBranch= isJOrJal | Compare_o | isJrOrJalr    
  
  
  
    
  




