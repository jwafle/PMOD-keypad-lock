`timescale 1ns / 1ps
// ==============================================================================================
// 												Define Module
// ==============================================================================================
module PmodKYPD(
clk,
JB,
an,
seg
);


// ==============================================================================================
// 											Port Declarations
// ==============================================================================================
input clk;					// 100Mhz onboard clock
inout [7:0] JB;			// Port JB on Basys3, JB[3:0] is Columns, JB[10:7] is rows
output [3:0] an;			// Anodes on seven segment display
output [6:0] seg;			// Cathodes on seven segment display

// ==============================================================================================
// 							  		Parameters, Regsiters, and Wires
// ==============================================================================================

// Output wires
wire [3:0] an;
wire [6:0] seg;
wire [3:0] Decode;

//Intermediate Parameters
reg [3:0] solvestate = 4'b0000;
reg [31:0] counter = 0;


// ==============================================================================================
// 												Implementation
// ==============================================================================================

//-----------------------------------------------
//  						Decoder
//-----------------------------------------------


Decoder C0(
.clk(clk),
.Row(JB[7:4]),
.Col(JB[3:0]),
.DecodeOut(Decode)
); //runs code to decode input from 16 button keypad

always @(posedge clk) begin//create slower clock for updating the solvestate at a lower sampling frequency
if (counter < 32'h007FFFFF)
begin
counter <= counter +1;
end
else if (counter == 32'h007FFFFF)//only update solvestate on a specific interval defined by the counter
begin
counter <= 0;
//passcode arbitrarily set to: 71B8
if (solvestate == 4'b0000)//if solvestate is 0, check for a button press of 7 to send solvestate to 1. otherwise, maintain solvestate = 0.
begin
case (Decode)

4'h0 : solvestate <= 4'b0000;  // 0
4'h1 : solvestate <= 4'b0000;  // 1
4'h2 : solvestate <= 4'b0000;  // 2
4'h3 : solvestate <= 4'b0000;  // 3
4'h4 : solvestate <= 4'b0000;  // 4
4'h5 : solvestate <= 4'b0000;  // 5
4'h6 : solvestate <= 4'b0000;  // 6
4'h7 : solvestate <= 4'b0001;  // 7
4'h8 : solvestate <= 4'b0000;  // 8
4'h9 : solvestate <= 4'b0000;  // 9
4'hA : solvestate <= 4'b0000;     // A
4'hB : solvestate <= 4'b0000;    // B
4'hC : solvestate <= 4'b0000;    // C
4'hD : solvestate <= 4'b0000;    // D
4'hE : solvestate <= 4'b0000;    // E
4'hF : solvestate <= 4'b0000;    // F

default : solvestate <= 4'b0000;

endcase
end
else if (solvestate == 4'b0001)//if solvestate is 1, check for a button press of 1 to send solvestate to 2.
//if button 7 is bouncing, maintain state at solvestate = 1. if any other button is pressed, send solvestate back to 0.
begin
case (Decode)

4'h0 : solvestate <= 4'b0000;  // 0
4'h1 : solvestate <= 4'b0010;  // 1
4'h2 : solvestate <= 4'b0000;  // 2
4'h3 : solvestate <= 4'b0000;  // 3
4'h4 : solvestate <= 4'b0000;  // 4
4'h5 : solvestate <= 4'b0000;  // 5
4'h6 : solvestate <= 4'b0000;  // 6
4'h7 : solvestate <= 4'b0001;  // 7
4'h8 : solvestate <= 4'b0000;  // 8
4'h9 : solvestate <= 4'b0000;  // 9
4'hA : solvestate <= 4'b0000;     // A
4'hB : solvestate <= 4'b0000;    // B
4'hC : solvestate <= 4'b0000;    // C
4'hD : solvestate <= 4'b0000;    // D
4'hE : solvestate <= 4'b0000;    // E
4'hF : solvestate <= 4'b0000;    // F

default : solvestate <= 4'b0001;

endcase
end
else if (solvestate == 4'b0010)//if solvestate is 2, check for a button press of B to send solvestate to 3.
//if button 1 is bouncing, maintain state at solvestate = 2. if any other button is pressed, send solvestate back to 0.
begin
case (Decode)

4'h0 : solvestate <= 4'b0000;  // 0
4'h1 : solvestate <= 4'b0010;  // 1
4'h2 : solvestate <= 4'b0000;  // 2
4'h3 : solvestate <= 4'b0000;  // 3
4'h4 : solvestate <= 4'b0000;  // 4
4'h5 : solvestate <= 4'b0000;  // 5
4'h6 : solvestate <= 4'b0000;  // 6
4'h7 : solvestate <= 4'b0000;  // 7
4'h8 : solvestate <= 4'b0000;  // 8
4'h9 : solvestate <= 4'b0000;  // 9
4'hA : solvestate <= 4'b0000;     // A
4'hB : solvestate <= 4'b0011;    // B
4'hC : solvestate <= 4'b0000;    // C
4'hD : solvestate <= 4'b0000;    // D
4'hE : solvestate <= 4'b0000;    // E
4'hF : solvestate <= 4'b0000;    // F

default : solvestate <= 4'b0010;

endcase
end
else if (solvestate == 4'b0011)//if solvestate is 3, check for a button press of 8 to send solvestate to 4.
//if button B is bouncing, maintain state at solvestate = 3. if any other button is pressed, send solvestate back to 0.
begin
case (Decode)

4'h0 : solvestate <= 4'b0000;  // 0
4'h1 : solvestate <= 4'b0000;  // 1
4'h2 : solvestate <= 4'b0000;  // 2
4'h3 : solvestate <= 4'b0000;  // 3
4'h4 : solvestate <= 4'b0000;  // 4
4'h5 : solvestate <= 4'b0000;  // 5
4'h6 : solvestate <= 4'b0000;  // 6
4'h7 : solvestate <= 4'b0000;  // 7
4'h8 : solvestate <= 4'b0100;  // 8
4'h9 : solvestate <= 4'b0000;  // 9
4'hA : solvestate <= 4'b0000;     // A
4'hB : solvestate <= 4'b0011;    // B
4'hC : solvestate <= 4'b0000;    // C
4'hD : solvestate <= 4'b0000;    // D
4'hE : solvestate <= 4'b0000;    // E
4'hF : solvestate <= 4'b0000;    // F

default : solvestate <= 4'b0011;

endcase
end
else if (solvestate == 4'b0100)//if solvestate is 4, maintain solvestate value if button 8 is bouncing.
//if any other button is pressed, send solvestate back to 0.
begin
case (Decode)

4'h0 : solvestate <= 4'b0000;  // 0
4'h1 : solvestate <= 4'b0000;  // 1
4'h2 : solvestate <= 4'b0000;  // 2
4'h3 : solvestate <= 4'b0000;  // 3
4'h4 : solvestate <= 4'b0000;  // 4
4'h5 : solvestate <= 4'b0000;  // 5
4'h6 : solvestate <= 4'b0000;  // 6
4'h7 : solvestate <= 4'b0000;  // 7
4'h8 : solvestate <= 4'b0100;  // 8
4'h9 : solvestate <= 4'b0000;  // 9
4'hA : solvestate <= 4'b0000;     // A
4'hB : solvestate <= 4'b0000;    // B
4'hC : solvestate <= 4'b0000;    // C
4'hD : solvestate <= 4'b0000;    // D
4'hE : solvestate <= 4'b0000;    // E
4'hF : solvestate <= 4'b0000;    // F

default : solvestate <= 4'b0100;

endcase
end
end

end
//-----------------------------------------------
//  		Seven Segment Display Controller
//-----------------------------------------------

DisplayController C1(
.DispVal(solvestate),
.anode(an),
.segOut(seg)
);//runs code to display solvestate on the 7 segment display.

endmodule
