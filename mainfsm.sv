module mainfsm (
    input  logic       clk, reset,
    input  logic [6:0] op,
    output logic       Branch, PCUpdate, RegWrite, MemWrite, IRWrite, AdrSrc,
    output logic [1:0] ResultSrc, ALUSrcB, ALUSrcA, ALUOp
);
    typedef enum logic [3:0] {
        FETCH, DECODE, MEMADR, MEMREAD, MEMWB, MEMWRITE, EXECUTER, ALUWB, EXECUTEI, JAL, BEQ
    } statetype;

    statetype state, nextstate;

    always_ff @(posedge clk or posedge reset)
        if (reset) state <= FETCH;
        else       state <= nextstate;

    always_comb begin
        case (state)
            FETCH:    nextstate = DECODE;
            DECODE:   case (op)
                7'b0000011, 7'b0100011: nextstate = MEMADR;
                7'b0110011:             nextstate = EXECUTER;
                7'b0010011:             nextstate = EXECUTEI;
                7'b1101111:             nextstate = JAL;
                7'b1100011:             nextstate = BEQ;
                default:                nextstate = FETCH;
            endcase
            MEMADR:   nextstate = (op == 7'b0000011) ? MEMREAD : MEMWRITE;
            MEMREAD:  nextstate = MEMWB;
            EXECUTER, EXECUTEI, JAL: nextstate = ALUWB;
            default:  nextstate = FETCH;
        endcase
    end

    always_comb begin
        {Branch, PCUpdate, RegWrite, MemWrite, IRWrite, AdrSrc, ResultSrc, ALUSrcA, ALUSrcB, ALUOp} = 14'b0;
        
        case (state)
            FETCH:    begin AdrSrc=0; IRWrite=1; ALUSrcA=2'b00; ALUSrcB=2'b10; ALUOp=2'b00; ResultSrc=2'b10; PCUpdate=1; end
            DECODE:   begin ALUSrcA=2'b01; ALUSrcB=2'b01; ALUOp=2'b00; end
            MEMADR:   begin ALUSrcA=2'b10; ALUSrcB=2'b01; ALUOp=2'b00; end
            MEMREAD:  begin ResultSrc=2'b00; AdrSrc=1; end
            MEMWB:    begin ResultSrc=2'b01; RegWrite=1; end
            MEMWRITE: begin ResultSrc=2'b00; AdrSrc=1; MemWrite=1; end
            EXECUTER: begin ALUSrcA=2'b10; ALUSrcB=2'b00; ALUOp=2'b10; end
            EXECUTEI: begin ALUSrcA=2'b10; ALUSrcB=2'b01; ALUOp=2'b10; end
            ALUWB:    begin ResultSrc=2'b00; RegWrite=1; end
            JAL:      begin ALUSrcA=2'b01; ALUSrcB=2'b10; ALUOp=2'b00; ResultSrc=2'b00; PCUpdate=1; end
            BEQ:      begin ALUSrcA=2'b10; ALUSrcB=2'b00; ALUOp=2'b01; ResultSrc=2'b00; Branch=1; end
        endcase
    end
endmodule