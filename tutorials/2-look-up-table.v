module and_gate(input i_Switch_1, i_Switch_2, output o_LED_1);

    // bit wise operator
    // AND operation is synthesized as a look up table (LUT) in the FPGA
    assign o_LED_1 = i_Switch_1 & i_Switch_2;

endmodule