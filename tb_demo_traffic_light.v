//=====================================================================
// File : tb_demo_traffic_light.v
// PURPOSE:
// PROFESSIONAL DEMO TESTBENCH
//
// This testbench clearly shows:
//
// TESTCASE 1 -> NORMAL STATE SEQUENCE
// TESTCASE 2 -> PEDESTRIAN BUTTON
// TESTCASE 3 -> EMERGENCY BUTTON
// TESTCASE 4 -> MULTIPLE BUTTON EVENTS
//
// Waveform will clearly show:
//
// 1 -> CAR GREEN
// 2 -> CAR YELLOW
// 3 -> PEDESTRIAN WALK
//
// Button press timings are clearly visible
//=====================================================================

`timescale 1ns/1ps

module tb_demo_traffic_light;

    //---------------------------------------------------------
    // INPUTS
    //---------------------------------------------------------
    reg clk;
    reg rst;
    reg ped_btn;
    reg emer_btn;

    //---------------------------------------------------------
    // OUTPUTS
    //---------------------------------------------------------
    wire car_red;
    wire car_yellow;
    wire car_green;

    wire ped_red;
    wire ped_green;

    wire [6:0] seg;
    wire [3:0] an;

    //---------------------------------------------------------
    // DUT
    //---------------------------------------------------------
    traffic_light_top DUT (
        .clk(clk),
        .rst(rst),
        .ped_btn(ped_btn),
        .emer_btn(emer_btn),

        .car_red(car_red),
        .car_yellow(car_yellow),
        .car_green(car_green),

        .ped_red(ped_red),
        .ped_green(ped_green),

        .seg(seg),
        .an(an)
    );

    //---------------------------------------------------------
    // CLOCK
    //---------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //---------------------------------------------------------
    // FAST 1-SECOND TICK
    //---------------------------------------------------------
    initial begin

        forever begin

            #100;

            force DUT.u_tick.tick_1s = 1'b1;

            #10;

            force DUT.u_tick.tick_1s = 1'b0;

        end

    end

    //---------------------------------------------------------
    // TESTCASE DISPLAY
    //---------------------------------------------------------
    initial begin

        $display("\n=================================================");
        $display(" SMART TRAFFIC LIGHT CONTROLLER TESTBENCH ");
        $display("=================================================");

        $display("TIME\tSTATE\tCR CY CG\tPR PG");

        forever begin

            #100;

            $display("%0t\t%0d\t%b  %b  %b\t%b  %b",
                    $time,
                    DUT.u_fsm.state,
                    car_red,
                    car_yellow,
                    car_green,
                    ped_red,
                    ped_green);

        end

    end

    //---------------------------------------------------------
    // MAIN TESTCASE SEQUENCE
    //---------------------------------------------------------
    initial begin

        //-----------------------------------------------------
        // INITIAL VALUES
        //-----------------------------------------------------
        rst       = 1;
        ped_btn   = 0;
        emer_btn  = 0;

        //-----------------------------------------------------
        // RESET
        //-----------------------------------------------------
        #50;
        rst = 0;

        //-----------------------------------------------------
        //=====================================================
        // TESTCASE 1
        // NORMAL STATE SEQUENCE
        //=====================================================
        //-----------------------------------------------------

        $display("\n");
        $display("==========================================");
        $display(" TESTCASE 1 : NORMAL STATE SEQUENCE ");
        $display("==========================================");
        $display("EXPECTED:");
        $display("STATE 0 -> CAR GREEN");
        $display("STATE 1 -> CAR YELLOW");
        $display("STATE 2 -> PEDESTRIAN");
        $display("==========================================");

        // Let FSM run naturally
        #1800;

        //-----------------------------------------------------
        //=====================================================
        // TESTCASE 2
        // PEDESTRIAN BUTTON PRESS
        //=====================================================
        //-----------------------------------------------------

        $display("\n");
        $display("==========================================");
        $display(" TESTCASE 2 : PEDESTRIAN BUTTON ");
        $display("==========================================");

        // Press pedestrian button
        ped_btn = 1;

        $display("PED BUTTON PRESSED");

        #80;

        ped_btn = 0;

        $display("PED BUTTON RELEASED");

        #1800;

        //-----------------------------------------------------
        //=====================================================
        // TESTCASE 3
        // EMERGENCY BUTTON PRESS
        //=====================================================
        //-----------------------------------------------------

        $display("\n");
        $display("==========================================");
        $display(" TESTCASE 3 : EMERGENCY BUTTON ");
        $display("==========================================");

        emer_btn = 1;

        $display("EMERGENCY BUTTON PRESSED");

        #80;

        emer_btn = 0;

        $display("EMERGENCY BUTTON RELEASED");

        #1800;

        //-----------------------------------------------------
        //=====================================================
        // TESTCASE 4
        // MULTIPLE EVENTS
        //=====================================================
        //-----------------------------------------------------

        $display("\n");
        $display("==========================================");
        $display(" TESTCASE 4 : MULTIPLE EVENTS ");
        $display("==========================================");

        // Pedestrian first
        ped_btn = 1;

        $display("PED BUTTON PRESSED");

        #60;

        ped_btn = 0;

        #600;

        // Emergency after pedestrian
        emer_btn = 1;

        $display("EMERGENCY BUTTON PRESSED");

        #60;

        emer_btn = 0;

        #1800;

        //-----------------------------------------------------
        // END
        //-----------------------------------------------------

        $display("\n");
        $display("==========================================");
        $display(" ALL TESTCASES COMPLETED ");
        $display("==========================================");

        $finish;

    end

endmodule