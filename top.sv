module top (
    input  logic        clk, 
    input  logic        reset,
    output logic [31:0] WriteData, 
    output logic [31:0] DataAdr,
    output logic        MemWrite
);
    logic [31:0] ReadData;

    riscv core (
        .clk(clk), 
        .reset(reset),
        .Adr(DataAdr), 
        .WriteData(WriteData), 
        .MemWrite(MemWrite), 
        .ReadData(ReadData)
    );

    mem unified_memory (
        .clk(clk), 
        .we(MemWrite), 
        .a(DataAdr), 
        .wd(WriteData), 
        .rd(ReadData)
    );
endmodule