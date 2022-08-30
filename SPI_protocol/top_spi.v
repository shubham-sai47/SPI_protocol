`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT GANDHINAGAR
// Engineer: Sanchit Mittal
// 
// Create Date: 27.08.2022 12:37:58
// Design Name: SPI communication protocol
// Module Name: top_spi
// Project Name: 
// Target Devices: Motorola mobile
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


module top_SPI(clk,m_in,slv0_i,slv1_i,slv2_i,ss0,ss1,ss2,sdi0,sdi1,sdi2,miso);
  input clk,ss0,ss1,ss2;
  input [7:0] m_in,slv0_i,slv1_i,slv2_i;
  reg sdo0,sdo1,sdo2,mosi,cs0,cs1,cs2,eng;
  reg [2:0] count,s_cnt0,s_cnt1,s_cnt2;
  output reg sdi0,sdi1,sdi2,miso;
  
  initial begin
    count = 7;
    s_cnt0 = 0;
    s_cnt1 = 0;
    s_cnt2 = 0;
  end
  
  always @(ss0,ss1,ss2) begin
    if ({ss0,ss1,ss2}==3'b011||3'b101||3'b110) begin
      eng <=1; //engaged
    end
    else begin 
      eng <= 0;
      
    end
  end
  //count for data bit transfer
  always @(posedge clk) begin
    if (eng==1) begin
      if (count == 0) begin
        count <= 7;
      end
      else begin
        count <= count - 1;
      end
    end
    else begin
      count <= 7;
    end
  end
  
    
  //master code
  
  always @(posedge clk) begin
    if (({ss0,ss1,ss2}==3'b011) &(eng==1)) begin
      cs0 <= 1'b0;
      mosi <= m_in[count]; //MSB transfer first
      sdi0 <= mosi;
      //miso <= sdo0;
    end
    else if (({ss0,ss1,ss2}==3'b101)&(eng==1)) begin
      cs1 <= 1'b0;
      mosi <= m_in[count]; //MSB
      sdi1 <= mosi;
      //miso <= sdo1;
    end
    else if (({ss0,ss1,ss2}==3'b110)&(eng==1)) begin
      cs2 <= 1'b0;
      mosi <= m_in[count]; //MSB
      sdi2 <= mosi;
      //miso <= sdo2;
    end
    else begin
      //mosi <= 1'b0;
      cs0 <= 1'b1;
      cs1 <= 1'b1;
      cs2 <= 1'b1;
      //miso <=1'b0;
    end
  end
  
  
  //slave code
  always @(posedge clk) begin
    if ({ss0,ss1,ss2}==3'b011) begin
      sdo0 <= slv0_i[s_cnt0]; //LSB
      //sdi0 <= mosi;
      miso <= sdo0;
      if (s_cnt0 == 7) begin
        s_cnt0 <= 0;
      end
      else begin
        s_cnt0 <= s_cnt0 + 1;
      end
    end
    else if ({ss0,ss1,ss2}==3'b101) begin
      sdo1 <= slv1_i[s_cnt1]; //LSB
      //sdi1 <= mosi;
      miso <= sdo1;
      if (s_cnt1 == 7) begin
        s_cnt1 <= 0;
      end
      else begin
        s_cnt1 <= s_cnt1 + 1;
      end
    end
    else if ({ss0,ss1,ss2}==3'b110) begin
      sdo2 <= slv2_i[s_cnt2]; //LSB
      //sdi2 <= mosi;
      miso <= sdo2;
      if (s_cnt2 == 7) begin
        s_cnt2 <= 0;
      end
      else begin
        s_cnt2 <= s_cnt2 + 1;
      end
    end
    else begin
      s_cnt0 <= 0;
      s_cnt1 <= 0;
      s_cnt2 <= 0;
      sdo0 <= 1'bx;
      sdo1 <= 1'bx;
      sdo2 <= 1'bx;
      sdi0 <= 1'bx;
      sdi1 <= 1'bx;
      sdi2 <= 1'bx;

    end

  end
  
endmodule
  
