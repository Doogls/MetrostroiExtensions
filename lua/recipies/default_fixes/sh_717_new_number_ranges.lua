-- Copyright (C) 2025 Anatoly Raev
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

MEL.DefineRecipe("717_new_number_ranges", "gmod_subway_81-717_mvm")
function RECIPE:Inject(ent)
    -- некрасиво? да.
    if MEL.Debug then
        ent.NumberRanges = {
            --717 МВМ
            {
                true,
                {0001,0003,0002,0004,0007,0008,0009,0010,0011,0012,0013,0014,0015,0015,0016,0017,0018,0019,0020,0021,0022,0023,0044,0045,0046,0047,0048,0049,0050,0051,0052,0053,0054,0055,0056,0066,0068,0069,0070,0071,0072,0073,0078,0080,0084,0085,0086,0123,0124,0125,0126,0127,0128,0130,0131,0132,0133,0134,0135,0136,0137,0138,0139,0140,0141,0142,0143,0144,0145,0146,0147,0148,0149,0150,0151,0152,0153},
                {false,false,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true}
            },
            {
                true,
                {9221,9239,9240,9247,9249,9278,9281,9284,9286,9290,9291,9339,9342,9347,9193,9194,9196,9234,9235,9241,9242,9243,9244,9269,9274,9277,9280,9282,9283,9287,9288,9293,9311,9312,9314,9338},
                {false,false,false,true,{"Def_717MSKBlue","Def_717MSKWhite",--[[ "Def_717MSKWood",--]] "Def_717MSKWood2"},function(id,tex) return tex=="Def_717MSKWhite" or math.random()>0.5 end}
            },
            --717 ЛВЗ
            {
                true,
                {8459,8460,8462,8465,8502,8508,8509,8511,8512,8513,8514,8518,8522,8523,8526,8528,8529,8532,8533,8534,8538,8548,8549,8550,8554,8555,8557,8560,8596,8597,8516,8517,8519,8520,8521,8524,8525,8530,8531,8536,8547,8551,8552,8553,8559,8561,8586,8587,8611,8612,8613,8614,8615,8616,8617,8618,8619,8620,8621,8705,8706,8707,8708,8709,8710,8711,8713,8714,8716,8717,8719,8720,8721,8722,8723,8725,8726,8727,8728,8730,8731,8732,8733,8734,8745,8746,8753,8760,8791,8792,8802,8803,8816,8828,8829,8831},
                { true,false,false,false,{"Def_717MSKWhite"},true}
            },
            --717.5 МВМ
            {
                true,
                {0154,0155,0156,0157,0158,0159,0160,0161,0162,0163,0164,0165,0166,0167,0168,0169,0170,0172,0174,0175,0177},
                {false, true,false,true,{"Def_717MSKWhite","Def_717MSKWood4"},true,true}
            },
            {
                true,
                {0218,0219,0220,0221,0222,0223,0224,0225,0226,0227,0228,0229,0236,0241,0242,0243,0244,0249,0254,0255,0263,0264,0265,0266,0267,0284,0285,0286,0287,0290,0292,0293,0294,0295,0297,0298,0299,0300,0301,0308,0315,0320,0333,0334},
                {false, true,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},true,true}
            },
            --717.5 ЛВЗ
            {
                true,
                {8876,8877,8881,8882,8883,8884,8885,8886,8891,8892,8893,8894,8931,8932,8933,8934,8935,8936,8937,8938,8939,8940,8941,8941,8942,8943,8944,8945,8946,8947,8965,8966,8967,8968,8969,3970,8983,8984,8985,8986,8987,8988,8989,8995,8996,8997,8998,8999},
                {true , true,false,true,{"Def_717MSKWhite","Def_717MSKWood4"},true,true}
            },
            {
                true,
                {10000,10001,10002,10008,10009,10010,10011,10012,10013,10035,10038,10039,10040,10057,10058,10059,10060,10077,10078,10079,10087,10088,10089,10090,10091,10092,10093,10094,10099,10100,10101,10102,10103,10106,10107,10108,10109,10113,10114,10115,10116,10118,10119,10120,10121,10122,10123,10131,10141,10142,10143,10144,10145,10146,10149,10150,10151,10152,10153,10154,10155,10156,10157,10158,10159,10160,10161,10164,10165,10166,10167,10168,10169,10170,10190,10191,10197,10199,10206,10207,10034},
                {true , true,true ,true,{"Def_717MSKWhite","Def_717MSKWood4"},function(id) return id<=10010 end,true}
            },
        }
    end
    -- 717 MVM
    table.Add(ent.NumberRanges[1][2], {0074, 0075, 0076, 0077})
    for i = 9301, 9326 do
        table.insert(ent.NumberRanges[2][2], i)
    end
    -- 717 LVZ
    table.Add(ent.NumberRanges[3][2], {8562, 8563})
    -- 717.5 LVZ
    table.Add(ent.NumberRanges[7][2], {10003, 10004, 10005, 10006, 10007})
    table.Add(ent.NumberRanges[7][2], {10311, 10312, 10313, 10314, 10315, 10316})
    table.Add(ent.NumberRanges[7][2], {0335, 0336, 10172, 10183, 10184, 10185, 10186, 10187, 10192, 10193})
    table.Add(ent.NumberRanges[7][2], {10208, 10209, 10210, 10211})
    for i = 10229, 10240 do
        table.insert(ent.NumberRanges[7][2], i)
    end
    for i = 8971, 8994 do
        table.insert(ent.NumberRanges[6][2], i)
    end
end
