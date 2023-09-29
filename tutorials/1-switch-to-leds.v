/*
    The inputs and outputs are not arbitrarily named.
    These come from the `Go_Board_Constraints.pcf` file.
*/
module switches_to_leds(
    input i_Switch_1, i_Switch_2, i_Switch_3, i_Switch_4,
    output o_LED_1, o_LED_2, o_LED_3, o_LED_4
);
    // blocking assignment
    assign o_LED_1 = i_Switch_1;
    assign o_LED_2 = i_Switch_2;
    assign o_LED_3 = i_Switch_3;
    assign o_LED_4 = i_Switch_4;

endmodule