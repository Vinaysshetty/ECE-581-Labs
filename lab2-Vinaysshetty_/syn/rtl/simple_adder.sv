// DIC-I

module simple_adder (a, b, cin, sum, cout, clock, reset);

input a, b, cin, clock, reset; 

output sum, cout;

wire  a_reg;

wire  b_reg;

wire  cin_reg;

wire  sum_gen;
wire  cout_gen;

dff dff_a (

	.d (a),
 	.clk (clock),
	.reset (reset),
	.q (a_reg)
	);

dff dff_b (

	.d (b),
 	.clk (clock),
	.reset (reset),
	.q (b_reg)

	);

dff dff_cin (

	.d (cin),
 	.clk (clock),
	.reset (reset),
	.q (cin_reg)

	);

// SUM = a xor b xor cin
assign sum_gen = a_reg ^ b_reg ^ cin_reg;
assign cout_gen = (a_reg &b_reg) | (b_reg&cin_reg) | (cin_reg&a_reg);

dff dff_cout (

	.d (cout_gen),
 	.clk (clock),
	.reset (reset),
	.q (cout)

	);

dff dff_sum (

	.d (sum_gen),
 	.clk (clock),
	.reset (reset),
	.q (sum)

	);
endmodule

// dff definition

module dff (d, clk, reset, q);
input d, clk, reset;
output q;
reg q;
always @ (posedge clk or posedge reset) begin
 if (reset) begin
 q <= 0;
 end
 else begin
 q <= d;
 end
end

endmodule 
