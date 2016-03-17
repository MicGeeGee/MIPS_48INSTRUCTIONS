module WB_Control(MEM_WB_Instr,isJal,isRType,isJalr,RegWrite_en,isLwPlus,isMemRead,
          isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0,
          isR_rs_1,isR_rt_1,isR_rt_2,isR_rs_rt_0,isR_rs_0);
  input[31:0] MEM_WB_Instr;
  output isJal;
  output isRType;
  output isJalr;
  output RegWrite_en;
  
  output isLwPlus;
  
  output isMemRead;
  
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
  
  assign op=MEM_WB_Instr[31:26];
  assign f=MEM_WB_Instr[5:0];
      
  assign isJal=(MEM_WB_Instr[31:26]==6'b000011)?1:0;
  assign isRType=MEM_WB_Instr[31:26]?0:1;
  assign isJalr=(!MEM_WB_Instr[31:26]&&MEM_WB_Instr[5:0]==6'b001001)?1:0;


  assign RegWrite_en=op?
          ((!op[5]&!op[4]&op[3])|
           (op[5]&!op[4]&!op[3]&!op[1])|
           (!op[4]&!op[3]&!op[2]&op[1]&op[0])):
          (!((!f[5]&f[4]&f[3]&!f[2])|
           (!f[5]&f[3]&!f[2]&!f[1]&!f[0])|
           (!f[5]&f[3]&!f[2]&f[1]&f[0])|
           (!f[5]&!f[4]&f[3]&f[2]&!f[1]&f[0])));
  
  assign isLwPlus=(op[5]&!op[4]&!op[3]&!op[1])|
                (op[5]&!op[4]&!op[3]&!op[2]&op[0]);
  
  assign isMemRead=(op[5]&!op[4]&!op[3]&!op[1])|
                    (op[5]&!op[4]&!op[3]&!op[2]&op[0]);
  
  
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
 //   assign isR_rt_1=((!op)&((!f[5]&!f[4]&!f[3]&!f[2]&!f[0])|
   //                        (!f[5]&!f[4]&!f[3]&!f[2]&f[1])))|(isR_rs_1&!isR_rs_1_);
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