module ALUControl(isRType,ALUOp2,ALUOp1,ALUOp0,funct,ALUCtl_o);
  input ALUOp2;
  input ALUOp1;
  input ALUOp0;
  
  input isRType;
  input[5:0] funct;
  output[3:0] ALUCtl_o;
  
  wire[5:0] f;
  wire[2:0] ALUOp;
  
  assign f=funct;
  assign ALUOp={ALUOp2,ALUOp1,ALUOp0};
  
  
  assign ALUCtl_o[3]=isRType?
                    ((!f[4]&!f[3]&!f[2]&f[1])|
                     (!f[4]&!f[3]&f[1]&f[0])|
                     (!f[5]&!f[4]&!f[3]&!f[0])
                     ):0;
  
  assign ALUCtl_o[2]=isRType?
                  ( (!f[5]&!f[4]&!f[3]&f[1]&f[0])|
                    (f[5]&!f[4]&f[3]&!f[2]&f[1])|
                    (f[5]&!f[4]&!f[3]&f[2]&f[1]&!f[0])):ALUOp[2];
  assign ALUCtl_o[1]=isRType?
                    ((!f[5]&!f[4]&!f[3]&!f[0])|
                     (f[5]&!f[4]&!f[3]&f[2]&!f[1])|
                     (!f[4]&!f[3]&f[2]&!f[1]&!f[0])|
                     (f[5]&!f[4]&f[3]&!f[2]&f[1]&f[0])):ALUOp[1];
  assign ALUCtl_o[0]=isRType?
                    ((f[5]&!f[4]&!f[3]&!f[2]&!f[1])|
                    (f[5]&!f[4]&!f[3]&!f[1]&f[0])|
                    (f[5]&!f[4]&!f[3]&f[2]&f[0])|
                    (!f[5]&!f[4]&!f[3]&f[1]&!f[0])|
                    (f[5]&!f[4]&f[3]&!f[2]&f[1]&!f[0])):ALUOp[0];
  
  
endmodule
//has been reformed.