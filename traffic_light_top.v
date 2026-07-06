module traffic_light_top (
    input  wire clk,
    input  wire rst,
    input  wire ped_btn,
    input  wire emer_btn,

    output wire car_red,
    output wire car_yellow,
    output wire car_green,
    output wire ped_red,
    output wire ped_green,

    output wire [6:0] seg,
    output wire [3:0] an
);

    wire tick_1s;
    wire ped_req;
    wire emer_req;
    wire [2:0] state;
    wire [3:0] count;

    one_sec_tick u_tick (
        .clk(clk),
        .rst(rst),
        .tick_1s(tick_1s)
    );

    ped_button u_ped (
        .clk(clk),
        .rst(rst),
        .ped_btn(ped_btn),
        .ped_req(ped_req)
    );

    emer_button u_emer (
        .clk(clk),
        .rst(rst),
        .emer_btn(emer_btn),
        .emer_req(emer_req)
    );

    traffic_fsm u_fsm (
        .clk(clk),
        .rst(rst),
        .tick_1s(tick_1s),
        .ped_req(ped_req),
        .emer_req(emer_req),
        .state(state),
        .count(count),
        .car_red(car_red),
        .car_yellow(car_yellow),
        .car_green(car_green),
        .ped_red(ped_red),
        .ped_green(ped_green)
    );

    seven_seg_display u_disp (
        .clk(clk),
        .rst(rst),
        .state(state),
        .count(count),
        .seg(seg),
        .an(an)
    );

endmodule