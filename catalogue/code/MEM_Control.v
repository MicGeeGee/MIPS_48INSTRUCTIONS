module MEM_Control(EX_MEM_Instr,MemRead_en,MemWrite_en,
        isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0,
        isR_rs_1,isR_rt_1,isR_rt_2,isR_rs_rt_0,isR_rs_0);
  input[31:0] EX_MEM_Instr;
  output MemRead_en;
  output MemWrite_en;
  
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
  
  assign op=EX_MEM_Instr[31:26];
  assign f=EX_MEM_Instr[5:0];
  
  
  assign MemRead_en=(op[5]&!op[4]&!op[3]&!op[1])|
                    (op[5]&!op[4]&!op[3]&!op[2]&op[0]);
  assign MemWrite_en=(op[5]&!op[4]&op[3]&!op[2]&!op[1])|
                     (op[5]&!op[4]&op[3]&!op[2]&op[0]);
  
  
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
  //  assign isR_rt_1=((!op)&((!f[5]&!f[4]&!f[3]&!f[2]&!f[0])|
    //                       (!f[5]&!f[4]&!f[3]&!f[2]&f[1])))|(isR_rs_1&!isR_rs_1_);
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
