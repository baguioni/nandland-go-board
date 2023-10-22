module clocked_logic(
    input i_Clk,
    input i_Switch_1,
    output o_LED_1
);
    reg r_Switch_1 = 1'b0;
    reg r_LED_1 = 1'b0;
    wire w_Switch_1;

    debounce_logic dlu(
        .i_Clk(i_Clk),
        .i_Switch_1(i_Switch_1),
        .o_Switch_1(w_Switch_1)
    );

    always @(posedge i_Clk) begin
        // Creates a register 
        r_Switch_1 <= w_Switch_1; 

        // Falling edge
       if (w_Switch_1 == 1'b0 && r_Switch_1 == 1'b1) begin 
            r_LED_1 <= ~r_LED_1;
       end
    end

    assign o_LED_1 = r_LED_1;
endmodule

module debounce_logic(
    input i_Clk,
    input i_Switch_1,
    output o_Switch_1
);
    parameter DEBOUNCE_LIMIT = 250000; // 10ms at 25 MHz

    reg [17:0] count = 0;
    reg r_State = 1'b0;

    always @(posedge i_Clk) begin
        if (i_Switch_1 !== r_State && count < DEBOUNCE_LIMIT) begin
            count <= count + 1;
        end else if (count == DEBOUNCE_LIMIT) begin
            r_State <= i_Switch_1;
            count <= 0;
        end else begin
            count <= 0;
        end
    end

    assign o_Switch_1 = r_State;

endmodule