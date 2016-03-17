module ALU(ALUCtl,data1,data2,
  ALUResult,zeroBit);
  input[3:0] ALUCtl;
  input[31:0] data1;
  input[31:0] data2;
  output[31:0] ALUResult;
  output zeroBit;
  
  reg[31:0] ALUResult;
  
  assign zeroBit=(ALUResult)?0:1;
  always@(ALUCtl or data1 or data2)
    begin
      case(ALUCtl)
     	4'b0001:ALUResult=data1+data2;//	+
		  4'b0010:ALUResult=data1&data2;//	&
		  4'b0011:ALUResult=data1|data2;//	|
	   	4'b0100:ALUResult=data1^data2;//	xor
	 	  4'b0101:ALUResult=$signed(data1)<$signed(data2)?1:0;//	signed<signed?
		  4'b0110:ALUResult=data1<data2?1:0;//	<?
		  4'b0111:ALUResult={data2,16'b0};//{rs2,16'b0}
		  4'b1000:ALUResult=data1-data2;//	-
		  4'b1001:ALUResult=~(data1|data2);//	nor
		  4'b1010:ALUResult=data2<<data1[4:0];//	<<
		  4'b1011:ALUResult=data2>>data1[4:0];//	0>>
		  4'b1100:ALUResult=$signed(data2)>>>data1[4:0];//	rs2[31]>>
	  endcase
    end
endmodule
//has been reformed.