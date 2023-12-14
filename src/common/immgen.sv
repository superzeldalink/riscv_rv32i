// This version was implemented based on software interface
module immgen (
  //_v1(
  input  [31:7] instr  ,
  input  [ 4:0] imm_sel,
  output reg [31:0] imm
);

  logic [31:11] signxt;

  always_comb begin
    if (instr[31])
      signxt = {21{1'b1}};
    else
      signxt = 0;

    if(imm_sel[0])                                                    // I-type
      imm = {signxt[31:11],instr[30:20]};
    else if (imm_sel[1])                                              // S-type
      imm = {signxt[31:11],instr[30:25],instr[11:7]};
    else if (imm_sel[2])                                              // B-type
      imm = {signxt[31:12],instr[7],instr[30:25],instr[11:8],1'b0};
    else if(imm_sel[3])                                               // U-type
      imm = {instr[31:12],12'h0};
    else if (imm_sel[4])                                              // J-type
      imm = {signxt[31:20],instr[19:12],instr[20],instr[30:21],1'b0};
    else
      imm = 32'd0;
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//This version follows the implemetation of Lecture CS61CC from Berkely - University of California/////////////////////////////////////////////
//Remove or toggle "//" after "module immgen" for change version of immgen/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// module immgen//_v2
// (
// input		logic	[31:0]	instr,
// input		logic	[4:0]		imm_sel,
// output	logic	[31:0]	imm);


// logic 	[31:0]	Itype, Stype, Btype, Jtype, Utype , signxt;
// logic    			Ictrl, Sctrl, Bctrl, Jctrl, Uctrl;

// // Seperate selector
// assign {Jctrl, Uctrl, Bctrl, Sctrl, Ictrl} = imm_sel[4:0];

// //Implement a sign expansion
// assign signxt = instr[31]? 32'hffffffff: 0;

// //Format I type value
// assign Itype = {signxt[31:11],instr[30:20]};

// //Format S type value
// assign Stype = (Sctrl|Bctrl)? {Itype[31:5],instr[11:7]}: {Itype};

// //Format B type value
// assign Btype[31:1] = Bctrl? {Stype[31:12],instr[7],Stype[10:1]}: {Stype[31:1]};
// assign Btype[0] = (Jctrl|Bctrl)? 0: Stype[0];

// //Format J type value
// assign Jtype[0] = Btype[0];
// assign Jtype[31:1] = Jctrl? {Btype[31:20],instr[19:12],instr[20],Btype[10:1]}: {Btype[31:1]};

// //Format U type value
// assign Utype = Uctrl? {instr[31:12],12'd0}: Jtype;

// //Whether there is no selected choose 0 to be the value
// assign imm = (~(Ictrl|Sctrl|Bctrl|Uctrl|Jctrl))? 0: Utype;



// endmodule
