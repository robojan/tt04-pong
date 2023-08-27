`default_nettype none
`timescale 1ns/1ps

module tb ();
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    // wire up inputs and outputs. Use reg for inputs that will be driven by the testbench.
    reg  clk;
    reg  rst_n;
    reg  ena;

    reg  p1_btn_left, p1_btn_right, p1_btn_select;
    reg  p2_btn_left, p2_btn_right, p2_btn_select;
    reg  [7:0] uio_in;

    wire hsync, vsync;
    wire vga_r1, vga_r0;
    wire [1:0] vga_g;
    wire [1:0] vga_b;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    wire sound = uio_out[3];
    wire vblank = uio_out[2];
    wire hblank = uio_out[1];


    tt_um_robojan_top tt_um_robojan_top (
`ifdef GL_TEST
        .VPWR       (1'b1),     // Power supply
        .VGND       (1'b0),     // Ground
`endif
        .ui_in      ({p1_btn_select, p1_btn_right, p1_btn_left, p2_btn_select, p2_btn_right, p2_btn_left, 1'b0, 1'b0}),    // Dedicated inputs
        .uo_out     ({vga_b, vga_g, vga_r1, vga_r0, vsync, hsync}),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
    );

endmodule
