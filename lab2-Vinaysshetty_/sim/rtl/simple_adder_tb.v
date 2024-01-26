`timescale 1ns/1ns
module top();

reg a, b ,cin,reset;
reg clock=1'b0;
wire sum;
wire cout;

simple_adder adder(a, b, cin, sum , cout, clock, reset );

always #5 clock = ~clock;

initial begin
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b1;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b1;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;

#4 a = 1'b0; b = 1'b0; cin = 1'b1; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b1; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b1; reset = 1'b0;

#4 a = 1'b0; b = 1'b1; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b1; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b1; cin = 1'b0; reset = 1'b0;

#4 a = 1'b0; b = 1'b1; cin = 1'b1; reset = 1'b0;
#4 a = 1'b0; b = 1'b1; cin = 1'b1; reset = 1'b0;
#4 a = 1'b0; b = 1'b1; cin = 1'b1; reset = 1'b0;

#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;

#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;

#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b1; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b1; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b1; b = 1'b0; cin = 1'b0; reset = 1'b0;

#4 a = 1'b1; b = 1'b0; cin = 1'b1; reset = 1'b0;
#4 a = 1'b1; b = 1'b0; cin = 1'b1; reset = 1'b0;
#4 a = 1'b1; b = 1'b0; cin = 1'b1; reset = 1'b0;

#4 a = 1'b1; b = 1'b1; cin = 1'b0; reset = 1'b0;
#4 a = 1'b1; b = 1'b1; cin = 1'b0; reset = 1'b0;
#4 a = 1'b1; b = 1'b1; cin = 1'b0; reset = 1'b0;

#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b0;
#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b0;
#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b0;

#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;
#4 a = 1'b0; b = 1'b0; cin = 1'b0; reset = 1'b0;


#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b1;
#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b1;
#4 a = 1'b1; b = 1'b1; cin = 1'b1; reset = 1'b1;

#20 $stop;
end


initial begin
 $monitor("t=%3d a=%d,b=%d,cin=%d,reset=%d,sum=%d,cout=%d \n",$time,a,b,cin,reset,sum,cout);
end



endmodule
