module full_c_LED (
    input clk, rst,
    input [2-1:0] c_value1, c_value2,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b, //LED위치 다시보기
);
    reg [6-1:0] out;

always @(posedge clk) begin
    if (!rst) begin
        out <= 6'b0;
    end
    else begin
        case({c_value1[1], {c_value1[0], c_value2[1], {c_value2[0]})
        4'b01_00: out <= 100_000;
        4'b10_00: out <= 010_000;
        4'b11_00: out <= 001_000;

        4'b00_01: out <= 000_100;
        4'b00_10: out <= 000_010;
        4'b00_11: out <= 000_001;
        endcase
    end
end

assign {led_1_r, led_1_g, led_1_b, led_2_r, led_2_g, led_2_b} = out;

endmodule


module display (
    input clk, rst,
    input [3-1:0] c_value,
    output reg [7-1:0] seg
);
    reg [7-1:0] temp;

always @(posedge clk) begin
    if(~rst) begin
        seg <= 7'b0;
        temp <= 7'b0;
    end
end

always @(posedge clk) begin
    case(c_value)
        3'b000: temp <= 7'b0110000; //1
        3'b001: temp <= 7'b1101101; //2
        3'b010: temp <= 7'b1111001; //3
        3'b011: temp <= 7'b0110011; //4
        3'b100: temp <= 7'b1011011; //5
        default: temp <= 7'b0110000; //0
    endcase
    seg <= temp;
end

endmodule

module seven_segment (
    input clk, rst,
    input [7-1:0] seg1, seg2,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos
);
    reg [3-1:0] count = 3'b0;

always @(posedge clk) begin
    if(~rst) begin
        data_pos <= 8'b0;
        data_out <= 7'b0;
    end
    else begin
        count <= count+1'b1;
        case(count)
        3'b000: begin
            data_pos <= 0000_0001;
            data_out <= seg1;
        end
        3'b111: begin
            data_pos <= 1000_0000;
            data_out <= seg2;
        end
        default: begin
            data_pos <= 8'b0;
            data_out <= 7'b0;
        end
        endcase
    end
end

endmodule



module LCD( //화면 문구 지정하지않았음. digital design helloworld 상태
    input clk, rst,
    output LCD_E,LCD_RS,LCD_RW,
    output [8-1:0] LCD_DATA
    );

    wire LCD_E;
    reg LCD_RS,LCD_RW;
    reg[7:0] LCD_DATA;
    reg[2:0] state;

parameter delay=3'b000;
parameter function_set=3'b001;
parameter entry_mode=3'b010;
parameter disp_onoff=3'b011;
parameter line1=3'b100;
parameter line2=3'b101;
parameter delay_t=3'b110;
parameter clear_disp=3'b111;

integer interval;

always @(negedge resetn or posedge clk)
begin
    if(~resetn) state = delay;
    else begin
        case(state)
            delay:          if(interval==70)state=function_set;
            function_set:    if(interval==30)state=entry_mode;
            entry_mode:      if(interval==30)state=disp_onoff;
            disp_onoff:      if(interval==30)state=line1;
            line1:         if(interval==20)state=line2;
            line2:         if(interval==20)state=delay_t;
            delay_t:         if(interval==400)state=clear_disp;
            clear_disp:    if(interval==200)state=line1;
            default:         state=delay;
        endcase
    end
end


always @(negedge resetn or posedge clk)
begin
    if(~resetn) interval=0;
    else begin   
        case(state)
            delay:    if(interval>=70) interval=0;      //Write your own code.
                    else interval = interval +1;
            function_set: if(interval>=30) interval=0;   //Write your own code.
                    else interval = interval +1;
            entry_mode: if(interval>=30) interval=0;   //Write your own code.
                    else interval = interval +1;
            disp_onoff: if(interval>=30) interval=0;   //Write your own code.   
                    else interval = interval +1;
            line1:   if(interval>=20) interval=0;      //Write your own code.
                    else interval = interval +1;
            line2:   if(interval>=20) interval=0;      //Write your own code.
                    else interval = interval +1;
            delay_t: if(interval>=400) interval=0;   //Write your own code.
                    else interval = interval +1;
            clear_disp: if(interval>=200) interval=0;   //Write your own code.
                    else interval = interval +1;
            default:         interval=0;
        endcase
    end
end




always @(negedge resetn or posedge clk)

begin
    if(~resetn) begin
        LCD_RS=1'b1;
        LCD_RW=1'b1;
        LCD_DATA=8'b00000000;
    end
    else begin   
        case(state)
        function_set:begin
            LCD_RS=1'b0;
            LCD_RW=1'b0;
            LCD_DATA=8'b00111100;
        end

        entry_mode:begin
            LCD_RS=1'b0;
            LCD_RW=1'b0;
            LCD_DATA=8'b00000110;
        end
        
        disp_onoff:begin
            LCD_RS=1'b0;
            LCD_RW=1'b0;
            LCD_DATA=8'b00001100;
        end

        line1:begin
            LCD_RW=1'b0;
            case(interval)
            0:begin
                LCD_RS=1'b0;LCD_DATA=8'b10000000;
            end
            1:begin
                LCD_RS=1'b1;LCD_DATA=8'b00100000;//Void
            end
            2:begin
                LCD_RS=1'b1;LCD_DATA=8'b0100_0100;//D
            end
            3:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1001;//i
            end
            4:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0111;//g
            end
            5:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1001;//i
            end
            6:begin
                LCD_RS=1'b1;LCD_DATA=8'b0111_0100;//t
            end
            7:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0001;//a
            end
            8:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1100;//l
            end
            9:begin
                LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
            end
            10:begin
                LCD_RS=1'b1;LCD_DATA=8'b0100_0100;//D
            end
            11:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0101;//e
            end
            12: begin
                LCD_RS=1'b1;LCD_DATA=8'b0111_0011;//s
            end
            13:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1001;//i
            end
            14:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0111;//g
            end
            15:begin
                LCD_RS=1'b1;LCD_DATA=8'b0101_1110;//n
            end
            16:begin
                LCD_RS=1'b1;LCD_DATA=8'b00100000;//void
            end
            default:begin
                LCD_RS=1'b1;LCD_DATA=8'b00100000;//
            end
            endcase
        end

        line2:begin
            LCD_RW=1'b0;
            case(interval)
            0:begin
                LCD_RS=1'b0;LCD_DATA=8'b11000000;
            end
            1:begin
                LCD_RS=1'b1;LCD_DATA=8'b00100000;//Void
            end
            2:begin
                LCD_RS=1'b1;LCD_DATA=8'b0100_1000;//H
            end
            3:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0101;//e
            end
            4:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1100;//l
            end
            5:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1100;//l
            end
            6:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1111;//o
            end
            7:begin
                LCD_RS=1'b1;LCD_DATA=8'b0010_1100;//,
            end
            8:begin
                LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
            end
            9:begin
                LCD_RS=1'b1;LCD_DATA=8'b0101_0111;//W
            end
            10:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1111;//o
            end
            11:begin
                LCD_RS=1'b1;LCD_DATA=8'b0111_0010;//r
            end
            12:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_1100;//l
            end
            13:begin
                LCD_RS=1'b1;LCD_DATA=8'b0110_0100;//d
            end
            14:begin
                LCD_RS=1'b1;LCD_DATA=8'b0010_0001;//!
            end
            15:begin
                LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//Void
            end
            default:begin
                LCD_RS=1'b1;LCD_DATA=8'b00100000;//
            end
            endcase
        end

        delay_t: begin
            LCD_RS=1'b0;
            LCD_RW=1'b0;
            LCD_DATA=8'b00000010;
            end
        clear_disp: begin
            LCD_RS=1'b0;
            LCD_RW=1'b0;
            LCD_DATA=8'b00000001;
            end
        default: begin
            LCD_RS=1'b1;
            LCD_RW=1'b1;
            LCD_DATA=8'b00000000;
            end
        endcase
    end
end

assign LCD_E=clk;

endmodule