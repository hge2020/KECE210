module full_c_LED (
    input clk, rst,
    input [2-1:0] c_value1, c_value2,
    output  led_1_r, led_1_g, led_1_b,
            led_2_r, led_2_g, led_2_b //LED위치 다시보기
);
    reg [6-1:0] out;

always @(posedge clk) begin
    if (!rst) begin
        out <= 6'b0;
    end
    else begin
        case({c_value1[1], c_value1[0]})
        2'b01: out[6-1:3] <= 3'b100;
        2'b10: out[6-1:3] <= 3'b010;
        2'b11: out[6-1:3] <= 3'b001;
        default: out[6-1:3] <= 3'b000;
        endcase

        case({c_value2[1], c_value2[0]})
        2'b01: out[3-1:0] <= 3'b100;
        2'b10: out[3-1:0] <= 3'b010;
        2'b11: out[3-1:0] <= 3'b001;
        default: out[3-1:0] <= 3'b000;
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

always @(*) begin
    // if(!rst) begin
    //     seg = 7'b111_1111;
    // end
    // else begin
        
    // end
    case(c_value)
        3'b001: seg = 7'b000_0110; //1
        3'b010: seg = 7'b101_1011; //2
        3'b011: seg = 7'b100_1111; //3
        3'b100: seg = 7'b110_0110; //4
        3'b101: seg = 7'b110_1101; //5
        default: seg = 7'b111_1111; //void
    endcase
end

endmodule



module seven_segment (
    input clk, rst,
    input [7-1:0] seg1, seg2,
    output reg [7-1:0] data_out,
    output reg [8-1:0] data_pos
);
    reg [3-1:0] count_q, count_d;

always @(posedge clk) begin
    if(!rst) begin
        count_q <= 3'b0;
    end
    else begin
        count_q <= count_d;
    end
end

always @(*) begin
    if(!rst) begin
        data_pos = 8'b0;
        data_out = 7'b0;
        count_d = 3'b0;
    end
    else begin
        count_d = count_q + 3'b1;

        case(count_q)
        3'b000: begin
            data_pos = 8'b1111_1110;
            data_out = seg1;
        end
        3'b001: begin
            data_pos = 8'b1111_1101;
            data_out = 7'b1;
        end
        3'b010: begin
            data_pos = 8'b1111_1011;
            data_out = 7'b1;
        end
        3'b011: begin
            data_pos = 8'b1111_0111;
            data_out = 7'b1;
        end
        3'b100: begin
            data_pos = 8'b1110_1111;
            data_out = 7'b1;
        end
        3'b101: begin
            data_pos = 8'b1101_1111;
            data_out = 7'b1;
        end
        3'b110: begin
            data_pos = 8'b1011_1111;
            data_out = 7'b1;
        end
        3'b111: begin
            data_pos = 8'b0111_1111;
            data_out = seg2;
        end
        endcase
    end

end

endmodule

module LED (
    input clk, rst,
    input [2-1:0] LCD_sig,
    output reg l0, l1, l2, l3, l4, l5, l6, l7
);

    always @(posedge clk) begin
        if (!rst) begin
            {l0, l1, l2, l3, l4, l5, l6, l7} <= 8'b0;
        end
        else begin
            case (LCD_sig)
            2'b01: begin
                {l0, l1, l2, l3, l4, l5, l6, l7} <= 8'b1111_0000;
            end
            2'b10: begin
                {l0, l1, l2, l3, l4, l5, l6, l7} <= 8'b0000_1111;
            end
            default begin
                {l0, l1, l2, l3, l4, l5, l6, l7} <= 8'b0;
            end
            endcase
        end
    end
endmodule


