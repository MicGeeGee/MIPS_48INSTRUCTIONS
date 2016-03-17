module PC(CLK,RST,addr_i,EN,addr_o);
  input  CLK;
  input RST;
  input[31:0] addr_i;
  input EN;
  
  output[31:0]  addr_o;
  
  reg[31:0] addr;
  reg isActivated;
  
  assign addr_o=addr;
  
  initial
    begin
      isActivated=0;
      addr=0;
    end
  
//  always@(posedge CLK or posedge RST)
  always@(posedge CLK)
    begin
      if(RST)
        addr<='h3000;
      else if(isActivated==0)
        begin
          addr<='h3000;
          isActivated=1;
        end
      else if(EN)
        addr<=addr_i;

      
    end
endmodule