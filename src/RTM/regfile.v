//Register File
module regfile (
clk, // Clock
x, //External Input
ld, //Whether or not to load destination register from extenral input
d, //Destination register
sa, //1st Source Register
sb, // 2nd Source Register
a, // Output a
b // Output b
);

parameter n = 16; //n bits per register
parameter k = 4; //2^k registers

//--- Input Ports ---
input clk;
input [n-1:0] x;
input ld;
input [k-1:0] d, sa, sb;

//--- Output Ports ---
output wire [n - 1:0] a, b;


//-- Internal Data ---
wire [n - 1:0] a0, a1, b0, b1;

wire ld0, ld1;

generate
    // Base case of 2 regfiles left
    if (k == 1) begin
        regfile1 #(.n(n)) rfile1A(clk, x, ld0, a0, b0); 
        regfile1 #(.n(n)) rfile1B(clk, x, ld1, a1, b1); 
    // 2^k bit regfile    
    end else begin
        regfile #(.k(k-1), .n(n)) rFileA(clk, x, ld0, d[k-2:0], sa[k-2:0], sb[k-2:0], a0, b0);
        regfile #(.k(k-1), .n(n)) rFileB(clk, x, ld1, d[k-2:0], sa[k-2:0], sb[k-2:0], a1, b1);
    end
endgenerate 

function [n-1:0] mux1w;
    input v;
    input  [n-1:0]x1;
    input  [n-1:0]x2;
    begin
    if (v) begin 
        mux1w = x2;
        
    end else begin
       mux1w = x1;
    end
    end
endfunction


assign ld0 = (!d[k-1]) & ld;
assign ld1 = d[k-1] & ld;
assign a = mux1w(sa[k-1], a0, a1);
assign b = mux1w(sb[k-1], b0, b1);

endmodule



module regfile1 (
clk, // Clock
x, //External Input
ld, //Whether or not to load destination register from external input
r, // Output a
r // Output b
);

parameter n = 16; //n bit register

//--- Inputs ---
input clk;
input [n - 1: 0] x;
input ld;

//--- Outputs ---
output reg [n-1:0] r;

always @(posedge clk) begin
   if (ld) begin
       r <= x;
   end else begin
       r <= r;
   end     
end


endmodule

