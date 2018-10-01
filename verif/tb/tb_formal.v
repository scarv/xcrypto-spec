//
// SCARV Project
// 
// University of Bristol
// 
// RISC-V Cryptographic Instruction Set Extension
// 
// Reference Implementation
// 
// 

`include "fml_common.vh"

//
// module: tb_formal
//
//  Top level testbench for the formal verification flow.
//
module tb_formal (

//
// Clock and reset interface

input  wire             g_clk           , // Global clock
input  wire             g_resetn        , // Synchronous active low reset.

//
// CPU / COP Interface
input  wire             cpu_insn_req    , // Instruction request
input  wire             cpu_abort_req   , // Abort Instruction
input  wire [31:0]      cpu_insn_enc    , // Encoded instruction data
input  wire [31:0]      cpu_rs1         , // RS1 source data

input  wire             cpu_insn_ack    , // Instruction finish acknowledge

//
// Memory Interface
input  wire [31:0]      cop_mem_rdata   , // Memory read data
input  wire             cop_mem_stall   , // Stall
input  wire             cop_mem_error     // Error


);

// ----------------------------------------------------------------------
//
//  Top level constraints on inputs.
//
//

//
// Assume reset at the start of the trace and that there is only one
// reset event.
//
initial assume(g_resetn == 1'b0);

// No requests during a reset
always @(posedge g_clk) if(!g_resetn) begin
    assume(!cpu_insn_req);
    assume(!cop_mem_stall);
    assume(!cop_mem_error);
end

//
// Assume that the instruction request interface will behave correctly
//
always @(posedge g_clk) if(!g_resetn) begin
    if        ($past(!cpu_insn_req && !cop_insn_ack)) begin
        
        // Require nothing

    end else if($past(cpu_insn_req && !cop_insn_ack)) begin
        
        assume(cpu_insn_req);
        assume($past(cpu_insn_enc) == cpu_insn_enc);
        assume($past(cpu_rs1     ) == cpu_rs1     );

    end else if($past( cpu_insn_req &&  cop_insn_ack)) begin

        // Require nothing
    
    end else if($past(!cpu_insn_req && !cop_insn_ack)) begin
        
        // Require nothing

    end
end

// ----------------------------------------------------------------------

wire        g_clk_req       ; // Clock request
wire        cop_insn_ack    ; // Instruction request acknowledge

wire [31:0] cop_random      ; // The most recent random sample
wire        cop_rand_sample ; // cop_random valid when this high.

wire        cop_wen         ; // COP write enable
wire [ 4:0] cop_waddr       ; // COP destination register address
wire [31:0] cop_wdata       ; // COP write data
wire [ 2:0] cop_result      ; // COP execution result
wire        cop_insn_rsp    ; // COP instruction finished

wire        cop_mem_cen     ; // Chip enable
wire        cop_mem_wen     ; // write enable
wire [31:0] cop_mem_addr    ; // Read/write address (word aligned)
wire [31:0] cop_mem_wdata   ; // Memory write data
wire [ 3:0] cop_mem_ben     ; // Write Byte enable

// ----------------------------------------------------------------------
//
// Transaction capture
//

reg [ 0:0] vtx_reset                ;
reg [ 0:0] vtx_valid                ;
reg [31:0] vtx_instr_enc    [1:0]   ;
reg [31:0] vtx_instr_rs1    [1:0]   ;
reg [ 2:0] vtx_instr_result         ;
reg [31:0] vtx_instr_wdata          ;
reg [ 4:0] vtx_instr_waddr          ;
reg [ 0:0] vtx_instr_wen            ;

wire[31:0] vtx_cprs_snoop   [15:0]  ;
reg [31:0] vtx_cprs_pre     [15:0]  ;
reg [31:0] vtx_cprs_post    [15:0]  ;

genvar i;

always @(posedge g_clk) vtx_reset <= g_resetn;

initial assume(vtx_valid == 0);


//
// Capture input instructions to the COP
//
always @(posedge g_clk) if(!g_resetn) begin
end else if(g_resetn && cpu_insn_req && cop_insn_ack) begin
    vtx_instr_enc[0]    <= cpu_insn_enc;
    vtx_instr_rs1[0]    <= cpu_rs1;
end

//
// Capture COP instruction results.
//
always @(posedge g_clk) if(
    g_resetn && cop_insn_rsp && cpu_insn_ack
) begin
    vtx_valid           <= 1'b1             ;
    vtx_instr_enc[1]    <= vtx_instr_enc[0] ;
    vtx_instr_rs1[1]    <= vtx_instr_rs1[0] ;
    vtx_instr_result    <= cop_result       ;
    vtx_instr_wdata     <= cop_wdata        ;
    vtx_instr_waddr     <= cop_waddr        ;
    vtx_instr_wen       <= cop_wen          ;
end else begin
    vtx_valid           <= 1'b0             ;
end

// ----------------------------------------------------------------------

//
// Checker Instance
//
`FML_CHECK_NAME i_fml_checks(
.vtx_clk         (g_clk           ),
.vtx_reset       (vtx_reset       ),
`VTX_REGISTER_PORTS_CON(vtx_cprs_pre , vtx_cprs_pre )
`VTX_REGISTER_PORTS_CON(vtx_cprs_post, vtx_cprs_post)
.vtx_valid       (vtx_valid       ),
.vtx_instr_enc   (vtx_instr_enc[1]),
.vtx_instr_rs1   (vtx_instr_rs1[1]),
.vtx_instr_result(vtx_instr_result),
.vtx_instr_wdata (vtx_instr_wdata ),
.vtx_instr_waddr (vtx_instr_waddr ),
.vtx_instr_wen   (vtx_instr_wen   ) 
);


