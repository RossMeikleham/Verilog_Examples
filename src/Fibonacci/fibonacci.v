//Circuit which generates Fibonacci numbers

module fibonacci  (
clk, //clock
reset, //reset the Multiplier
n, //Fibonacci number to calculate
result, //result of fibonacci calculation
ready //signals if the result is ready
);

parameter inBits = 8; //No of bits for n 
parameter outBits = 16; //No of bits of Fib number

//----Input Ports---
input clk;
input reset;
input [inBits-1:0] n;

//---Output Ports---
output reg [outBits-1:0] result;
output reg ready;

//---Internal Registers---
reg [outBits-1:0] last;
reg [inBits-1:0] no;
reg [inBits-1:0] count;


always @(posedge clk) begin
    if (reset) begin
        result <= 16'b0;
        last <= 16'b0;
        no  <= n;
        count <= 16'b0; 
    //0th fibonacci number is 0, need to generate 1 afterwards
    end else begin
        if (result == 0 && !ready) begin
            result <= 1;            
        end else if (ready) begin
            result <= result;
        end else begin 
            result <= result + last;
        end
        last <= result;
        count <= count + 1;
    end
        ready <= count >= no;
        $display("reset %b, count %d, result %d, ready %b, no %d, last %d",reset, count, result, ready, no, last);
end


endmodule
