module top_piezo_tone (
    input clk, rst,
    input [12-1:0] keypad_in
    output piezo_out
); //clk :  1MHz

wire [12-1:0] key;
wire valid;

keypad_scan scan(.clk(clk), .rst(rst), .keypad_in(keypad_in), .scan_out(key), .valid(valid));
piezo_tone piezo(.clk(clk), .rst(rst), .in(key), .valid(valid), .To_piezo(piezo_out));

endmodule


module keypad_scan(
        input clk, rst,
        input [12-1:0] keypad_in,
        output reg [12-1:0] scan_out,
        output reg valid
    );
        reg enable;

        always @(posedge clk or negedge rst) begin
            if (~rst) begin
                scan_out <= 12'd0;
                valid <= 1'b0;
                enable <= 1'b0;
            end
            else begin
                if (keypad_in && ~enable) begin
                    scan_out <= keypad_in;
                    valid <= 1'b1;
                    enable <= 1'b1;
                end
                else if (keypad_in && enable) begin
                    scan_out <= 12'd0;
                    valid <= 1'b0;
                end
                else begin
                    enable <= 1'b0;
                    valid <= 1'b0;
                    scan_out <= 12'd0;
                end
            end
        end

endmodule



module piezo_tone (
        input clk, rst,
        input [12-1:0] in,
        input valid,
        output wire To_piezo
    );
    reg temp;
    reg [7:0] CNT_SOUND, frequency;

    localparam TEST = 32'haaaaaa;


    always @(in) begin
        case (in)
            12'b0000_0000_0001: frequency = 1910; //1
            12'b0000_0000_0010: frequency = 1701; //2
            12'b0000_0000_0100: frequency = 1516; //3
            12'b0000_0000_1000: frequency = 1431; //4
            12'b0000_0001_0000: frequency = 1275; //5
            12'b0000_0010_0000: frequency = 1135; //6
            12'b0000_0100_0000: frequency = 1011; //7
            12'b0000_1000_0000: frequency = 955; //8
            default: frequency = 0;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            temp = 1'b0;
            CNT_SOUND = 0;
        end
        else begin
            if (CNT_SOUND >= frequency) begin
                cnt_SOUND = 0;
                temp = ~temp;
            end
            else CNT_SOUND = CNT_SOUND +1;

            
        end
    end

    assign To_piezo = temp;

endmodule