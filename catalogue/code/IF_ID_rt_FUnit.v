module IF_ID_rt_FUnit(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    IF_ID_isR_rs_rt_0,
    ID_EX_isW_31_rd_0,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    IF_ID_rt_FUnit_o);
    
    
    input[31:0] IF_ID_Instr;
    input[31:0] ID_EX_Instr;
    input[31:0] EX_MEM_Instr;
    input[31:0] MEM_WB_Instr;
    
    input IF_ID_isR_rs_rt_0;

    input ID_EX_isW_31_rd_0;
    input EX_MEM_isW_rd_1;
    input EX_MEM_isW_rt_1;
    input EX_MEM_isW_31_rd_0;
    input MEM_WB_isW_rd_1;
    input MEM_WB_isW_rt_1;
    input MEM_WB_isW_31_rd_0;
    input MEM_WB_isW_rt_2;
    
    output[2:0] IF_ID_rt_FUnit_o;
    //rs[25:21]	rt[20:16]	rd[15:11]

    reg[2:0] FUnit_reg;
    
    assign IF_ID_rt_FUnit_o=FUnit_reg;
    
    always@(IF_ID_Instr or ID_EX_Instr or EX_MEM_Instr or MEM_WB_Instr
    or IF_ID_isR_rs_rt_0 or ID_EX_isW_31_rd_0 or EX_MEM_isW_rd_1 or EX_MEM_isW_rt_1
    or EX_MEM_isW_31_rd_0 or MEM_WB_isW_rd_1 or MEM_WB_isW_rt_1 or MEM_WB_isW_31_rd_0
    or MEM_WB_isW_rt_2)
		begin
		  FUnit_reg=0;
		  if(IF_ID_isR_rs_rt_0 && IF_ID_Instr[20:16])
		  begin
			  if(ID_EX_isW_31_rd_0 && 
			  ((IF_ID_Instr[20:16]==ID_EX_Instr[15:11])||
			   (IF_ID_Instr[20:16]==31)))
				FUnit_reg=1;
				//
			  else if(
				 (EX_MEM_isW_rd_1 &&
			  (IF_ID_Instr[20:16]==EX_MEM_Instr[15:11]))
				||
				 (EX_MEM_isW_rt_1 &&
			  (IF_ID_Instr[20:16]==EX_MEM_Instr[20:16]))
			  )
				FUnit_reg=2;
				//
			  else if(EX_MEM_isW_31_rd_0 &&
			  ((IF_ID_Instr[20:16]==EX_MEM_Instr[15:11])||
			   (IF_ID_Instr[20:16]==31)))
				FUnit_reg=3;
			  // 
			  else if((MEM_WB_isW_rd_1 &&
			  (IF_ID_Instr[20:16]==MEM_WB_Instr[15:11]))
			    ||
			  (MEM_WB_isW_rt_1 &&
			  (IF_ID_Instr[20:16]==MEM_WB_Instr[20:16]))
			    ||
			  (MEM_WB_isW_31_rd_0 &&
			  ((IF_ID_Instr[20:16]==MEM_WB_Instr[15:11])||
			  (IF_ID_Instr[20:16]==31)))
				  ||
			  (MEM_WB_isW_rt_2 &&
			  (IF_ID_Instr[20:16]==MEM_WB_Instr[20:16]))
			  )
			    FUnit_reg=4;
				//
			end
		
		end
    
    
    
endmodule
    
