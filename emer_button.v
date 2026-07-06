module emer_button (
    input  wire clk,
    input  wire rst,
    input  wire emer_btn,
    output reg  emer_req
);
    reg [19:0] sh;
    always @(posedge clk or posedge rst)
        if (rst) begin sh<=0; emer_req<=0; end
        else begin sh<={sh[18:0],emer_btn}; emer_req<=&sh; end
endmodule