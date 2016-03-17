module DataPathNControl(CLK,PowerSwch);
  input CLK;
  input PowerSwch;
  
  
  
  
//  wire[31:0] PC_i;

  wire[31:0] PC_o;
//  wire[31:0] NextPC_i;
  wire[31:0] NextPC_o;
  wire[31:0] iMem_o;


  wire RegDst_en;
  wire[4:0] RegDstMux_o;
  wire[31:0] SignEXUnit_o;
  wire ALUOp1;
  wire ALUOp0;
  wire[31:0] RegFile_o_1;
  wire[31:0] RegFile_o_2;
  wire ALUSrc_en;
  wire[3:0] ALUCtl_o;
  wire[31:0] ALUSrcMux_o;
  wire[31:0] ALUResult;
  wire zeroBit;
  wire RegWrite_en;
  wire MemRead_en;
  wire MemWrite_en;
  wire MemtoReg_en;
  wire[31:0] dMem_o;
 
  wire PCRst;
  
 
  wire[31:0] ADD4_o;
  wire PCSrc_en;
  

  
  wire[5:0] Op;
  

  
  
  wire Stall_en;
  wire PCWrite_en;
  wire IF_IDWrite_en;
  wire Flush_en;
  
  
  wire[31:0] StallMux_o;
  
  wire Compare_o;
  
  wire isJOrJal;
  wire isJrOrJalr;
  wire isBlezPlus;
  wire isSllPlus;
  wire[31:0] PCSrcMux_o;
 
  wire[31:0] IF_ID_Instr;
  
  wire IF_ID_isW_rd_1;
  wire IF_ID_isW_rt_1;
  wire IF_ID_isW_rt_2;
  wire IF_ID_isW_31_rd_0;
  wire IF_ID_isSigned;
  
  wire[31:0] EX_MEM_Instr;
  
  wire isPause;
  wire isJumpOrBranch;
  wire[31:0] ID_EX_PCPlusBy4;
  wire[31:0] ID_EX_Instr;
  wire[31:0] ID_EX_rs;
  wire[31:0] ID_EX_rt;
  wire[31:0] ID_EX_SignEX_o;
  
  
  wire[2:0] IF_ID_rs_FUnit_o;
  wire[2:0] IF_ID_rt_FUnit_o;
  wire[31:0] IF_ID_rs_FMux_o;
  wire[31:0] IF_ID_rt_FMux_o;
  
  wire IF_ID_isR_rs_1;
  wire IF_ID_isR_rt_1;
  wire IF_ID_isR_rt_2;
  wire IF_ID_isR_rs_rt_0;
  wire IF_ID_isR_rs_0;
  
  wire ID_EX_isRType;
  wire isMfhi;
  wire isMflo;
  wire ALUOp2;

  wire isMult;
  wire isDiv;
  wire ID_EX_isSigned;
  wire ID_EX_isW_rd_1;
  wire ID_EX_isW_rt_1;
  wire ID_EX_isW_rt_2;
  wire ID_EX_isW_31_rd_0;
  wire ID_EX_isR_rs_1;
  wire ID_EX_isR_rt_1;
  wire ID_EX_isR_rt_2;
  wire ID_EX_isR_rs_rt_0;
  wire ID_EX_isR_rs_0;
  
  
  wire EX_MEM_isW_rd_1;
  wire EX_MEM_isW_rt_1;
  wire EX_MEM_isW_rt_2;
  wire EX_MEM_isW_31_rd_0;
  wire EX_MEM_isR_rs_1;
  wire EX_MEM_isR_rt_1;
  wire EX_MEM_isR_rt_2;
  wire EX_MEM_isR_rs_rt_0;
  wire EX_MEM_isR_rs_0;
  
  wire[31:0] MEM_WB_PCPlusBy4;
  wire[31:0] MEM_WB_Instr;
  wire[31:0] MEM_WB_Mult_Mux_o;
  wire[31:0] MEM_WB_dataMem_o;
  
  wire MEM_WB_isJal;
  wire MEM_WB_isRType;
  wire MEM_WB_isJalr;
  
  wire MEM_WB_isW_rd_1;
  wire MEM_WB_isW_rt_1;
  wire MEM_WB_isW_rt_2;
  wire MEM_WB_isW_31_rd_0;
  wire MEM_WB_isR_rs_1;
  wire MEM_WB_isR_rt_1;
  wire MEM_WB_isR_rt_2;
  wire MEM_WB_isR_rs_rt_0;
  wire MEM_WB_isR_rs_0;
  
  wire[31:0] Bzero_Mux_o;
  
  wire[31:0] ID_EX_rs_FMux_o;
  wire[1:0] ID_EX_rs_FUnit_o;
  wire[31:0] ID_EX_rt_FMux_o;
  wire[1:0] ID_EX_rt_FUnit_o;
  wire[31:0] hi_o;
  wire[31:0] lo_o;
  wire[31:0] Mult_Mux_o;
  
  wire EX_MEM_rt_FUnit_o;
  wire[31:0] EX_MEM_rt_FMux_o;
  wire[31:0] WBSrc_Mux_o;
  

  wire[31:0] EX_MEM_ID_EX_rt_FMux_o;
  wire[31:0] IF_ID_PCPlusBy4;
  wire[31:0] NPC_o;
  wire[31:0] Shamt_Mux_o;
  wire[31:0] EX_MEM_Mult_Mux_o;
  wire[31:0] EX_MEM_PCPlusBy4;
  wire MEM_WB_isLwPlus;
  
  wire MEM_WB_MemRead;
  
