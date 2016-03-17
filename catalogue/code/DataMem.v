module DataMem(CLK,EX_MEM_Op,addr,data_w,
  data_r,MemRead_en,MemWrite_en,
  MEM_WB_RegWrite_en,RegDst_Mux_o,EX_MEM_Instr20to16,MEM_WB_MemRead,MEM_WB_DataMem_o
  );
  input CLK;
  input[5:0] EX_MEM_Op;
  input[15:0] addr;
  input[31:0] data_w;
  output[31:0] data_r;
  //Here MemRead control is omitted.
  input MemRead_en;
  
  input MemWrite_en;
  
  input MEM_WB_RegWrite_en;
  input[4:0] RegDst_Mux_o;
  input[4:0] EX_MEM_Instr20to16;
  input MEM_WB_MemRead;
  input[31:0] MEM_WB_DataMem_o;
  
  

  reg[7:0] Mem[0:65534];
  
  reg[31:0] r_reg;
//  reg[31:0] w_reg;
  integer i;
  initial
    begin
      Mem[0]<=0;
      Mem[1]<=0;
      Mem[2]<=0;
      Mem[3]<=0;
      for(i=0;i<=65534;i=i+1)
       Mem[i]<=0;
    end
  
 
  
  assign data_r=r_reg;
  //assign data_r={Mem[addr[15:0]],Mem[addr[15:0]+1],Mem[addr[15:0]+2],Mem[addr[15:0]+3]};
  always@(EX_MEM_Op or addr)
    case(EX_MEM_Op)
      6'b100000:r_reg={{24{Mem[addr[15:0]][7]}},Mem[addr[15:0]]};//lb
      6'b100100:r_reg={24'b0,Mem[addr[15:0]]};//lbu
      6'b100001:r_reg={{16{Mem[addr[15:0]+1][7]}},Mem[addr[15:0]+1],Mem[addr[15:0]]};//lh
      6'b100101:r_reg={16'b0,Mem[addr[15:0]+1],Mem[addr[15:0]]};//lhu
      6'b100011:r_reg={Mem[addr[15:0]+3],Mem[addr[15:0]+2],Mem[addr[15:0]+1],Mem[addr[15:0]]};//lw
    endcase
      
  always@(posedge CLK)
    if(MemWrite_en)
      begin
        if(MEM_WB_RegWrite_en && MemWrite_en &&
          (RegDst_Mux_o==EX_MEM_Instr20to16) && MEM_WB_MemRead)
          case(EX_MEM_Op)
            6'b101000:Mem[addr[15:0]]<=MEM_WB_DataMem_o[7:0];//sb
            6'b101001:{Mem[addr[15:0]+1],Mem[addr[15:0]+0]}<=MEM_WB_DataMem_o[15:0];//sh
            6'b101011:{Mem[addr[15:0]+3],Mem[addr[15:0]+2],Mem[addr[15:0]+1],Mem[addr[15:0]]}<=MEM_WB_DataMem_o;//sw
          endcase
        else
          case(EX_MEM_Op)
            6'b101000:Mem[addr[15:0]]<=data_w[7:0];
            6'b101001:{Mem[addr[15:0]+1],Mem[addr[15:0]]}<=data_w[15:0];
            6'b101011:{Mem[addr[15:0]+3],Mem[addr[15:0]+2],Mem[addr[15:0]+1],Mem[addr[15:0]]}<=data_w;
          endcase
      end
      
   
            
endmodule

//has been reformed.


/*
 assign data_r=r_reg;
  //assign data_r={Mem[addr[15:0]],Mem[addr[15:0]+1],Mem[addr[15:0]+2],Mem[addr[15:0]+3]};
  always@(EX_MEM_Op or addr)
    case(EX_MEM_Op)
      6'b100000:r_reg={24'b0,Mem[addr[15:0]]};
      6'b100100:r_reg={{24{Mem[addr[15:0]][15]}},Mem[addr[15:0]]};
      6'b100001:r_reg={{16{Mem[addr[15:0]][15]}},Mem[addr[15:0]],Mem[addr[15:0]+1]};
      6'b100101:r_reg={16'b0,Mem[addr[15:0]],Mem[addr[15:0]+1]};
      6'b100011:r_reg={Mem[addr[15:0]],Mem[addr[15:0]+1],Mem[addr[15:0]+2],Mem[addr[15:0]+3]};
    endcase
      
  always@(posedge CLK)
    if(MemWrite_en)
      begin
        if(MEM_WB_RegWrite_en && MemWrite_en &&
          (RegDst_Mux_o==EX_MEM_Instr20to16) && MEM_WB_MemRead)
          case(EX_MEM_Op)
            6'b101000:Mem[addr[15:0]]<=MEM_WB_DataMem_o[7:0];
            6'b101001:{Mem[addr[15:0]],Mem[addr[15:0]+1]}<=MEM_WB_DataMem_o[15:0];
            6'b101011:{Mem[addr[15:0]],Mem[addr[15:0]+1],Mem[addr[15:0]+2],Mem[addr[15:0]+3]}<=MEM_WB_DataMem_o;
          endcase
        else
          case(EX_MEM_Op)
            6'b101000:Mem[addr[15:0]]<=data_w[7:0];
            6'b101001:{Mem[addr[15:0]],Mem[addr[15:0]+1]}<=data_w[15:0];
            6'b101011:{Mem[addr[15:0]],Mem[addr[15:0]+1],Mem[addr[15:0]+2],Mem[addr[15:0]+3]}<=data_w;
          endcase
      end*/