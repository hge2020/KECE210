module stepmotor(reset,clock,stepperPins);

input clock, reset;
reg [2:0] secondsCounter;


parameter STEPPER_DIVIDER = 50000; // every 1ms
 
output [3:0] stepperPins;
reg [3:0] stepperPins;
 
reg [31:0] clockCount3;
reg [2:0] step; // 8 positions for half steps
 
always @ (posedge clock)
begin
    if(clockCount3 >= STEPPER_DIVIDER * (secondsCounter + 1))
        begin
            step <= step + 1'b1;
            clockCount3 <= 1'b0;
        end
    else
        clockCount3 <= clockCount3 + 1'b1;
end
 
always @ (step)
begin
    case(step)
        0: stepperPins<= 4'b1100;
        1: stepperPins<= 4'b0110;
        2: stepperPins<= 4'b0011;
        3: stepperPins<= 4'b1001;
    default : stepperPins<= 4'b1100;
    endcase
end
 
endmodule

