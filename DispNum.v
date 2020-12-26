`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:42 12/02/2020 
// Design Name: 
// Module Name:    DispNum 
// Project Name: 
// Target Devices: kintex7
// Tool versions: 
// Description: 这个是板子上
//    clock是时钟脉冲信号
//    HEX是4个16进制数字
//    LES控制4个数字是否禁用，1禁用0启用
//    points控制小数点是否亮，1亮0不亮
//    RST是时钟信号的一部分，把时钟信号清零，没啥用，给他0就行了。
//    SEGMENT是输出的显示信号
/*
NET "SEGMENT[0]" LOC=AB22| IOSTANDARD = LVCMOS33;	#a
NET "SEGMENT[1]" LOC=AD24| IOSTANDARD = LVCMOS33;	#b
NET "SEGMENT[2]" LOC=AD23| IOSTANDARD = LVCMOS33;
NET "SEGMENT[3]" LOC=Y21| IOSTANDARD = LVCMOS33;
NET "SEGMENT[4]" LOC=W20| IOSTANDARD = LVCMOS33;
NET "SEGMENT[5]" LOC=AC24| IOSTANDARD = LVCMOS33;
NET "SEGMENT[6]" LOC=AC23| IOSTANDARD = LVCMOS33;	#g
NET "SEGMENT[7]" LOC=AA22| IOSTANDARD = LVCMOS33;	#point
*/
// Dependencies: 无
//////////////////////////////////////////////////////////////////////////////////
 module DispNum(clock, 
                HEXS, 
                LES, 
                points, 
                RST, 
                AN, 
                SEGMENT);

    input clock;
    input [15:0] HEXS;
    input [3:0] LES;
    input [3:0] points;
    input RST;
   output [3:0] AN;
   output [7:0] SEGMENT;
   
   wire [31:0] clk;
   wire [3:0] hex;
   wire XLXN_24;
   wire XLXN_25;
   
   clkdiv  XLXI_1 (.clk(clock), 
                  .rst(RST), 
                  .clkdiv(clk[31:0]));
   MyMC14495_MUSER_disp_num  XLXI_4 (.D0(hex[0]), 
                                    .D1(hex[1]), 
                                    .D2(hex[2]), 
                                    .D3(hex[3]), 
                                    .LE(XLXN_24), 
                                    .point(XLXN_25), 
                                    .a(SEGMENT[0]), 
                                    .b(SEGMENT[1]), 
                                    .c(SEGMENT[2]), 
                                    .d(SEGMENT[3]), 
                                    .e(SEGMENT[4]), 
                                    .f(SEGMENT[5]), 
                                    .g(SEGMENT[6]), 
                                    .P(SEGMENT[7]));
   DisplaySync_MUSER_disp_num  XLXI_6 (.Hexss(HEXS[15:0]), 
                                      .LED(LES[3:0]), 
                                      .point(points[3:0]), 
                                      .Scan(clk[18:17]), 
                                      .AN(AN[3:0]), 
                                      .Hex(hex[3:0]), 
                                      .LE(XLXN_24), 
                                      .p(XLXN_25));
endmodule


`timescale  100 ps / 10 ps

module D2_4E_HXILINX_disp_num (D0, D1, D2, D3, A0, A1, E);
    

   output D0;
   output D1;
   output D2;
   output D3;

   input  A0;
   input  A1;
   input  E;
  
   reg D0;
   reg D1;
   reg D2;
   reg D3;

      always @ (A0 or A1 or E)
      begin
         if(!E)
           {D3, D2, D1, D0} <= 4'b0000;
        else
        begin
           case({A1,A0})
             2'b00 : {D3,D2,D1,D0} <= 4'b0001;
             2'b01 : {D3,D2,D1,D0} <= 4'b0010;
             2'b10 : {D3,D2,D1,D0} <= 4'b0100;
             2'b11 : {D3,D2,D1,D0} <= 4'b1000;
          endcase
        end
     end 

