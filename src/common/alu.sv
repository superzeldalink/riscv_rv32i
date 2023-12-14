// verilator lint_off DECLFILENAME
module addsub (
  input  [31:0] inA         ,
  input  [31:0] inB         ,
  input         neg_sel     ,
  input         unsigned_sel,
  output [31:0] result      ,
  output        less_than   ,
  output        equal
);

  wire [32:0] extendedA, extendedB;
  assign extendedA = unsigned_sel ? {1'b0, inA} : {1'(inA[31]), inA};
  assign extendedB = unsigned_sel ? {1'b0, inB} : {1'(inB[31]), inB};

  wire [32:0] newB;
  assign newB = neg_sel ? (~extendedB + 1'b1) : extendedB;

  assign {less_than, result} = extendedA + newB;

  assign equal = (result == 32'd0);
endmodule
// verilator lint_on DECLFILENAME

module alu (
  input      [31:0] inA ,
  input      [31:0] inB ,
  input      [ 3:0] sel ,
  output reg [31:0] data
);

  wire [31:0] addsub_result;
  wire        less_than    ;

  addsub addsubcomp (
    .inA         (inA            ),
    .inB         (inB            ),
    .neg_sel     (sel[3] | sel[1]),
    .unsigned_sel(sel[0]         ),
    .result      (addsub_result  ),
    .less_than   (less_than      ),
    .equal       (               )
  );

  wire [31:0] AxorB, AorB, AandB, AsllB, AsrlB, AsraB;
  assign AxorB = inA ^ inB;
  assign AorB  = inA | inB;
  assign AandB = inA & inB;
  assign AsllB = inA << inB[4:0];
  assign AsrlB = inA >> inB[4:0];
  // assign AsraB = $signed(inA) >>> inB[4:0];
  assign AsraB = (inA >> inB[4:0]) | ~(32'hFFFFFFFF >> (inA[31] ? inB[4:0] : 0));

  always_comb begin
    case (sel)
      4'b0000 : data =  addsub_result;
      4'b1000 : data =  addsub_result;
      4'b0010 : data = {31'd0, less_than};
      4'b0011 : data = {31'd0, less_than};
      4'b0100 : data = AxorB;
      4'b0110 : data = AorB;
      4'b0111 : data = AandB;
      4'b0001 : data = AsllB;
      4'b0101 : data = AsrlB;
      4'b1001 : data = inB;
      4'b1101 : data = AsraB;
      // 4'b1111 : data = inA * inB;
      default : data = 0;
    endcase
  end
endmodule
