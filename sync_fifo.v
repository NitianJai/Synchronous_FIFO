 module sync_fifo #(
 parameter DATA_WIDTH = 8,
 parameter DEPTH = 16,
 parameter ADDR_WIDTH = 4
 )(
 input clk,
 input reset,
 input wr_en,
  input rd_en,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out,
  output reg full,
  output reg empty
 );
  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  reg [ADDR_WIDTH-1:0] wr_ptr = 0, rd_ptr = 0;
  reg [ADDR_WIDTH:0] count = 0;
  always @(posedge clk) begin
    if(reset) begin
      wr_ptr <= 0; rd_ptr <= 0; count <= 0;
      full <= 0; empty <= 1;
    end else begin
      // Write operation
      if(wr_en && !full) begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
        count <= count + 1;
      end
      // Read operation
      if(rd_en && !empty) begin
        data_out <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
        count <= count - 1;
      end
      // Update status flags
      full <= (count == DEPTH);
      empty <= (count == 0);
    end
  end
 endmodule