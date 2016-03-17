module NPC(IF_ID_PCPlusBy4,IF_ID_Instr25to0,
    SignEXUnit_o,isJOrJal,opcode,Compare_o,NPC_o);
    
    input[31:0] IF_ID_PCPlusBy4;
    input[25:0] IF_ID_Instr25to0;
    input[31:0] SignEXUnit_o;
    input isJOrJal;
    input[5:0] opcode;
    input Compare_o;
    
    output[31:0] NPC_o;
    
	wire[31:0] BranchAddrEXnSL;
	wire[31:0] PCBranch;
	wire[31:0] JumpAddrSLnLinked;
	wire[31:0] JumpAddrSL;
	
	
	SL2Unit slUnitB(SignEXUnit_o,BranchAddrEXnSL);
	assign PCBranch=IF_ID_PCPlusBy4+BranchAddrEXnSL;
	
	SL2Unit slUnitJ({6'b000000,IF_ID_Instr25to0},JumpAddrSL);
	assign JumpAddrSLnLinked={IF_ID_PCPlusBy4[31:28],JumpAddrSL[27:0]};	
	
	JumpMux jumpMux(JumpAddrSLnLinked,PCBranch,isJOrJal,NPC_o);
endmodule
    
  

