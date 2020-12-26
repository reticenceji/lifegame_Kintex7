//SWORD平台板载100M时钟振荡器（U38），单端接入到FPGA的AC18管脚
//所以给 clk引脚约束为AC18
module clkdiv(
    input clk,
    input rst,
    output reg[31:0]clkdiv
);

    always @ (posedge clk or posedge rst) begin
        if (rst) clkdiv <= 0;
        else clkdiv <= clkdiv + 1'b1;
    end
endmodule