//  assign PC_en=1'b1;
  assign PCRst=!PowerSwch;

  
  
  assign ADD4_o=PC_o+4;
 
  assign isJumpOrBranch=isJOrJal|Compare_o|isJrOrJalr;

 
  PCSrcMux PCSrcMux_(ADD4_o,IF_ID_rs_FMux_o,NPC_o,isJOrJal,Compare_o,isJrOrJalr,PCSrcMux_o);
  

  
  
  PC pc(CLK,PCRst,PCSrcMux_o,PCWrite_en,PC_o);
  
  
  
  NPC NPC_(IF_ID_PCPlusBy4,IF_ID_Instr[25:0],
    SignEXUnit_o,isJOrJal,IF_ID_Instr[31:26],Compare_o,NPC_o);
  
  
  InstrMem iMem(PC_o,iMem_o);
  
  IF_IDPplReg IF_IDPplReg_(ADD4_o,iMem_o,IF_IDWrite_en,Flush_en,
          IF_ID_PCPlusBy4,IF_ID_Instr,CLK);
		  

  
  ID_Control ID_Control_(IF_ID_Instr,isJOrJal,isJrOrJalr,isBlezPlus,isSllPlus,IF_ID_isSigned,
                IF_ID_isW_rd_1,IF_ID_isW_rt_1,IF_ID_isW_rt_2,IF_ID_isW_31_rd_0,
                IF_ID_isR_rs_1,IF_ID_isR_rt_1,IF_ID_isR_rt_2,IF_ID_isR_rs_rt_0,IF_ID_isR_rs_0);
  
  StallMux StallMux_(Stall_en,IF_ID_Instr,StallMux_o); 
  
  
  PauseJudger PauseJudger_(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,
    ID_EX_isW_rd_1,ID_EX_isW_rt_1,ID_EX_isW_rt_2,
    EX_MEM_isW_rt_2,isPause);
	
  HazardUnit HazardUnit_(isPause,isJumpOrBranch,
            Stall_en,PCWrite_en,IF_IDWrite_en,Flush_en);
  
  SignEXUnit signEXUnit(IF_ID_Instr[15:0],SignEXUnit_o,IF_ID_isSigned);
  //module SignEXUnit(imme,imme_ex,isSigned);  
  
  
  RegFile RegFile_(CLK,IF_ID_Instr[25:21],IF_ID_Instr[20:16],RegDstMux_o,
  WBSrc_Mux_o,RegFile_o_1,RegFile_o_2,RegWrite_en);
  
  Shamt_Mux Shamt_Mux_(IF_ID_Instr[10:6],IF_ID_rs_FMux_o,isSllPlus,Shamt_Mux_o);
  
  
  
  IF_ID_rs_FUnit IF_ID_rs_FUnit_(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    IF_ID_isR_rs_rt_0,IF_ID_isR_rs_0,
    ID_EX_isW_31_rd_0,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    IF_ID_rs_FUnit_o);
  IF_ID_rs_FMux IF_ID_rs_FMux_(RegFile_o_1,ID_EX_PCPlusBy4,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    IF_ID_rs_FUnit_o,
    IF_ID_rs_FMux_o
    );
	
 
	
  Bzero_Mux Bzero_Mux_(IF_ID_rt_FMux_o,isBlezPlus,Bzero_Mux_o);
  Compare Compare_(IF_ID_rs_FMux_o,Bzero_Mux_o,IF_ID_Instr,Compare_o);
  
  IF_ID_rt_FUnit IF_ID_rt_FUnit_(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    IF_ID_isR_rs_rt_0,
    ID_EX_isW_31_rd_0,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    IF_ID_rt_FUnit_o);
  IF_ID_rt_FMux IF_ID_rt_FMux_(RegFile_o_2,ID_EX_PCPlusBy4,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    IF_ID_rt_FUnit_o,
    IF_ID_rt_FMux_o
    );
	

  ID_EXPplReg ID_EXPplReg_(IF_ID_PCPlusBy4,StallMux_o,Shamt_Mux_o,IF_ID_rt_FMux_o,SignEXUnit_o,
      ID_EX_PCPlusBy4,ID_EX_Instr,ID_EX_rs,ID_EX_rt,ID_EX_SignEX_o,
      Stall_en,CLK);
  
  ID_EX_rs_FUnit ID_EX_rs_FUnit_(ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    ID_EX_isR_rs_1,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    ID_EX_rs_FUnit_o);
  ID_EX_rs_FMux ID_EX_rs_FMux_(ID_EX_rs,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    ID_EX_rs_FUnit_o,
    ID_EX_rs_FMux_o
    );
  
  ID_EX_rt_FUnit ID_EX_rt_FUnit_(ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    ID_EX_isR_rt_1,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    ID_EX_rt_FUnit_o);
  ID_EX_rt_FMux ID_EX_rt_FMux_(ID_EX_rt,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    ID_EX_rt_FUnit_o,
    ID_EX_rt_FMux_o
    );
  ALU_mult ALU_mult_(ID_EX_rs_FMux_o,ID_EX_rt_FMux_o,isMult,isDiv,ID_EX_isSigned,hi_o,lo_o);
  
  ALUControl ALUControl_(ID_EX_isRType,ALUOp2,ALUOp1,ALUOp0,ID_EX_Instr[5:0],ALUCtl_o);
  ALUSrcMux ALUSrcMux_(ID_EX_rt_FMux_o,ID_EX_SignEX_o,ID_EX_isRType,ALUSrcMux_o);

  Mult_Mux Mult_Mux_(ALUResult,hi_o,lo_o,isMfhi,isMflo,Mult_Mux_o);
  ALU alu(ALUCtl_o,ID_EX_rs_FMux_o,ALUSrcMux_o,ALUResult,zeroBit);
  
  
  
  EX_Control EX_Control_(ID_EX_Instr,ID_EX_isRType,isMfhi,isMflo,ALUOp2,ALUOp1,ALUOp0,isMult,isDiv,ID_EX_isSigned,
              ID_EX_isW_rd_1,ID_EX_isW_rt_1,ID_EX_isW_rt_2,ID_EX_isW_31_rd_0,
              ID_EX_isR_rs_1,ID_EX_isR_rt_1,ID_EX_isR_rt_2,ID_EX_isR_rs_rt_0,ID_EX_isR_rs_0);
  
  
  
  EX_MEMPplReg EX_MEMPplReg_(ID_EX_PCPlusBy4,ID_EX_Instr,Mult_Mux_o,ID_EX_rt_FMux_o,
              EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,EX_MEM_ID_EX_rt_FMux_o,
              CLK);
  
  EX_MEM_rt_FUnit EX_MEM_rt_FUnit_(EX_MEM_Instr,MEM_WB_Instr,
    EX_MEM_isR_rt_2,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    EX_MEM_rt_FUnit_o);
  EX_MEM_rt_FMux EX_MEM_rt_FMux_(EX_MEM_ID_EX_rt_FMux_o,WBSrc_Mux_o,
    EX_MEM_rt_FUnit_o,
    EX_MEM_rt_FMux_o
    );
	
  DataMem DataMem_(CLK,EX_MEM_Instr[31:26],EX_MEM_Mult_Mux_o,EX_MEM_rt_FMux_o,
  dMem_o,MemRead_en,MemWrite_en,
  RegWrite_en,RegDstMux_o,EX_MEM_Instr[20:16],MEM_WB_MemRead,MEM_WB_dataMem_o);
  
  MEM_Control MEM_Control_(EX_MEM_Instr,MemRead_en,MemWrite_en,
        EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_rt_2,EX_MEM_isW_31_rd_0,
        EX_MEM_isR_rs_1,EX_MEM_isR_rt_1,EX_MEM_isR_rt_2,EX_MEM_isR_rs_rt_0,EX_MEM_isR_rs_0);
  
  MEM_WBPplReg MEM_WBPplReg_(EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,dMem_o,
        MEM_WB_PCPlusBy4,MEM_WB_Instr,MEM_WB_Mult_Mux_o,MEM_WB_dataMem_o,
        CLK);
  
  WB_Control WB_Control_(MEM_WB_Instr,MEM_WB_isJal,MEM_WB_isRType,MEM_WB_isJalr,RegWrite_en,MEM_WB_isLwPlus,MEM_WB_MemRead,
          MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_rt_2,MEM_WB_isW_31_rd_0,
          MEM_WB_isR_rs_1,MEM_WB_isR_rt_1,MEM_WB_isR_rt_2,MEM_WB_isR_rs_rt_0,MEM_WB_isR_rs_0);
  
  RegDstMux RegDstMux_(MEM_WB_Instr[20:16],
        MEM_WB_Instr[15:11],MEM_WB_isJal,MEM_WB_isRType,RegDstMux_o);
  WBSrc_Mux WBSrc_Mux_(MEM_WB_Mult_Mux_o,MEM_WB_dataMem_o,MEM_WB_PCPlusBy4,
                  MEM_WB_isJal,MEM_WB_isJalr,MEM_WB_isRType,MEM_WB_isLwPlus,WBSrc_Mux_o);
  
