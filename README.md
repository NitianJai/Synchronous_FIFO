# Synchronous_FIFO
A Synchronous FIFO (First-In, First-Out) is a type of memory buffer used in digital systems to store data temporarily as it moves from one place to another. The "synchronous" part means that both reading and writing operations happen based on the same clock signal.

1. FIFO Behavior

Data enters (write) on one side and exits (read) on the other.
The order is preserved: the first data written is the first to be read.

2. Synchronous Operation

Both write and read operations are controlled by the same clock.
Simpler control logic compared to asynchronous FIFOs (which use two clocks).

3. Control Signals

Common signals in a synchronous FIFO include:

clk: Common clock signal.
rst: Reset to initialize pointers and flags.
wr_en: Write enable signal.
rd_en: Read enable signal.
full: Indicates FIFO cannot accept more data.
empty: Indicates FIFO has no data to read.
data_in: Data to be written.
data_out: Data to be read.

4. Internal Pointers

Write pointer (wr_ptr) and read pointer (rd_ptr) are used to track where data is written or read.
Pointers typically increment on wr_en or rd_en respectively.
Flags (full, empty) are updated based on the relationship between the two pointers.

