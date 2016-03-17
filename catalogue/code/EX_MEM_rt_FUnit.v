module EX_MEM_rt_FUnit(EX_MEM_Instr,MEM_WB_Instr,
    EX_MEM_isR_t_2,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    EX_MEM_rt_FUnit_o);
    
    
    
    
    input[31:0] EX_MEM_Instr;
    input[31:0] MEM_WB_Instr;
    
	  input EX_MEM_isR_t_2;
	
    input MEM_WB_isW_rd_1;
    input MEM_WB_isW_rt_1;
    input MEM_WB_isW_31_rd_0;
    input MEM_WB_isW_rt_2;
    
    output EX_MEM_rt_FUnit_o;
    //rs[25:21]	rt[20:16]	rd[15:11]

    reg FUnit_reg;
    
    assign EX_MEM_rt_FUnit_o=FUnit_reg;
    
    always@(EX_MEM_Instr or MEM_WB_Instr)
		begin
		  FUnit_reg=0;
		  if(EX_MEM_isR_t_2 && EX_MEM_Instr[20:16])
			begin
			  if((MEM_WB_isW_rd_1 &&
			  (EX_MEM_Instr[20:16]==MEM_WB_Instr[15:11]))
			    ||
			  (MEM_WB_isW_rt_1 &&
			  (EX_MEM_Instr[20:16]==MEM_WB_Instr[20:16]))
			    ||
			  (MEM_WB_isW_31_rd_0 &&
			  ((EX_MEM_Instr[20:16]==MEM_WB_Instr[15:11])||
			  (EX_MEM_Instr[20:16]==31)))
				||
			  (MEM_WB_isW_rt_2 &&
			  (EX_MEM_Instr[20:16]==MEM_WB_Instr[20:16]))
			  )
			    FUnit_reg=1;
				
			end
		
		end
    
    
    
endmodule
    





