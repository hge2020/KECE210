module is_right (               //검증 완료
        input clk, rst,
        input [4-1:0] keypad_in,
        input [2-1:0] c1, c2,
        input [3-1:0] n1, n2,
        output reg right
    );

    always @(*) begin
        if (!rst) begin
            right = 1'b0;
        end
        else begin
            if (keypad_in == 4'b0111 || keypad_in == 4'b1001)begin
                if (c1 == c2) begin
                    if ((n1 + n2) == 4'b0101) right = 1'b1;
                    else right = 1'b0;
                end
                else begin
                    if (n1 == 3'b101 || n2 == 3'b101) right = 1'b1;
                    else right = 1'b0;
                end
            end
            else begin
                right = 1'b0;
            end
        end
    end

//if 둘의 색깔이 동일한가?
//    if 둘의 합이 5인가? 맞음
//    else if 하나가 5인가? 맞음

endmodule



module who_push (     //검증완료
        input clk, rst, finish,
        input [4-1:0] keypad_in,
        output reg savewho1, savewho2
    );
    parameter no_one = 2'b00 ;
    parameter p1_push = 2'b01 ;
    parameter p2_push = 2'b10 ;

    reg [1:0] finite_state;
    //savewho1 [player1], savewho2 [player2]

    always @(posedge clk) begin
        if (~rst) begin
            finite_state <= no_one;
            savewho1 <= 1'b0;
            savewho2 <= 1'b0;
        end
        else begin
            case(finite_state)
            no_one: begin
                if (keypad_in == 4'b0111) begin
                    if (finish == 1'b0) begin
                        finite_state <= p1_push;
                        savewho1 <= 1'b1;
                        savewho2 <= 1'b0;
                    end
                    
                    else begin
                        finite_state <= no_one;
                        savewho1 <= 1'b0;
                        savewho2 <= 1'b0;
                    end
                end
                else if (keypad_in == 4'b1001) begin
                    if (finish == 1'b0) begin
                        finite_state <= p2_push;
                        savewho1 <= 1'b0;
                        savewho2 <= 1'b1;
                    end
                    else begin
                        finite_state <= no_one;
                        savewho1 <= 1'b0;
                        savewho2 <= 1'b0; 
                    end
                end
                else begin
                    finite_state <= no_one;
                    savewho1 <= 1'b0;
                    savewho2 <= 1'b0;
                end
            end
            p1_push: begin
                if (finish == 1'b1) begin
                    finite_state <= no_one;
                    savewho1 <= 1'b0;
                    savewho2 <= 1'b0;
                end
                else begin
                    finite_state <= p1_push;
                    savewho1 <= 1'b1;
                    savewho2 <= 1'b0;
                end
            end
            p2_push: begin
                if (finish == 1'b1) begin
                    finite_state <= no_one;
                    savewho1 <= 1'b0;
                    savewho2 <= 1'b0;
                end                
                else begin
                    finite_state <= p2_push;
                    savewho1 <= 1'b0;
                    savewho2 <= 1'b1;
                end
            end
            default: finite_state <= no_one;
            endcase
        end
    end

//reset까지 state에 구현해야 rst이 동작 하더라고....
//코드는 드릅게 길지만 알맹이는 땅콩정도..?
endmodule



module score_control ( 
        input clk, rst,
        input [8-1:0] count,
        input right,
        input [2-1:0] who,
        output reg [8-1:0] scoreA, scoreB,
        output reg finish
    );
    always @(posedge clk) begin
        if (!rst) begin
            scoreA <= 8'b0; scoreB <= 8'b0;
            finish <= 1'b0;
        end
        else begin
            if ( who == 2'b01 ) begin //A가 눌렀다면
                if (right) begin
                    scoreA <= count; scoreB <= 8'b0;
                end
                else begin
                    scoreA <= 8'b1111_1111; scoreB <= 8'b0000_0001; //-1 2'scomplement
                end
                finish <= 1'b1;
            end
            else if ( who == 2'b10 ) begin //B가 눌렀다면
                if (right) begin
                    scoreA <= 8'b0; scoreB <= count;
                end
                else begin
                    scoreA <= 8'b0000_0001; scoreB <= 8'b1111_1111; //-1 2'scomplement
                end
                finish <= 1'b1;
            end
            else begin
                scoreA <= 8'b0; scoreB <= 8'b0;
                finish <= 1'b0;
            end
        end
    end

endmodule //검증완료. finish는 who값에 의해 제어됩니다!<<둘이 섞여서 잘 돌아가는지 확인할것.



module reg_score (
        input clk, rst,
        input [8-1:0] add_score,
        output reg [8-1:0] total_score
    );

        reg [8-1:0] q_total_score, feedback;

    //assign total_score = q_total_score;

    always @(posedge clk) begin
        if (!rst) begin
            //total_score <= 8'b0;
            q_total_score <= 8'b0;
            //feedback <= 8'b0;
        end
        else begin
            q_total_score <= feedback;
        end
    end
    
    always @(add_score) begin
        if (!rst) begin
            feedback = 8'b0;
            total_score = 8'b0;
        end
        else begin
            feedback = q_total_score + add_score;
            total_score = feedback; 
        end
    end

    // always @(*) begin
    //     if (!rst) begin
    //         feedback = 8'b0;
    //         total_score = 8'b0;
    //     end
    //     else begin
    //         feedback = q_total_score + add_score;
    //         total_score = feedback; 
    //     end
        
    // end

endmodule



module score_file (
    input clk, rst,
    input [16-1:0] add_score,
    output [16-1:0] total_score
);

reg_score A(.clk(clk), .rst(rst), .add_score(add_score[8-1:0]), .total_score(total_score[8-1:0]));
reg_score B(.clk(clk), .rst(rst), .add_score(add_score[16-1:8]), .total_score(total_score[16-1:8]));

endmodule


module who_win ( // 검증완료
        input clk, rst,
        input [8-1:0] scoreA, scoreB,
        output reg [2-1:0] LED_sig
    );
    always @(posedge clk) begin
        if (!rst) begin
            LED_sig = 2'b0;
        end
        else begin
            if (scoreA > scoreB+8'b0000_1001) LED_sig <= 2'b01;
            else if (scoreB > scoreA+8'b0000_1001) LED_sig <= 2'b10;
            else LED_sig <= 2'b00;
        end
    end

endmodule