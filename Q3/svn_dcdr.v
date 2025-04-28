/* 
//  A seven-segment display decoder
//  Design method: behavior
//  Displays decimal numbers from 0 to 9, including the decimal point
//  Inputs from 1010 to 1111 will turn off the display (go dark)
//  Common anode type: set LOW to illuminate the LED segment
*/

/*  8 segment display pinout
//    |--CA--|
//    CF     CB
//    |--CG--|
//    CE     CC
//    |--CD--|  DP
*/

/*
//  set AN to LOW to enable the digit
*/

module svn_dcdr (
  input [3:0] in,
  output CA, CB, CC, CD, CE, CF, CG, DP
);

assign {CA, CB, CC, CD, CE, CF, CG, DP} = 
  (in == 4'h0) ? 8'b00000011 :
  (in == 4'h1) ? 8'b10011111 :
  (in == 4'h2) ? 8'b00100101 :
  (in == 4'h3) ? 8'b00001101 :
  (in == 4'h4) ? 8'b10011001 :
  (in == 4'h5) ? 8'b01001001 :
  (in == 4'h6) ? 8'b01000001 :
  (in == 4'h7) ? 8'b00011111 :
  (in == 4'h8) ? 8'b00000001 :
  (in == 4'h9) ? 8'b00001001 :
  (in == 4'ha) ? 8'b00000000 : //全亮
  (in == 4'hb) ? 8'b00000011 : //0
  (in == 4'hc) ? 8'b00111001 : //o
  (in == 4'hd) ? 8'b11111111 : //沒用到
  (in == 4'he) ? 8'b11111111 : //沒用到
  8'b11111111; //全暗



endmodule
