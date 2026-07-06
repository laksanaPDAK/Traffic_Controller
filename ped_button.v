module ped_button (
    input  wire clk,
    input  wire rst,
    input  wire ped_btn,
    output reg  ped_req
);
    reg [19:0] sh;
    always @(posedge clk or posedge rst)
        if (rst) begin sh<=0; ped_req<=0; end
        else begin sh<={sh[18:0],ped_btn}; ped_req<=&sh; end
endmodule