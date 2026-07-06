module one_sec_tick (
    input  wire clk,
    input  wire rst,
    output reg  tick_1s
);
    parameter ONE_SEC = 100_000_000;
    reg [$clog2(ONE_SEC)-1:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            tick_1s <= 0;
        end else begin
            tick_1s <= 0;
            if (cnt == ONE_SEC-1) begin
                cnt <= 0;
                tick_1s <= 1;
            end else
                cnt <= cnt + 1;
        end
    end
endmodule