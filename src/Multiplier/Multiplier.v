//Multiplier Functional Unit which multiplies 2 numbers


module Multiplier (
clk, //clock
reset, //reset the Multiplier
x, //First Number to be multiplied 
y, //Second Number to be multiplied
prod, //result of multiplication
ready //signals if the result is ready
);

//----Input Ports---
input clk;
input reset;
input [7:0] x;
input [7:0] y;

//---Output Ports--
output reg [15:0] prod;
output reg ready;

//--Internal Data--
reg [7:0] rx;
reg [15:0] ry;

always @(posedge clk) begin
     
    if (reset) begin
        rx <= x;
        ry <= 15'b0 + y;
        prod <= 15'b0;

    end else begin

        rx <= rx >> 1;
        ry <= ry << 1;
        // If LSB of rx is 1 then "multiply" otherwise no change
        if (rx & 8'b1) begin
            prod <= prod;
        end else begin 
            prod <= prod + ry;
        end

    end
    // When one result reaches 0 nothing left to multiply
    ready <= !rx || !ry;
end

endmodule
