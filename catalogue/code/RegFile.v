module RegFile   
(CLK,rs1,rs2,rd,
  data_w,data_r_1,data_r_2,RegWrite_en);
  
  input CLK;
  input[4:0] rs1;
  input[4:0] rs2;
  input[4:0] rd;
  input[31:0] data_w;
  input RegWrite_en;
  
  output[31:0] data_r_1;
  output[31:0] data_r_2;
  
  reg[31:0]regFile[0:31];//32 registers of 32bits
  
  assign data_r_1=rs1?((rs1==rd&&RegWrite_en)?data_w:regFile[rs1]):0;  
  assign data_r_2=rs2?((rs2==rd&&RegWrite_en)?data_w:regFile[rs2]):0;  
  

  initial
    begin
      regFile[29]='h2ffc;
      regFile[0]=0;
      regFile[28]='h1800;
    end
    
  always@(posedge CLK)
    begin
      if(RegWrite_en)
          regFile[rd]=data_w;
          
        
    end
  
    

  

//  assign data_r_1=(rs1 && !CLK)?regFile[rs1]:0;//judgement of $0 register
//  assign data_r_2=(rs2 && !CLK)?regFile[rs2]:0;//judgement of $0 register
endmodule
  
  