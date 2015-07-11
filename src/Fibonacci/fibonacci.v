//Circuit which generates Fibonacci numbers

module fibonacci  (
clk, //clock
reset, //reset the Multiplier
n, //Fibonacci number to calculate
result, //result of fibonacci calculation
ready //signals if the result is ready
);

//----Input Ports---
input clk;
input reset;
input [7:0] n;

//---Output Ports---
output reg [15:0] result;
output reg ready;

//---Internal Registers---
reg [15:0] last;
reg [7:0] no;
reg [7:0] count;


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
