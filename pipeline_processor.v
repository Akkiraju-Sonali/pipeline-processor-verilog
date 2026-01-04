`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.01.2026 13:55:28
// Design Name: 
// Module Name: pipeline_processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_processor (
    input clk,
    input reset
);

    // Instruction Memory (16 x 16)
    reg [15:0] instr_mem [0:15];

    // Register File (16 registers)
    reg [15:0] reg_file [0:15];

    // Data Memory
    reg [15:0] data_mem [0:15];

    // Program Counter
    reg [3:0] PC;

    // Pipeline Registers
    reg [15:0] IF_ID_IR;
    reg [15:0] ID_EX_IR;
    reg [15:0] EX_MEM_ALU;
    reg [3:0]  EX_MEM_RD;
    reg [15:0] MEM_WB_DATA;
    reg [3:0]  MEM_WB_RD;

    // Instruction fields
    wire [3:0] opcode = ID_EX_IR[15:12];
    wire [3:0] rs     = ID_EX_IR[11:8];
    wire [3:0] rt     = ID_EX_IR[7:4];
    wire [3:0] rd     = ID_EX_IR[3:0];

    integer i;

    // ---------------- INITIALIZATION (for simulation) ----------------
    initial begin
        PC = 0;

        for (i = 0; i < 16; i = i + 1) begin
            reg_file[i] = i;      // R0=0, R1=1, ...
            data_mem[i] = i * 2;  // Sample data
            instr_mem[i] = 16'b0;
        end

        // Instructions
        // opcode rs rt rd
        instr_mem[0] = 16'b0000_0001_0010_0011; // ADD R1,R2 -> R3
        instr_mem[1] = 16'b0001_0011_0001_0100; // SUB R3,R1 -> R4
        instr_mem[2] = 16'b0010_0000_0010_0101; // LOAD mem[2] -> R5
    end

    // ---------------- IF STAGE ----------------
    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
        end else begin
            IF_ID_IR <= instr_mem[PC];
            PC <= PC + 1;
        end
    end

    // ---------------- ID STAGE ----------------
    always @(posedge clk) begin
        ID_EX_IR <= IF_ID_IR;
    end

    // ---------------- EX STAGE ----------------
    always @(posedge clk) begin
        case (opcode)
            4'b0000: EX_MEM_ALU <= reg_file[rs] + reg_file[rt]; // ADD
            4'b0001: EX_MEM_ALU <= reg_file[rs] - reg_file[rt]; // SUB
            4'b0010: EX_MEM_ALU <= data_mem[rt];                // LOAD
            default: EX_MEM_ALU <= 0;
        endcase
        EX_MEM_RD <= rd;
    end

    // ---------------- MEM / WB STAGE ----------------
    always @(posedge clk) begin
        MEM_WB_DATA <= EX_MEM_ALU;
        MEM_WB_RD   <= EX_MEM_RD;
        reg_file[MEM_WB_RD] <= MEM_WB_DATA;
    end

endmodule
