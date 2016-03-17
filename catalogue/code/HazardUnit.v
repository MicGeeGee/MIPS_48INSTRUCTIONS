module HazardUnit(isPause,isJumpOrBranch,
            Stall_en,PCWrite_en,IF_IDWrite_en,Flush_en);
            

			      input isPause;
			      input isJumpOrBranch;
            
            output Stall_en;
            output PCWrite_en;
            output IF_IDWrite_en;
            output Flush_en;
                     
            reg reg1;
            reg reg2;
            reg reg3;
            reg reg4;
            
            
            
            assign Stall_en=reg1;
            assign PCWrite_en=reg2;
            assign IF_IDWrite_en=reg3;
            assign Flush_en=reg4;
            
            initial
              begin
                reg1<=0;
                reg2<=1;
                reg3<=1;
                reg4<=0;
              end            
            
            
            //Due to next control signal is 0, always@() part will be updated.
            always@(isPause or isJumpOrBranch)
              begin
                reg1<=0;
                reg2<=1;
                reg3<=1;
                reg4<=0;
				
				        if(isPause)
					          begin
                      reg1<=1;
                      reg2<=0;
                      reg3<=0;
                    end
               else if(isJumpOrBranch)
               					begin
                      reg1<=0;//NOTICE: jal jalr 
                      reg2<=1;//For flushing?
                      reg3<=1;
                      reg4<=1;
                    end
         			  end
            
endmodule



