//////////////////////////////////////////////////////////////////////////////
// Simple Testbench for fifo1
// Developed by Emily Devlin for ECE 581, Winter 2022
//////////////////////////////////////////////////////////////////////////////

module top;

	parameter DSIZE = 8;
	parameter ASIZE = 10;

	// FIFO signals
	logic [DSIZE-1:0] rdata;
	logic [DSIZE-1:0] wdata_in;
	
	// Flags
	bit wfull, rempty, winc, rinc, wclk, rclk, wclk2x, wrst_n, rrst_n;	
	
	// Extra signals for testing
	int errorCount = 0;

	// Instantiate the FIFO
	fifo1_sram dut(.*);
	
	// Set up the monitor statements to display output
	initial begin
		$display("\n\nTestbench for FIFO1 module.\nEmily Devlin, ECE 581, Winter 2022\n");
		`ifdef DEBUG 
		$display("rdata\t\twdata_in\trinc\trrst_n\twinc\twrst_n\twfull\trempty\twdata\t\twaddr\trdata\t\traddr");
		$monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%d\t%b\t%d", rdata, wdata_in, rinc, rrst_n, winc, wrst_n, wfull, rempty, dut.fifomem.wdata, dut.fifomem.waddr, dut.fifomem.rdata, dut.fifomem.raddr);
		`endif
	end
	
	// Set up the asynchronous clocks
	initial begin
    	rclk = 0;
    	forever #7 rclk = !rclk;
	end
	initial begin
    	wclk = 0;
    	forever #10 wclk = !wclk;
	end
	initial begin
    	wclk2x = 0;
    	forever #5 wclk2x = !wclk2x;
	end
	// Enqueue takes the data to enqueue as an input argument.
	task enqueue(input int i);
		if (wfull) begin
			$display ("Error. Queue is full. Cannot enqueue.");
			errorCount++;
		end
		else begin
			wdata_in = i;
			winc = 1;
			wait (!wclk);
			wait (wclk);
			wait (!wclk);
			winc = 0;
		end
	endtask
	
	task dequeue;
		if(rempty) begin
			$display("Error. Queue is empty. Cannot dequeue.");
			errorCount++;
		end
		else begin
			rinc = 1;
			wait (!rclk);
			wait (rclk);
			rinc = 0;
		end
	endtask
	
	initial begin
		#15;
		wrst_n = 1;
		rrst_n = 1;
		#15;
		
		for (int i = 0; i < 2**ASIZE; i++) begin
			enqueue(i);
			#100;
		end
		
		// Queue Full Test: Should display an error message
		enqueue(500);
		#100;
		$display("We should have just seen an error message because the queue is full");

		for (int k = 0; k < 2**(ASIZE-DSIZE); k++) begin
			for (int j = 0; j < 2**DSIZE; j++) begin
				dequeue();
				#100;
				if (rdata != j) begin
					$display("Incorrect value dequeued. Expected: %0d. Actual: %0d", j, rdata);
					errorCount++;
				end
			end
		end
		
		// Queue Empty Test: Should display an error message
		dequeue();
		#100;
		$display("We should have just seen an error message because the queue is empty");	

		$display("\n\nEnd of FIFO Testbench. Emily Devlin, ECE 581, Winter 2022\n");
		if (errorCount == 2) 
			$display("Congratulations! The FIFO passed all tests.\n\n");
		else
			$display("FIFO ran with %0d errors.\n\n", errorCount-2);
		$finish;
	end

endmodule
