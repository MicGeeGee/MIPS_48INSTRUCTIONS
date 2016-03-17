module ID_Control(IF_ID_Instr,isJOrJal,isJrOrJalr,isBlezPlus,isSllPlus,isSigned,
                isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0,
                isR_rs_1,isR_rt_1,isR_rt_2,isR_rs_rt_0,isR_rs_0);
  
  input[31:0] IF_ID_Instr;
  output isJOrJal;
  output isJrOrJalr;
  output isBlezPlus;
  output isSllPlus;
  output isSigned;
  
  output isW_rd_1;
  output isW_rt_1;
  output isW_rt_2;
  output isW_31_rd_0;
  
  output isR_rs_1;
  output isR_rt_1;
  output isR_rt_2;
  output isR_rs_rt_0;
  output isR_rs_0;
  
  wire[5:0] op;
  wire[5:0] f;
  
  wire isR_rs_1_;
  
  assign op=IF_ID_Instr[31:26];
  assign f=IF_ID_Instr[5:0];
  
  
  assign isJOrJal=(IF_ID_Instr[31:26]==6'b000010||IF_ID_Instr[31:26]==6'b000011)?1:0;
  
  assign isJrOrJalr=((IF_ID_Instr[31:26]==0)&&
  (IF_ID_Instr[5:0]==6'b001001||IF_ID_Instr[5:0]==6'b001000))?1:0;
  


  assign isBlezPlus=(IF_ID_Instr[31:26]==6'b000110||
        IF_ID_Instr[31:26]==6'b000111||IF_ID_Instr[31:26]==6'b000001)?1:0;
        
  assign isSllPlus=((IF_ID_Instr[31:26]==0)&&
  (IF_ID_Instr[5:0]==6'b000000||IF_ID_Instr[5:0]==6'b000010||IF_ID_Instr[5:0]==6'b000011))?1:0;

  assign isSigned=!((((f[5]&!f[4]&!f[3]&!f[2]&f[0])|
  (f[5]&!f[4]&!f[2]&f[1]&f[0])|
  (!f[5]&f[4]&f[3]&!f[2]&f[0]))
  &(IF_ID_Instr[31:26]==0))|
((!op[5]&!op[4]&op[3]&!op[2]&op[0])|
(op[5]&!op[4]&!op[3]&!op[2]&op[1])))&((op!=6'b001100)
&(op!=6'b001101)
&(op!=6'b001110));


   
  assign isW_rd_1=!op&(
            (f[5]&!f[4]&!f[3])|
            (!f[4]&!f[3]&!f[0])|
            (!f[4]&!f[3]&f[1])|
            (f[5]&!f[4]&!f[2]&f[1])|
            (!f[5]&!f[3]&!f[2]&!f[0])
            );//
            
            
            
  assign isW_rt_1=!op[5]&!op[4]&op[3];
  assign isW_rt_2=(op[5]&!op[4]&!op[3]&!op[1])|
                  (op[5]&!op[4]&!op[3]&!op[2]&op[0]);
  assign isW_31_rd_0=(op==3)|((op==0)&(f==9));
  
  //
  
    assign isR_rs_1=((!op)&
                     ((f[5]&!f[4]&!f[3])|
                      (!f[5]&f[4]&!f[2]&f[0])|
                      (f[5]&!f[4]&!f[2]&f[1])|
                      (!f[4]&!f[3]&f[2]&!f[0])|
                      (!f[4]&!f[3]&f[2]&f[1])|
                      (!f[5]&f[4]&f[3]&!f[2])))|
                      (op==8)|(op==9)|(op==12)|
                      (op==13)|(op==14)|(op==10)|
                      (op==11)|(op==32)|(op==36)|
                      (op==33)|(op==37)|(op==35)|
                      (op==40)|(op==41)|(op==43);              
                      
    assign isR_rs_1_=(!op[5]&!op[4]&op[3]&!op[1])|
                     (!op[5]&!op[4]&op[3]&!op[2])|
                     (!op[5]&!op[4]&op[3]&!op[0])|
                     (op[5]&!op[4]&!op[3]&!op[1])|
                     (op[5]&!op[4]&!op[3]&!op[2]&op[0]);            
    //assign isR_rt_1=((!op)&((!f[5]&!f[4]&!f[3]&!f[2]&!f[0])|
      //                     (!f[5]&!f[4]&!f[3]&!f[2]&f[1])))|(isR_rs_1&!isR_rs_1_);
    assign isR_rt_1=(!op)&((!f[4]&!f[3]&!f[0])|
                           (!f[4]&!f[3]&f[1])|
                           (f[5]&!f[4]&!f[3])|
                           (f[5]&!f[4]&!f[2]&f[1])|
                           (!f[5]&f[4]&f[3]&!f[2])|
                           (!f[5]&f[4]&!f[2]&f[0])|
                           (!f[5]&!f[3]&!f[2]&f[1]&f[0]))
                           |(op==40)|(op==41)|(op==43);
                           //
                           
    assign isR_rt_2=(op[5]&!op[4]&op[3]&!op[2]&!op[1])|
                    (op[5]&!op[4]&op[3]&!op[2]&op[0]);
    assign isR_rs_rt_0=!op[5]&!op[4]&!op[3]&op[2]&!op[1];
    
    assign isR_rs_0=((!op[5]&!op[4]&!op[3]&op[2]&op[1])|
                    (!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0]))
                   |(!op&(!f[5]&!f[4]&f[3]&!f[2]&!f[1]));
endmodule
