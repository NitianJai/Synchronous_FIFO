module sync_fifo_tb();

  parameter DATA_WIDTH = 8;
  parameter DEPTH = 16;
  parameter ADDR_WIDTH = 4;

  // Testbench signals
  reg clk;
  reg reset;
  reg wr_en;
  reg rd_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire full;
  wire empty;

  // Instantiate the FIFO
  sync_fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) uut (
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock generation
  always #5 clk = ~clk;  // 100MHz clock

  initial begin

    // VCD dump setup for GTKWave
    $dumpfile("sync_fifo_tb.vcd");
    $dumpvars(0, sync_fifo_tb);
    
    // Initialize signals
    clk = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    // Reset the FIFO
    #10 reset = 0;

    // Write data to FIFO
    repeat(10) begin
      @(posedge clk);
      wr_en = 1;
      data_in = $random % 256;
    end

    @(posedge clk);
    wr_en = 0;

    // Read data from FIFO
    repeat(10) begin
      @(posedge clk);
      rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    // Final delay and finish
    #20;
    $finish;
  end

endmodule