endmodule
/*





module ALU(ALUCtl,data1,data2,
  ALUResult,zeroBit);
module ALU_mult(rs1,rs2,isMult,isDiv,isSigned,hi_o,lo_o);
module ALUControl(ALUOp2,ALUOp1,ALUOp0,funct,ALUCtl_o);
module ALUSrcMux(ID_EX_rs2,ID_EX_SignEx_o,isRType,ALUSrcMux_o);
module Bzero_Mux(RegFile_o_2,isBlezPlus,Bzero_Mux_o);
module Compare(rs1,rs2,IF_ID_instr,Compare_o);
module DataMem(CLK,addr,data_w,
  data_r,MemRead_en,MemWrite_en,
  MEM_WBRegWrite_en,MEM_WBRegDstMux_o,EX_MEMRegDstMux_o,MEM_WBDataMem_o,MEM_WBMemRead);
module EX_Control(ID_EX_Instr,isRType,isMfhi,isMflo,ALUOp2,ALUOp1,ALUOp0,isMult,isDiv,isSigned,
              isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0);
module EX_MEM_rt_FMux(EXE_MEM_rt,WBSrc_Mux_o,
    EX_MEM_rt_FUnit_o,
    EX_MEM_rt_FMux_o
    );
module EX_MEM_rt_FUnit(EX_MEM_Instr,MEM_WB_Instr,
    EX_MEM_isR_t_2,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    EX_MEM_rt_FUnit_o);
module EX_MEMPplReg(PCPlusBy4,ID_EX_Instr,Mult_Mux_o,ID_EX_rt_FMux_o,
              EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,EX_MEM_ID_EX_rt_FMux_o,
              CLK);
module HazardUnit(isPause,isJumpOrBranch,
            Stall_en,PCWrite_en,IF_IDWrite_en,Flush_en);
module ID_Control(IF_ID_Instr,isJOrJal,isJrOrJalr,isBlezPlus,isSllPlus,isSigned,
                isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0);
module ID_EX_rs_FMux(ID_EX_rs,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    ID_EX_rs_FUnit_o,
    ID_EX_rs_FMux_o
    );
module ID_EX_rs_FUnit(ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    ID_EX_isR_s_1,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    ID_EX_rs_FUnit_o);
module ID_EX_rt_FMux(ID_EX_rt,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    ID_EX_rt_FUnit_o,
    ID_EX_rt_FMux_o
    );
module ID_EX_rt_FUnit(ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    ID_EX_isR_t_1,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    ID_EX_rt_FUnit_o);
module ID_EXPplReg(PCPlusBy4,StallMux_o,Shamt_Mux_o,IF_ID_rt_FMux_o,SignEXUnit_o,
      ID_EX_PCPlusBy4,ID_EX_Instr,ID_EX_rs,ID_EX_Rt,ID_EX_SignEX_o,
      CLK);
module IF_ID_rs_FMux(RegFile_o_1,ID_EX_PCPlusBy4,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    IF_ID_rs_FUnit_o,
    IF_ID_rs_FMux_o
    );
module IF_ID_rs_FUnit(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    IF_ID_isR_rs_rt_0,IF_ID_isR_rs_0,
    ID_EX_isW_31_rd_0,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    IF_ID_rs_FUnit_o);
module IF_ID_rt_FMux(RegFile_o_2,ID_EX_PCPlusBy4,EX_MEM_Mult_Mux_o,EX_MEM_PCPlusBy4,WBSrc_Mux_o,
    IF_ID_rt_FUnit_o,
    IF_ID_rt_FMux_o
    );
module IF_ID_rt_FUnit(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,MEM_WB_Instr,
    IF_ID_isR_rs_rt_0,
    ID_EX_isW_31_rd_0,
    EX_MEM_isW_rd_1,EX_MEM_isW_rt_1,EX_MEM_isW_31_rd_0,
    MEM_WB_isW_rd_1,MEM_WB_isW_rt_1,MEM_WB_isW_31_rd_0,MEM_WB_isW_rt_2,
    IF_ID_rt_FUnit_o);
module IF_IDPplReg(PCPlusBy4,InstrMem_o,IF_IDWrite_en,Flush_en,
          IF_ID_PCPlusBy4,IF_ID_Instr,CLK);
module InstrMem(addr,instr);		  
module JumpMux(PCJump,BranchMux_o,
  Jump_en,addr_o);   
module MEM_Control(EX_MEM_Instr,MemRead_en,MemWrite_en,
        isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0);
module MEM_WBPplReg(EX_MEM_PCPlusBy4,EX_MEM_Instr,EX_MEM_Mult_Mux_o,dataMem_o,
        MEM_WB_PCPlusBy4,MEM_WB_Instr,MEM_WB_Mult_Mux_o,MEM_WB_dataMem_o,
        CLK);
module Mult_Mux(ALUResult,ALU_mult_hi_o,ALU_mult_lo_o,isMfhi,isMflo,Mult_Mux_o);
module NPC(IF_ID_PCPlusBy4,IF_ID_Instr25to0,
    SignExUnit_o,isJOrJal,opcode,Compare_o,NPC_o);
module PauseJudger(IF_ID_Instr,ID_EX_Instr,EX_MEM_Instr,
    ID_EX_isW_rd_1,ID_EX_isW_rt_1,ID_EX_isW_rt_2,
    EX_MEM_isW_rt_2,isPause);
module PC(CLK,RST,addr_i,EN,addr_o);   
module PCSrcMux(ADD4_o,RegFile_o_1,NPC_o,isJOrJal,Compare_o,isJrOrJalr,PCSrcMux_o);
module RegDstMux(MEM_WB_Instr20to16,
        MEM_WB_Instr15to11,isJal,isRType,RegDstMux_o);
module RegFile   
(CLK,rs1,rs2,rd,
  data_w,data_r_1,data_r_2,RegWrite_en);
module s_mips(CLK,PowerSwch);
module Shamt_Mux(Shamt,RegFile_o_1,isSllPlus,Shamt_Mux_o);
module SignEXUnit(imme,imme_ex,isSigned);   
module SL2Unit(addr,addr_sl);
module StallMux(Stall_en,Instr,StallMux_o);
module WB_Control(MEM_WB_Instr,isJal,isRType,isJalr,RegWrite_en,
          isW_rd_1,isW_rt_1,isW_rt_2,isW_31_rd_0);
module WBSrc_Mux(MEM_WB_Mult_Mux_o,MEM_WB_MEM_o,MEM_WB_PCPlusBy4,
                  isJal,isJalr,isRType,WBSrc_Mux_o);
*/









