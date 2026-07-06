module traffic_fsm_counter (
    input  wire clk,
    input  wire rst,
    input  wire tick_1s,
    input  wire ped_req,

    output reg  [3:0] ped_count,
    output reg  ped_active,

    output reg car_red,
    output reg car_yellow,
    output reg car_green,
    output reg ped_red,
    output reg ped_green
);

    localparam CAR_GREEN  = 2'd0,
               CAR_YELLOW = 2'd1,
               CAR_RED    = 2'd2,
               PED_GREEN  = 2'd3;

    reg [1:0] state, next_state;
    reg [3:0] sec_cnt;

    always @(posedge clk or posedge rst)
        if (rst) state <= CAR_GREEN;
        else state <= next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            sec_cnt <= 0;
        else if (state != next_state)
            sec_cnt <= 0;
        else if (tick_1s)
            sec_cnt <= sec_cnt + 1;
    end

    always @(*) begin
        next_state = state;
        case (state)
            CAR_GREEN:
                if (ped_req) next_state = PED_GREEN;
                else if (sec_cnt == 5) next_state = CAR_YELLOW;

            CAR_YELLOW:
                if (sec_cnt == 3) next_state = CAR_RED;

            CAR_RED:
                if (sec_cnt == 5) next_state = CAR_GREEN;

            PED_GREEN:
                if (sec_cnt == 8) next_state = CAR_GREEN;
        endcase
    end

    always @(*) begin
        car_red = 0; car_yellow = 0; car_green = 0;
        ped_red = 1; ped_green = 0;
        ped_active = 0;
        ped_count = 0;

        case (state)
            CAR_GREEN:  car_green = 1;
            CAR_YELLOW: car_yellow = 1;
            CAR_RED:    car_red = 1;

            PED_GREEN: begin
                car_red = 1;
                ped_red = 0;
                ped_green = 1;
                ped_active = 1;
                ped_count = 8 - sec_cnt;
            end
        endcase
    end
endmodule