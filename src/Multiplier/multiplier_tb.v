
//Test Bench for Multiplier Functional Unit
module MultiplierTB;

    reg clk, reset;
    wire [15:0] result;
    reg [7:0] x, y;
    wire ready;


//Data containing 0
reg [7:0] test0Data = 8'b00000000;

//Data containing 1
reg [7:0] test1Data =  8'b00000001;

//Data for testing left and right multiplication with identity (1)
//gives the data
reg [7:0] testLeftIdentity = 8'd67;
reg [7:0] testRightIdentity = 8'd96;

// Data for testing multiplying by 0 on lhs and rhs still gives 0
reg [7:0] testLHS0Data = 8'd37;
reg [7:0] testRHS0Data = 8'd96;


// Data for testing 2 regular numbers multiply correctly
reg [7:0] testRegularData1 = 8'd20;
reg [7:0] testRegularData2 = 8'd10;


reg [7:0] test2RegularData1 = 8'd255;
reg [7:0] test2RegularData2=  8'd255;

multiplier m1 (clk, reset, x, y, result, ready);  

initial begin
    clk = 0;
    reset = 0;
end

initial begin
    $monitor("time:%t\treset: %b\tready: %b\tresult: %d\nx: %d\ty: %d", $time, reset, ready, result, x, y);
end

initial begin
    #50 begin $display("Starting test 1"); reset = 1; x = testRegularData1; y = testRegularData2; end 
    #11 reset = 0;
    #70 begin $display("Starting test 2"); reset = 1; x = test2RegularData1; y = test2RegularData2; end
    #11 reset = 0;
    #200 begin $display("Starting test 3"); reset = 1; x = test0Data; y = test0Data; end //Test 0x0 == 0
    #11 reset = 0;
    #50 begin $display("Starting test 4"); reset = 1; x = testLHS0Data; y = test0Data; end //Test x*0 == 0
    #11 reset = 0;
    #50 begin $display("Starting test 5"); reset = 1; x = test0Data; y = testRHS0Data; end //Test 0*x == 0 
    #11 reset = 0;
    #50 begin $display("Starting test 6"); reset = 1; x = test1Data; y = testLeftIdentity; end //Test 1*x == x
    #11 reset = 0;
    #50 begin $display("Starting test 7"); reset = 1;x = testRightIdentity; y = test1Data; end //Test x*1 == x 
    #11 reset = 0;
    #80 $finish;
end

//Simulate Clock
always begin
    #5 clk = !clk;
end 

endmodule