module LCD (
        input clk, rst,
        input [2-1:0] LCD_sig,
        output reg LCD_E,LCD_RS,LCD_RW,
        output reg [8-1:0] LCD_DATA
    );
        
    wire [8-1:0] w_lcd1, w_lcd2, w_lcd3, w_lcd4;
    wire LCD_E1, LCD_E2, LCD_E3, LCD_E4;
    wire LCD_RS1, LCD_RS2, LCD_RS3, LCD_RS4;
    wire LCD_RW1, LCD_RW2, LCD_RW3, LCD_RW4;

    LCD1 LCD_A_win(rst,clk,LCD_E1,LCD_RS1,LCD_RW1,w_lcd1);
    LCD2 LCD_B_win(rst,clk,LCD_E2,LCD_RS2,LCD_RW2,w_lcd2);
    LCD3 LCD_off(rst,clk,LCD_E3,LCD_RS3,LCD_RW3,w_lcd3);

    always @(posedge clk) begin // ???
        if (!rst) begin
            LCD_E <= 1'b0;
            LCD_RS <= 1'b0;
            LCD_RW <= 1'b0;
            LCD_DATA <= 8'b0;
        end
        else begin
            case (LCD_sig)
            2'b01: begin
                LCD_DATA = w_lcd1;
                LCD_E=LCD_E1;
                LCD_RS=LCD_RS1;
                LCD_RW=LCD_RW1;
            end
            2'b10: begin
                LCD_DATA = w_lcd2;
                LCD_E=LCD_E2;
                LCD_RS=LCD_RS2;
                LCD_RW=LCD_RW2;
            end
            default begin
                LCD_DATA = w_lcd3;
                LCD_E=LCD_E3;
                LCD_RS=LCD_RS3;
                LCD_RW=LCD_RW3;
            end
            endcase
        end
    end
endmodule



module LCD1 ( //P1 Win ♥♥♥ ♥♥♥
        input clk, rst,
        output wire LCD_E,
        output reg LCD_RS,LCD_RW,
        output reg[8-1:0] LCD_DATA
        );

        //wire LCD_E;
        //reg LCD_RS,LCD_RW;
        //reg[7:0] LCD_DATA;
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

    always @(negedge rst or posedge clk)
    begin
        if(~rst) state = delay;
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


    always @(negedge rst or posedge clk)
    begin
        if(~rst) interval=0;
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


    always @(negedge rst or posedge clk)

    begin
        if(~rst) begin
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
                    LCD_RS=1'b1;LCD_DATA=8'b0101_0000;//P
                end
                3:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0011_0001;//1
                end
                4:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
                end
                5:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0101_0001;//W
                end
                6:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0110_1001;//i
                end
                7:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0110_1110;//n
                end
                8:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
                end
                9:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//Void
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
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                3:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                4:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                5:begin
                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//Void
                end
                6:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                7:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                8:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                9:begin
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


module LCD2 ( //P2 Win ♥♥♥ ♥♥♥
        input clk, rst,
        output wire LCD_E,
        output reg LCD_RS,LCD_RW,
        output reg[8-1:0] LCD_DATA
        );

        //wire LCD_E;
        //reg LCD_RS,LCD_RW;
        //reg[7:0] LCD_DATA;
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

    always @(negedge rst or posedge clk)
    begin
        if(~rst) state = delay;
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


    always @(negedge rst or posedge clk)
    begin
        if(~rst) interval=0;
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


    always @(negedge rst or posedge clk)

    begin
        if(~rst) begin
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
                    LCD_RS=1'b1;LCD_DATA=8'b0101_0000;//P
                end
                3:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0011_0010;//2
                end
                4:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
                end
                5:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0101_0001;//W
                end
                6:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0110_1001;//i
                end
                7:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0110_1110;//n
                end
                8:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//void
                end
                9:begin
                    LCD_RS=1'b1;LCD_DATA=8'b0010_0000;//Void
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
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                3:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                4:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                5:begin
                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//Void
                end
                6:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                7:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                8:begin
                    LCD_RS=1'b1;LCD_DATA=8'b1001_1101;//♥
                end
                9:begin
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


module LCD3 ( //void
        input clk, rst,
        output wire LCD_E,
        output reg LCD_RS,LCD_RW,
        output reg[8-1:0] LCD_DATA
        );

        //wire LCD_E;
        //reg LCD_RS,LCD_RW;
        //reg[7:0] LCD_DATA;
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

    always @(negedge rst or posedge clk)
    begin
        if(~rst) state = delay;
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


    always @(negedge rst or posedge clk)
    begin
        if(~rst) interval=0;
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


    always @(negedge rst or posedge clk)

    begin
        if(~rst) begin
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
                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//void
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