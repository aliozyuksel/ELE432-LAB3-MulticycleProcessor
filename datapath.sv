module datapath (
    input  logic        clk, reset,
    input  logic        PCWrite, AdrSrc, IRWrite, RegWrite,
    input  logic [1:0]  ResultSrc, ALUSrcA, ALUSrcB, ImmSrc,
    input  logic [2:0]  ALUControl,
    output logic        Zero,
    output logic [31:0] Instr, Adr, WriteData,
    input  logic [31:0] ReadData
);
    logic [31:0] PC, OldPC, A, B, Data, RD1, RD2, ImmExt, SrcA, SrcB, ALUResult, ALUOut, Result;

    flopenr #(32) pcreg(clk, reset, PCWrite, Result, PC);
    mux2    #(32) adrmux(PC, ALUOut, AdrSrc, Adr);

    flopenr #(32) instr_reg(clk, reset, IRWrite, ReadData, Instr);
    flopenr #(32) oldpc_reg(clk, reset, IRWrite, PC, OldPC);
    flopr   #(32) data_reg(clk, reset, ReadData, Data);

    regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, RD1, RD2);
    extend  ext(Instr[31:7], ImmSrc, ImmExt);

    flopr   #(32) regA(clk, reset, RD1, A);
    flopr   #(32) regB(clk, reset, RD2, B);
    assign WriteData = B;

    mux3    #(32) srcAmux(PC, OldPC, A, ALUSrcA, SrcA);
    mux3    #(32) srcBmux(B, ImmExt, 32'd4, ALUSrcB, SrcB);

    alu     core_alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
    flopr   #(32) aluout_reg(clk, reset, ALUResult, ALUOut);

    mux3    #(32) resmux(ALUOut, Data, ALUResult, ResultSrc, Result);

endmodule