module is_right (
        input clk, rst,
        input [4-1:0] keypad_in,
        input [2-1:0] c1, c2,
        input [3-1:0] n1, n2,
        output reg right
    );
    always @(posedge clk) begin
        if (!rst) begin
            right <= 1'b0;
        end
    end

    always @(keypad_in) begin
        if ((keypad_in == 4'b0111) || (keypad_in == 4'b1001))begin
            if (c1 == c2) begin
                if ((n1 + n2) == 4'b0101) right <= 1'b1;
                else right <= 1'b0;
            end
            else begin
                if ((n1 == 3'b101) || (n2 == 3'b101)) right <= 1'b1;
                else right <= 1'b0;
            end
        end
        else begin
            right <= 1'b0;
        end
    end

//if 둘의 색깔이 동일한가?
//    if 둘의 합이 5인가? 맞음
//    else if 하나가 5인가? 맞음

endmodule



module who_push ( //이거 savewho에 0/1넣는걸론 해결못하나? 굳이 신호가 두개일필요 없을거같은디
        input clk, rst,
        input [4-1:0] keypad_in,
        output reg savewho1, savewho2
    );
        reg who1, who2;  //who1 [player1], who2 [player2]

    always @(posedge clk || keypad_in) begin
        if (!rst) begin
            savewho1 <= 1'b0;
            savewho2 <= 1'b0;
        end
        else begin
            if(keypad_in == 4'b0111) begin
                who1 <= 1'b1;
                if(who1*who2 == 0) savewho1 <= 1'b1;
                else who1 <= 1'b1;
            end
            else if(keypad_in == 4'b1001) begin
                who2 <= 1'b1;
                if(who1*who2 == 0) savewho2 <= 1'b1;
                else who2 <= 1'b1;
            end
            else begin
                who1 <= 1'b1;
                who2 <= 1'b1;
            end
        end
        
    end

// 그리고 친 사람이 reg_score에서 값을 받아 오면 who_push는 reset
endmodule



module score_control ( //이쪽코드를바꿉시다
        input clk, rst,
        input [8-1:0] count,
        input right,
        input [2-1:0] who,
        output reg [8-1:0] scoreA, scoreB
    );
    always @(posedge clk) begin
        if (!rst) begin
            scoreA <= 8'b0; scoreB <= 8'b0;
        end
        else begin
            if ( who == 2'b01 ) begin //A가 눌렀다면
                if (right) begin
                    scoreA <= count; scoreB <= 8'b0;
                end
                else begin
                    scoreA <= 8'b1111_1111; scoreB <= 8'b0000_0001; //-1 2'scomplement
                end
            end
            else if ( who == 2'b10 ) begin //B가 눌렀다면
                if (right) begin
                    scoreA <= 8'b0; scoreA <= count;
                end
                else begin
                    scoreA <= 8'b0000_0001; scoreB <= 8'b1111_1111; //-1 2'scomplement
                end
            end
        end
    end

endmodule



module reg_score (
        input clk, rst,
        input [8-1:0] add_score,
        output [9-1:0] total_score
    );

        reg [9-1:0] q_total_score, feedback;

    assign total_score = q_total_score;

    always @(posedge clk) begin
        if (!rst) begin
            q_total_score <= 9'b0;
        end
        else begin
            q_total_score <= feedback;
        end
    end

    always @(*) begin
        feedback = q_total_score + add_score;
    end

endmodule



module score_file (
    input clk, rst,
    input [16-1:0] add_score,
    output [18-1:0] total_score
);

reg_score A(.clk(clk), .rst(rst), .add_score(add_score[8-1:0]), .total_score(total_score[9-1:0]));
reg_score B(.clk(clk), .rst(rst), .add_score(add_score[16-1:8]), .total_score(total_score[18-1:9]));

endmodule


module who_win (
        input clk, rst,
        input [9-1:0] scoreA, scoreB,
        output reg [2-1:0] LCD_sig
    );
    always @(posedge clk) begin
        if (!rst) begin
            LCD_sig = 2'b0;
        end
        else begin
            if (scoreA > scoreB+9'b00011_0010) LCD_sig <= 2'b01;
            else if (scoreB > scoreA+9'b00011_0010) LCD_sig <= 2'b10;
            else LCD_sig <= 2'b00;
        end
    end

endmodule