endmodule
`timescale 1ns / 1ps

module MUX4to1b1_MUSER_disp_num(In1, 
                                In2, 
                                In3, 
                                In4, 
                                S, 
                                Output);

    input In1;
    input In2;
    input In3;
    input In4;
    input [1:0] S;
   output Output;
   
   wire XLXN_12;
   wire XLXN_17;
   wire XLXN_28;
   wire XLXN_29;
   wire XLXN_30;
   wire XLXN_31;
   wire XLXN_87;
   wire XLXN_88;
   wire XLXN_89;
   wire XLXN_90;
   
   AND2  XLXI_1 (.I0(XLXN_12), 
                .I1(XLXN_17), 
                .O(XLXN_87));
   AND2  XLXI_2 (.I0(XLXN_12), 
                .I1(S[0]), 
                .O(XLXN_88));
   AND2  XLXI_3 (.I0(S[1]), 
                .I1(XLXN_17), 
                .O(XLXN_89));
   AND2  XLXI_4 (.I0(S[1]), 
                .I1(S[0]), 
                .O(XLXN_90));
   INV  XLXI_5 (.I(S[0]), 
               .O(XLXN_17));
   INV  XLXI_6 (.I(S[1]), 
               .O(XLXN_12));
   AND2  XLXI_7 (.I0(In1), 
                .I1(XLXN_87), 
                .O(XLXN_28));
   AND2  XLXI_11 (.I0(In2), 
                 .I1(XLXN_88), 
                 .O(XLXN_29));
   AND2  XLXI_12 (.I0(In3), 
                 .I1(XLXN_89), 
                 .O(XLXN_30));
   AND2  XLXI_13 (.I0(In4), 
                 .I1(XLXN_90), 
                 .O(XLXN_31));
   OR4  XLXI_26 (.I0(XLXN_31), 
                .I1(XLXN_30), 
                .I2(XLXN_29), 
                .I3(XLXN_28), 
                .O(Output));
endmodule
`timescale 1ns / 1ps

module DisplaySync_MUSER_disp_num(Hexss, 
                                  LED, 
                                  point, 
                                  Scan, 
                                  AN, 
                                  Hex, 
                                  LE, 
                                  p);

    input [15:0] Hexss;
    input [3:0] LED;
    input [3:0] point;
    input [1:0] Scan;
   output [3:0] AN;
   output [3:0] Hex;
   output LE;
   output p;
   
   wire XLXN_32;
   wire XLXN_33;
   wire XLXN_34;
   wire XLXN_35;
   wire XLXN_36;
   
   MUX4to1b1_MUSER_disp_num  XLXI_1 (.In1(point[0]), 
                                    .In2(point[1]), 
                                    .In3(point[2]), 
                                    .In4(point[3]), 
                                    .S(Scan[1:0]), 
                                    .Output(p));
   MUX4to1b4  XLXI_2 (.IN0(Hexss[3:0]), 
                     .IN1(Hexss[7:4]), 
                     .IN2(Hexss[11:8]), 
                     .IN3(Hexss[15:12]), 
                     .S(Scan[1:0]), 
                     .D(Hex[3:0]));
   MUX4to1b1_MUSER_disp_num  XLXI_4 (.In1(LED[0]), 
                                    .In2(LED[1]), 
                                    .In3(LED[2]), 
                                    .In4(LED[3]), 
                                    .S(Scan[1:0]), 
                                    .Output(LE));
   (* HU_SET = "XLXI_7_0" *) 
   D2_4E_HXILINX_disp_num  XLXI_7 (.A0(Scan[0]), 
                                  .A1(Scan[1]), 
                                  .E(XLXN_32), 
                                  .D0(XLXN_33), 
                                  .D1(XLXN_34), 
                                  .D2(XLXN_35), 
                                  .D3(XLXN_36));
   VCC  XLXI_8 (.P(XLXN_32));
   INV  XLXI_9 (.I(XLXN_33), 
               .O(AN[0]));
   INV  XLXI_10 (.I(XLXN_34), 
                .O(AN[1]));
   INV  XLXI_11 (.I(XLXN_35), 
                .O(AN[2]));
   INV  XLXI_12 (.I(XLXN_36), 
                .O(AN[3]));
