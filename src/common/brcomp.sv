//Bit comparator module
// verilator lint_off DECLFILENAME
// module bitcomp (
//   input  logic in_less, in_equal,
//   rs1_data, rs2_data,
//   output logic out_less, out_equal
// );

//   assign out_equal = in_equal & (rs1_data ~^ rs2_data);
//   assign out_less  = in_less | ( in_equal & (~rs1_data) & rs2_data);
// endmodule
// // verilator lint_on DECLFILENAME

// //Comparator module
// module regcomp (
//   input  logic [31:0] rs1_data, rs2_data,
//   output logic        out_less, out_equal
// );

//   logic [32:0] less, equal;

//   assign less[32]  = 0;
//   assign equal[32] = 1;
//   assign out_less  = less[0];
//   assign out_equal = equal[0];

//   genvar i;
//   generate
//     for (i=0; i<32; i=i+1) begin:bit_comp
//       bitcomp 	bit_comparator	(less[i+1], equal[i+1], rs1_data[i], rs2_data[i], less[i], equal[i]);
//     end
//   endgenerate

// endmodule
// //Top-level module
// module brcomp (
//   input  logic [31:0] rs1_data, rs2_data,
//   input  logic        br_unsigned,
//   output logic        br_less, br_equal
// );

//   logic [ 1:0] less_ctrl;
//   logic        out_less ;
//   logic [31:0] data_r1, data_r2;

// // Condition when rs1 pos and rs2 neg
//   assign less_ctrl[0] = rs1_data[31] & (~rs2_data[31]) & (~br_unsigned);
// // Condition when rs1 neg and rs2 neg
//   assign less_ctrl[1] = rs1_data[31] & rs2_data[31] & (~br_unsigned);
//   assign br_less      = (((less_ctrl[1]&(~br_equal))? 	~out_less:out_less)|less_ctrl[0])&(~(~rs1_data[31] & rs2_data[31]& (~br_unsigned))); // out_less is negitated when compare two neg value
// //Convert 2's comp to absolute value
//   assign data_r1 = rs1_data[31] & (~br_unsigned)? ~rs1_data+1: rs1_data;
//   assign data_r2 = rs2_data[31] & (~br_unsigned)? ~rs2_data+1: rs2_data;

// //Comparator module 32 bit
//   regcomp comparator (data_r1,data_r2,out_less,br_equal);
// endmodule

// BrComp using sub
module brcomp (
  input  logic [31:0] rs1_data, rs2_data,
  input  logic        br_unsigned,
  output logic        br_less, br_equal
);

  addsub addsubcomp (
    .inA         (rs1_data   ),
    .inB         (rs2_data   ),
    .neg_sel     (1'b1       ),
    .unsigned_sel(br_unsigned),
    .result      (           ),
    .less_than   (br_less    ),
    .equal       (br_equal   )
  );

endmodule
