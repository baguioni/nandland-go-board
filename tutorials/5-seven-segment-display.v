module seven_segment_display(
    input i_Clk, i_Switch_1, 
    output o_Segment2_A, o_Segment2_B,o_Segment2_C,o_Segment2_D,o_Segment2_E, o_Segment2_F,o_Segment2_G
);
    reg r_Switch = 1'b0;
    wire w_Switch;
    reg [3:0] number = 4'b0000;

    wire w_Segment2_A, w_Segment2_B, w_Segment2_C, w_Segment2_D, w_Segment2_E, w_Segment2_F, w_Segment2_G;

    debounce_logic dl_unit(
        .i_Clk(i_Clk),  
        .i_Switch_1(i_Switch_1),
        .o_Switch_1(w_Switch)
    );

    always @(posedge i_Clk) begin
        r_Switch <= w_Switch;

        // if button is pressed
        if (w_Switch == 1'b1 && r_Switch == 1'b0) begin
        
            if (number == 9) begin
                number <= 0;
            end else begin
                number <= number + 1;
            end
        end
    end

    binary_to_seven_segment bss_unit(
        .i_Clk(i_Clk),
        .i_Number(number),
        .o_Segment2_A(w_Segment2_A),
        .o_Segment2_B(w_Segment2_B),
        .o_Segment2_C(w_Segment2_C),
        .o_Segment2_D(w_Segment2_D),
        .o_Segment2_E(w_Segment2_E),
        .o_Segment2_F(w_Segment2_F),
        .o_Segment2_G(w_Segment2_G)
    );

    assign o_Segment2_A = ~w_Segment2_A;
    assign o_Segment2_B = ~w_Segment2_B;
    assign o_Segment2_C = ~w_Segment2_C;
    assign o_Segment2_D = ~w_Segment2_D;
    assign o_Segment2_E = ~w_Segment2_E;
    assign o_Segment2_F = ~w_Segment2_F;
    assign o_Segment2_G = ~w_Segment2_G;
endmodule

module binary_to_seven_segment(
    input i_Clk,
    input [3:0] i_Number,
    output o_Segment2_A, o_Segment2_B, o_Segment2_C, o_Segment2_D, o_Segment2_E, o_Segment2_F, o_Segment2_G
);

    reg [6:0] hex_encoding = 7'h00;

    always @(posedge i_Clk) begin
        case(i_Number)
            4'b0000 : hex_encoding <= 7'h7E;
            4'b0001 : hex_encoding <= 7'h30;
            4'b0010 : hex_encoding <= 7'h6D;
            4'b0011 : hex_encoding <= 7'h79;
            4'b0100 : hex_encoding <= 7'h33;          
            4'b0101 : hex_encoding <= 7'h5B;
            4'b0110 : hex_encoding <= 7'h5F;
            4'b0111 : hex_encoding <= 7'h70;
            4'b1000 : hex_encoding <= 7'h7F;
            4'b1001 : hex_encoding <= 7'h7B;
            4'b1010 : hex_encoding <= 7'h77;
            4'b1011 : hex_encoding <= 7'h1F;
            4'b1100 : hex_encoding <= 7'h4E;
            4'b1101 : hex_encoding <= 7'h3D;
            4'b1110 : hex_encoding <= 7'h4F;
            4'b1111 : hex_encoding <= 7'h47;
        endcase
    end

    assign o_Segment2_A = hex_encoding[6];
    assign o_Segment2_B = hex_encoding[5];
    assign o_Segment2_C = hex_encoding[4];
    assign o_Segment2_D = hex_encoding[3];
    assign o_Segment2_E = hex_encoding[2];
    assign o_Segment2_F = hex_encoding[1];
    assign o_Segment2_G = hex_encoding[0];
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