module PauseJudger(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,
    ID_EX_isW_rd_1,ID_EX_isW_rt_1,ID_EX_isW_rt_2,
    EX_MEM_isW_rt_2,isPause);
    
    input[31:0] IF_ID_Instr;
	  input[31:0] ID_EX_Instr;
   	input[31:0] EX_MEM_Instr;
	
    input ID_EX_isW_rd_1;
    input ID_EX_isW_rt_1;
    input ID_EX_isW_rt_2;
    input EX_MEM_isW_rt_2;
    
    output isPause;
    
    wire[5:0] op;
    wire[5:0] f;
    
    wire isR_rs_1;
    wire isR_rt_1;
    wire isR_rt_2;
    wire isR_rs_rt_0;
    wire isR_rs_0;
    

    
    wire s1;
    wire s2;
    wire s3;
    wire s4;
    wire s5;
    wire s6;
    wire s7;
    wire s8;
    wire s9;
    wire s10;
    
    
    assign op=IF_ID_Instr[31:26];
    assign f=IF_ID_Instr[5:0];
    
    
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
    
    
    
    
    assign s1=isR_rs_1&&ID_EX_isW_rt_2&&(IF_ID_Instr[25:21]==ID_EX_Instr[20:16]);
	//
	assign s2=isR_rt_1&&ID_EX_isW_rt_2&&(IF_ID_Instr[20:16]==ID_EX_Instr[20:16]);
	//
    assign s3=isR_rs_rt_0&&ID_EX_isW_rd_1&&
			((IF_ID_Instr[25:21]==ID_EX_Instr[15:11])||
			 (IF_ID_Instr[20:16]==ID_EX_Instr[15:11]));
	assign s4=isR_rs_rt_0&&ID_EX_isW_rt_1&&
			((IF_ID_Instr[25:21]==ID_EX_Instr[20:16])||
			 (IF_ID_Instr[20:16]==ID_EX_Instr[20:16]));
	assign s5=isR_rs_rt_0&&ID_EX_isW_rt_2&&
			((IF_ID_Instr[25:21]==ID_EX_Instr[20:16])||
			 (IF_ID_Instr[20:16]==ID_EX_Instr[20:16]));
	assign s6=isR_rs_rt_0&&EX_MEM_isW_rt_2&&
			((IF_ID_Instr[25:21]==EX_MEM_Instr[20:16])||
			 (IF_ID_Instr[20:16]==EX_MEM_Instr[20:16]));
	//		 
	assign s7=isR_rs_0&&ID_EX_isW_rd_1&&(IF_ID_Instr[25:21]==ID_EX_Instr[15:11]);
	assign s8=isR_rs_0&&ID_EX_isW_rt_1&&(IF_ID_Instr[25:21]==ID_EX_Instr[20:16]);
	assign s9=isR_rs_0&&ID_EX_isW_rt_2&&(IF_ID_Instr[25:21]==ID_EX_Instr[20:16]);
	assign s10=isR_rs_0&&EX_MEM_isW_rt_2&&(IF_ID_Instr[25:21]==EX_MEM_Instr[20:16]);
	//
	assign isPause=s1|s2|s3|s4|s5|s6|s7|s8|s9|s10;
  
endmodule