//
// DUT Instance
//
scarv_cop_top i_dut(
.g_clk         (g_clk        ) , // Global clock
.g_clk_req     (g_clk_req    ) , // Clock request
.g_resetn      (g_resetn     ) , // Synchronous active low reset.
`VTX_REGISTER_PORTS_CON(cprs_snoop, vtx_cprs_snoop)
.cpu_insn_req  (cpu_insn_req ) , // Instruction request
.cop_insn_ack  (cop_insn_ack ) , // Instruction request acknowledge
.cpu_abort_req (cpu_abort_req) , // Abort Instruction
.cpu_insn_enc  (cpu_insn_enc ) , // Encoded instruction data
.cpu_rs1       (cpu_rs1      ) , // RS1 source data
.cop_wen       (cop_wen      ) , // COP write enable
.cop_waddr     (cop_waddr    ) , // COP destination register address
.cop_wdata     (cop_wdata    ) , // COP write data
.cop_result    (cop_result   ) , // COP execution result
.cop_insn_rsp  (cop_insn_rsp ) , // COP instruction finished
.cpu_insn_ack  (cpu_insn_ack ) , // Instruction finish acknowledge
.cop_random      (cop_random      ), // Latest random sample value
.cop_rand_sample (cop_rand_sample ), // random sample value valid
.cop_mem_cen   (cop_mem_cen  ) , // Chip enable
.cop_mem_wen   (cop_mem_wen  ) , // write enable
.cop_mem_addr  (cop_mem_addr ) , // Read/write address (word aligned)
.cop_mem_wdata (cop_mem_wdata) , // Memory write data
.cop_mem_rdata (cop_mem_rdata) , // Memory read data
.cop_mem_ben   (cop_mem_ben  ) , // Write Byte enable
.cop_mem_stall (cop_mem_stall) , // Stall
.cop_mem_error (cop_mem_error)   // Error
);

//
// Capture CPR values pre each instruction
//
generate for(i=0; i < 16; i = i + 1) begin
    always @(posedge g_clk) if(!g_resetn) begin
        vtx_cprs_pre[i] <= 0;
    end else if(cpu_insn_req && cop_insn_ack) begin
        vtx_cprs_pre[i] <= vtx_cprs_snoop[i];
    end
end endgenerate

//
// Capture CPR values post each instruction
//
generate for(i=0; i < 16; i = i + 1) begin
    always @(posedge g_clk) if(!g_resetn) begin
        vtx_cprs_post[i] <= 0;
    end else if(cop_insn_rsp && cpu_insn_ack) begin
        vtx_cprs_post[i] <= vtx_cprs_snoop[i];
    end
end endgenerate

endmodule


