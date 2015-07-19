//Test Bench for Register File

`define N 16
`define K 4
module regfile_tb;

    reg clk;
    wire [`N-1:0] a,b;
    reg [`N-1:0] x;
    reg [`K-1:0] sa, sb, d;
    reg ld;


regfile #(.n(`N), .k(`K)) r1 (clk, x, ld, d, sa, sb, a, b);  

initial begin
    clk = 0;
end

initial begin
    $monitor("time:%t\tld: %b\tsa: %d\tsb: %d\td %d\tx: %d\ta: %d\tb: %d", $time, ld, sa, sb, d, x, a, b);
end

initial begin
    // Load 10 into register 2
    #0 begin 
            $display("\nStarting test 1"); 
            ld = 1;
            x = 16'd10;
            d = 3; 
            sa = 3; 
            sb = 3;
            end
    // Retrieve 10 from register 2
    #2 begin
            $display("Reading register");
            ld = 0;
            x = 0;
            d = 3;
            sa = 3;//4'b0010;
            sb = 3;//4'b0010;
       end

    #2 begin
            $display("Writing + Reading");
            ld = 1;
            x = 16'd15;
            d = 1;
            sa = 3;
            sb = 3;
       end

   #2 begin
            $display("Reading both registers");
            ld = 0;
            x = 0;
            d = 0;
            sa = 1;
            sb = 3;
     end
   #2 begin
            $display("Read again");
            ld = 0;
            x = 0;
            d = 0;
            sa = 1;
            sb = 3;
      end 
   #4 $finish;
end

//Simulate Clock
always begin
    #1 clk = !clk;
end 

endmodule
