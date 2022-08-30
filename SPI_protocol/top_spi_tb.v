`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2022 12:39:04
// Design Name: 
// Module Name: top_spi_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SPI_master_slave_tb;
  reg [7:0] m_in,slv0_i,slv1_i,slv2_i;
  reg clk,ss0,ss1,ss2;
  wire sdi0,sdi1,sdi2,miso,count;
  
  top_SPI spi_inst
  (.clk(clk),
   .m_in(m_in),
   .slv0_i(slv0_i),
   .slv1_i(slv1_i),
   .slv2_i(slv2_i),
   .ss0(ss0),.ss1(ss1),.ss2(ss2),
   .sdi0(sdi0),.sdi1(sdi1),.sdi2(sdi2),
   .miso(miso));
  
  
  initial begin
    
    clk = 1;m_in=8'b10111010;
    slv0_i=8'b10010110;
    slv1_i=8'b11010101;slv2_i=8'b11010110;
    ss0=1'b1;ss1=1'b1;ss2=1'b0;
    #160;
    m_in=8'b00001111;
    slv0_i=8'b10110111;
    slv1_i=8'b10010001;slv2_i=8'b00011101;
    #170;
    ss0=1'b1;ss1=1'b0;ss2=1'b1;m_in=8'b01101011;
    #160;
    m_in=8'b00001111;
    #160;
    ss0=1'b0;ss1=1'b1;ss2=1'b1;m_in=8'b11111011;
    
  end
  
  always begin
    #10 clk = !clk;
  end
  
  initial begin
    #1000 $finish;
  end
  
endmodule
