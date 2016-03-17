module ID_EX_rs_FUnit(ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    ID_EX_isR_s_1,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    ID_EX_rs_FUnit_o);
    
    
    
    input[31:0] ID_EX_Instr;
    input[31:0] EX_MEM_Instr;
    input[31:0] MEM_WB_Instr;
    
	  input ID_EX_isR_s_1;
	
    
    input EX_MEM_isW_rd_1;
    input EX_MEM_isW_rt_1;
    input EX_MEM_isW_31_rd_0;
    input MEM_WB_isW_rd_1;
    input MEM_WB_isW_rt_1;
    input MEM_WB_isW_31_rd_0;
    input MEM_WB_isW_rt_2;
    
    output[1:0] ID_EX_rs_FUnit_o;
    //rs[25:21]	rt[20:16]	rd[15:11]

    reg[1:0] FUnit_reg;
    
    assign ID_EX_rs_FUnit_o=FUnit_reg;
    
    always@(ID_EX_Instr or EX_MEM_Instr or MEM_WB_Instr)
		begin
		  FUnit_reg=0;
		  if(ID_EX_isR_s_1 && ID_EX_Instr[25:21])//$zero does not need to be forwarded.
			begin
			  if(
				 (EX_MEM_isW_rd_1 &&
			  (ID_EX_Instr[25:21]==EX_MEM_Instr[15:11]))
				||
				 (EX_MEM_isW_rt_1 &&
			  (ID_EX_Instr[25:21]==EX_MEM_Instr[20:16]))
			  )
				FUnit_reg=1;
				//
			  else if(EX_MEM_isW_31_rd_0 &&
			  ((ID_EX_Instr[25:21]==EX_MEM_Instr[15:11])||
			   (ID_EX_Instr[25:21]==31)))
				FUnit_reg=2;
			  
			  else if((MEM_WB_isW_rd_1 &&
			  (ID_EX_Instr[25:21]==MEM_WB_Instr[15:11]))
			    ||
			  (MEM_WB_isW_rt_1 &&
			  (ID_EX_Instr[25:21]==MEM_WB_Instr[20:16]))
			    ||
			  (MEM_WB_isW_31_rd_0 &&
			  ((ID_EX_Instr[25:21]==MEM_WB_Instr[15:11])||
			  (ID_EX_Instr[25:21]==31)))
				||
			  (MEM_WB_isW_rt_2 &&
			  (ID_EX_Instr[25:21]==MEM_WB_Instr[20:16]))
			  )
			    FUnit_reg=3;
				//
			end
		
		end
    
    
    
endmodule
    




