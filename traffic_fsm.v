module traffic_fsm (
    input  wire clk,
    input  wire rst,
    input  wire tick_1s,
    input  wire ped_req,
    input  wire emer_req,

    output reg [2:0] state,
    output reg [3:0] count,

    output reg car_red,
    output reg car_yellow,
    output reg car_green,
    output reg ped_red,
    output reg ped_green
);

    localparam CAR_GO   = 3'd0,
               CAR_WAIT = 3'd1,
               CAR_STOP = 3'd2,
               PED_GO   = 3'd3,
               EMER     = 3'd4;

    reg [3:0] sec_cnt;

    // ? FAST BLINK (~10Hz)
    reg blink_fast;
    reg [22:0] fast_cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fast_cnt   <= 0;
            blink_fast <= 0;
        end else begin
            if (fast_cnt == 5_000_000-1) begin
                fast_cnt   <= 0;
                blink_fast <= ~blink_fast;
            end else
                fast_cnt <= fast_cnt + 1;
        end
    end

    // FSM
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= CAR_GO;
            sec_cnt <= 0;
        end else begin

            // ? Emergency = highest priority
            if (emer_req && state != EMER) begin
                state   <= EMER;
                sec_cnt <= 0;
            end

            // ? Pedestrian priority
            else if (ped_req && state != PED_GO) begin
                state   <= PED_GO;
                sec_cnt <= 0;
            end

            else if (tick_1s) begin
                sec_cnt <= sec_cnt + 1;

                case (state)
                    CAR_GO:   if (sec_cnt == 4) begin state <= CAR_WAIT; sec_cnt <= 0; end
                    CAR_WAIT: if (sec_cnt == 2) begin state <= CAR_STOP; sec_cnt <= 0; end
                    CAR_STOP: if (sec_cnt == 4) begin state <= CAR_GO;   sec_cnt <= 0; end
                    PED_GO:   if (sec_cnt == 7) begin state <= CAR_GO;   sec_cnt <= 0; end
                    EMER:     if (sec_cnt == 4) begin state <= CAR_GO;   sec_cnt <= 0; end
                endcase
            end
        end
    end

    // OUTPUT LOGIC
    always @(*) begin
        car_red = 0; car_yellow = 0; car_green = 0;
        ped_red = 1; ped_green = 0;
        count   = 0;

        case (state)
            CAR_GO: begin
                car_green = 1;
                count = 5 - sec_cnt;
            end
            CAR_WAIT: begin
                car_yellow = 1;
                count = 3 - sec_cnt;
            end
            CAR_STOP: begin
                car_red = 1;
                count = 5 - sec_cnt;
            end
            PED_GO: begin
                car_red   = 1;
                ped_red   = 0;
                ped_green = 1;
                count = 8 - sec_cnt;
            end
            EMER: begin
                car_red = blink_fast;   // ? FAST BLINK
                ped_red = 1;
                count   = 5 - sec_cnt;
            end
        endcase
    end

endmodule