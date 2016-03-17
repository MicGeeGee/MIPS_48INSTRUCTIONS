module SignEXUnit(imme,imme_ex,isSigned);
  input[15:0] imme;
  input isSigned;
  output[31:0] imme_ex;
  
  assign imme_ex=isSigned?{{16{imme[15]}},imme}:{16'b0,imme};
  
endmodule
//has been reformed.