endmodule
`timescale 1ns / 1ps

module MyMC14495_MUSER_disp_num(D0, 
                                D1, 
                                D2, 
                                D3, 
                                LE, 
                                point, 
                                a, 
                                b, 
                                c, 
                                d, 
                                e, 
                                f, 
                                g, 
                                P);

    input D0;
    input D1;
    input D2;
    input D3;
    input LE;
    input point;
   output a;
   output b;
   output c;
   output d;
   output e;
   output f;
   output g;
   output P;
   
   wire XLXN_19;
   wire XLXN_38;
   wire XLXN_39;
   wire XLXN_40;
   wire XLXN_57;
   wire XLXN_58;
   wire XLXN_59;
   wire XLXN_61;
   wire XLXN_66;
   wire XLXN_67;
   wire XLXN_68;
   wire XLXN_69;
   wire XLXN_70;
   wire XLXN_72;
   wire XLXN_73;
   wire XLXN_74;
   wire XLXN_75;
   wire XLXN_82;
   wire XLXN_83;
   wire XLXN_84;
   wire XLXN_85;
   wire XLXN_86;
   wire XLXN_87;
   wire XLXN_88;
   wire XLXN_89;
   wire XLXN_90;
   wire XLXN_91;
   wire XLXN_92;
   wire XLXN_95;
   wire XLXN_96;
   wire XLXN_97;
   wire XLXN_98;
   wire XLXN_102;
   wire XLXN_103;
   wire XLXN_104;
   wire XLXN_105;
   
   INV  XLXI_1 (.I(point), 
               .O(P));
   OR2  XLXI_2 (.I0(LE), 
               .I1(XLXN_91), 
               .O(g));
   OR2  XLXI_3 (.I0(LE), 
               .I1(XLXN_92), 
               .O(f));
   OR2  XLXI_4 (.I0(LE), 
               .I1(XLXN_90), 
               .O(e));
   OR2  XLXI_5 (.I0(LE), 
               .I1(XLXN_89), 
               .O(d));
   OR2  XLXI_6 (.I0(LE), 
               .I1(XLXN_75), 
               .O(c));
   OR2  XLXI_7 (.I0(LE), 
               .I1(XLXN_66), 
               .O(b));
   OR2  XLXI_8 (.I0(LE), 
               .I1(XLXN_19), 
               .O(a));
   OR4  XLXI_11 (.I0(XLXN_38), 
                .I1(XLXN_39), 
                .I2(XLXN_40), 
                .I3(XLXN_57), 
                .O(XLXN_19));
   INV  XLXI_12 (.I(D1), 
                .O(XLXN_59));
   INV  XLXI_13 (.I(D0), 
                .O(XLXN_58));
   INV  XLXI_16 (.I(D2), 
                .O(XLXN_105));
   INV  XLXI_17 (.I(D3), 
                .O(XLXN_61));
   AND4  XLXI_18 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(XLXN_59), 
                 .I3(D0), 
                 .O(XLXN_57));
   AND4  XLXI_19 (.I0(XLXN_61), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(XLXN_58), 
                 .O(XLXN_40));
   AND4  XLXI_21 (.I0(D3), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(D0), 
                 .O(XLXN_39));
   AND4  XLXI_22 (.I0(D3), 
                 .I1(XLXN_105), 
                 .I2(D1), 
                 .I3(D0), 
                 .O(XLXN_38));
   AND4  XLXI_31 (.I0(XLXN_61), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(D0), 
                 .O(XLXN_67));
   AND3  XLXI_32 (.I0(D2), 
                 .I1(D1), 
                 .I2(XLXN_58), 
                 .O(XLXN_68));
   AND3  XLXI_33 (.I0(D3), 
                 .I1(D1), 
                 .I2(D0), 
                 .O(XLXN_69));
   AND3  XLXI_34 (.I0(D3), 
                 .I1(D2), 
                 .I2(XLXN_58), 
                 .O(XLXN_70));
   OR4  XLXI_35 (.I0(XLXN_70), 
                .I1(XLXN_69), 
                .I2(XLXN_68), 
                .I3(XLXN_67), 
                .O(XLXN_66));
   AND4  XLXI_36 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(D1), 
                 .I3(XLXN_58), 
                 .O(XLXN_72));
   AND3  XLXI_37 (.I0(D3), 
                 .I1(D2), 
                 .I2(D1), 
                 .O(XLXN_73));
   AND3  XLXI_38 (.I0(D3), 
                 .I1(D2), 
                 .I2(XLXN_58), 
                 .O(XLXN_74));
   OR3  XLXI_39 (.I0(XLXN_74), 
                .I1(XLXN_73), 
                .I2(XLXN_72), 
                .O(XLXN_75));
   AND4  XLXI_41 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(XLXN_59), 
                 .I3(D0), 
                 .O(XLXN_85));
   AND4  XLXI_42 (.I0(XLXN_61), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(XLXN_58), 
                 .O(XLXN_86));
   AND4  XLXI_43 (.I0(D3), 
                 .I1(XLXN_105), 
                 .I2(D1), 
                 .I3(XLXN_58), 
                 .O(XLXN_87));
   AND3  XLXI_44 (.I0(D2), 
                 .I1(D1), 
                 .I2(D0), 
                 .O(XLXN_88));
   AND2  XLXI_45 (.I0(XLXN_61), 
                 .I1(D0), 
                 .O(XLXN_82));
   AND3  XLXI_46 (.I0(XLXN_61), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .O(XLXN_83));
   AND3  XLXI_47 (.I0(XLXN_105), 
                 .I1(XLXN_59), 
                 .I2(D0), 
                 .O(XLXN_84));
   OR3  XLXI_48 (.I0(XLXN_84), 
                .I1(XLXN_83), 
                .I2(XLXN_82), 
                .O(XLXN_90));
   OR4  XLXI_49 (.I0(XLXN_88), 
                .I1(XLXN_87), 
                .I2(XLXN_86), 
                .I3(XLXN_85), 
                .O(XLXN_89));
   OR4  XLXI_50 (.I0(XLXN_98), 
                .I1(XLXN_97), 
                .I2(XLXN_96), 
                .I3(XLXN_95), 
                .O(XLXN_92));
   OR3  XLXI_51 (.I0(XLXN_104), 
                .I1(XLXN_103), 
                .I2(XLXN_102), 
                .O(XLXN_91));
   AND3  XLXI_52 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(D1), 
                 .O(XLXN_95));
   AND3  XLXI_53 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(D0), 
                 .O(XLXN_96));
   AND3  XLXI_54 (.I0(XLXN_61), 
                 .I1(D1), 
                 .I2(D0), 
                 .O(XLXN_97));
   AND4  XLXI_55 (.I0(D3), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(D0), 
                 .O(XLXN_98));
   AND4  XLXI_56 (.I0(D3), 
                 .I1(D2), 
                 .I2(XLXN_59), 
                 .I3(XLXN_58), 
                 .O(XLXN_102));
   AND4  XLXI_57 (.I0(XLXN_61), 
                 .I1(D2), 
                 .I2(D1), 
                 .I3(D0), 
                 .O(XLXN_103));
   AND3  XLXI_58 (.I0(XLXN_61), 
                 .I1(XLXN_105), 
                 .I2(XLXN_59), 
                 .O(XLXN_104));
endmodule



module MUX4to1b4(IN0, 
                 IN1, 
                 IN2, 
                 IN3, 
                 S, 
                 D);

    input [3:0] IN0;
    input [3:0] IN1;
    input [3:0] IN2;
    input [3:0] IN3;
    input [1:0] S;
   output [3:0] D;
   
   wire XLXN_12;
   wire XLXN_17;
   wire XLXN_28;
   wire XLXN_29;
   wire XLXN_30;
   wire XLXN_31;
   wire XLXN_36;
   wire XLXN_37;
   wire XLXN_38;
   wire XLXN_39;
   wire XLXN_40;
   wire XLXN_41;
   wire XLXN_42;
   wire XLXN_43;
   wire XLXN_44;
   wire XLXN_45;
   wire XLXN_46;
   wire XLXN_47;
   wire XLXN_66;
   wire XLXN_67;
   wire XLXN_68;
   wire XLXN_69;
   
   AND2  XLXI_1 (.I0(XLXN_12), 
                .I1(XLXN_17), 
                .O(XLXN_66));
   AND2  XLXI_2 (.I0(XLXN_12), 
                .I1(S[0]), 
                .O(XLXN_67));
   AND2  XLXI_3 (.I0(S[1]), 
                .I1(XLXN_17), 
                .O(XLXN_68));
   AND2  XLXI_4 (.I0(S[1]), 
                .I1(S[0]), 
                .O(XLXN_69));
   INV  XLXI_5 (.I(S[0]), 
               .O(XLXN_17));
   INV  XLXI_6 (.I(S[1]), 
               .O(XLXN_12));
   AND2  XLXI_7 (.I0(XLXN_66), 
                .I1(IN0[0]), 
                .O(XLXN_28));
   AND2  XLXI_11 (.I0(XLXN_67), 
                 .I1(IN1[0]), 
                 .O(XLXN_29));
   AND2  XLXI_12 (.I0(XLXN_68), 
                 .I1(IN2[0]), 
                 .O(XLXN_30));
   AND2  XLXI_13 (.I0(XLXN_69), 
                 .I1(IN3[0]), 
                 .O(XLXN_31));
   OR4  XLXI_26 (.I0(XLXN_31), 
                .I1(XLXN_30), 
                .I2(XLXN_29), 
                .I3(XLXN_28), 
                .O(D[0]));
   AND2  XLXI_32 (.I0(XLXN_66), 
                 .I1(IN0[1]), 
                 .O(XLXN_36));
   AND2  XLXI_33 (.I0(XLXN_67), 
                 .I1(IN1[1]), 
                 .O(XLXN_37));
   AND2  XLXI_34 (.I0(XLXN_68), 
                 .I1(IN2[1]), 
                 .O(XLXN_38));
   AND2  XLXI_35 (.I0(XLXN_69), 
                 .I1(IN3[1]), 
                 .O(XLXN_39));
   OR4  XLXI_36 (.I0(XLXN_39), 
                .I1(XLXN_38), 
                .I2(XLXN_37), 
                .I3(XLXN_36), 
                .O(D[1]));
   AND2  XLXI_37 (.I0(XLXN_66), 
                 .I1(IN0[2]), 
                 .O(XLXN_40));
   AND2  XLXI_38 (.I0(XLXN_67), 
                 .I1(IN1[2]), 
                 .O(XLXN_41));
   AND2  XLXI_39 (.I0(XLXN_68), 
                 .I1(IN2[2]), 
                 .O(XLXN_42));
   AND2  XLXI_40 (.I0(XLXN_69), 
                 .I1(IN3[2]), 
                 .O(XLXN_43));
   OR4  XLXI_41 (.I0(XLXN_43), 
                .I1(XLXN_42), 
                .I2(XLXN_41), 
                .I3(XLXN_40), 
                .O(D[2]));
   AND2  XLXI_42 (.I0(XLXN_66), 
                 .I1(IN0[3]), 
                 .O(XLXN_44));
   AND2  XLXI_43 (.I0(XLXN_67), 
                 .I1(IN1[3]), 
                 .O(XLXN_45));
   AND2  XLXI_44 (.I0(XLXN_68), 
                 .I1(IN2[3]), 
                 .O(XLXN_46));
   AND2  XLXI_45 (.I0(XLXN_69), 
                 .I1(IN3[3]), 
                 .O(XLXN_47));
   OR4  XLXI_46 (.I0(XLXN_47), 
                .I1(XLXN_46), 
                .I2(XLXN_45), 
                .I3(XLXN_44), 
                .O(D[3]));
endmodule
