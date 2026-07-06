module seven_seg_display (
    input  wire clk,
    input  wire rst,
    input  wire [2:0] state,
    input  wire [3:0] count,

    output reg [6:0] seg,
    output reg [3:0] an
);

    reg [16:0] refresh;
    reg [1:0] digit;

    always @(posedge clk or posedge rst)
        if (rst) refresh <= 0;
        else refresh <= refresh + 1;

    always @(*) digit = refresh[16:15];

    always @(*) begin
        an = 4'b1111;
        an[digit] = 0;
        seg = 7'b1111111;

        case (state)
            3'd0: begin // GO
                if (digit==1) seg=7'h42;
                if (digit==0) seg=7'h40;
            end
            3'd1: begin // WAIT
                if (digit==3) seg=7'h2A;
                if (digit==2) seg=7'h08;
                if (digit==1) seg=7'h79;
                if (digit==0) seg=7'h07;
            end
            3'd2: begin // STOP
                if (digit==3) seg=7'h12;
                if (digit==2) seg=7'h07;
                if (digit==1) seg=7'h40;
                if (digit==0) seg=7'h0C;
            end
            3'd3: begin // COUNT
                if (digit==0) begin
                    case(count)
                        1: seg=7'b1111001;
                        2: seg=7'b0100100;
                        3: seg=7'b0110000;
                        4: seg=7'b0011001;
                        5: seg=7'b0010010;
                        6: seg=7'b0000010;
                        7: seg=7'b1111000;
                        8: seg=7'b0000000;
                    endcase
                end
            end
            3'd4: begin // EMER
                if (digit==3) seg=7'h06; // E
                if (digit==2) seg=7'h4F; // M
                if (digit==1) seg=7'h06; // E
                if (digit==0) seg=7'h50; // R
            end
        endcase
    end
endmodule