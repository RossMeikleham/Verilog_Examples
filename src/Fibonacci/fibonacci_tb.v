//Fibonacci Test Bench

//Test Bench for Multiplier Functional Unit
module FibonacciTB;

    reg clk, reset;
    wire [15:0] result;
    reg [7:0] n;
    wire ready;


//Data containing 0
reg [7:0] test0Data = 8'b0;

//Data containing 1
reg [7:0] test1Data =  8'b1;

// Test regular fibonacci number
reg [7:0] testOrdinary = 8'd6;

//Test overflow number
reg [7:0] testOverflow = 8'd25;

fibonacci f1 (clk, reset, n, result, ready);  

initial begin
    clk = 0;
    reset = 0;
end

initial begin
//    $monitor("time:%t\treset: %b\tready: %b\tresult: %d\nn: %d",$time, reset, ready, result, n);
end

initial begin
    #50 begin $display("Starting test 1"); reset = 1; n = testOrdinary; end 
    #11 reset = 0;
    #90 begin $display("Starting test 2"); reset = 1; n = test0Data; end //Test fib(0) == 0
    #11 reset = 0;
    #50 begin $display("Starting test 3"); reset = 1; n = test1Data; end //Test fib(1) == 1
    #11 reset = 0;
    #50 begin $display("Starting test 4"); reset = 1; n = testOverflow; end //Test overflowing
    #11 reset = 0;
    #300 $finish;
end

//Simulate Clock
always begin
    #5 clk = !clk;
end 

endmodule
