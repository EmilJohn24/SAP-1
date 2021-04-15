library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram256x8 is
    Port ( nCE : in STD_LOGIC; -- enable memory output
           nWE : in STD_LOGIC; -- read/write, read if nWE = 1, write if nWE = 0
           addr : in STD_LOGIC_VECTOR (7 downto 0); -- connected to memaddreg
           clk : in STD_LOGIC; --clock
           data : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end ram256x8;

architecture sap1 of ram256x8 is
    type RAM_type is array (0 to 2**addr'length - 1) of std_logic_vector (7 downto 0);
    signal RAM : RAM_type := (
                              0 => x"EE",
                                1 => x"18",
                                2 => x"F0",
                                3 => x"EE",
                                4 => x"18",
                                5 => x"F1",
                                6 => x"10",
                                7 => x"F1",
                                8 => x"18",
                                9 => x"F2",
                                10 => x"22",
                                11 => x"08",
                                12 => x"10",
                                13 => x"F0",
                                14 => x"28",
                                15 => x"10",
                                16 => x"F2",
                                17 => x"38",
                                18 => x"01",
                                19 => x"D6",
                                20 => x"22",
                                21 => x"10",
                                22 => x"F4",
                                23 => x"38",
                                24 => x"01",
                                25 => x"D7",
                                26 => x"2D",
                                27 => x"10",
                                28 => x"F3",
                                29 => x"42",
                                30 => x"18",
                                31 => x"F3",
                                32 => x"D0",
                                33 => x"2D",
                                34 => x"10",
                                35 => x"F4",
                                36 => x"38",
                                37 => x"01",
                                38 => x"D6",
                                39 => x"2D",
                                40 => x"10",
                                41 => x"F3",
                                42 => x"40",
                                43 => x"18",
                                44 => x"F3",
                                45 => x"10",
                                46 => x"F3",
                                47 => x"38",
                                48 => x"80",
                                49 => x"D7",
                                50 => x"3A",
                                51 => x"10",
                                52 => x"F3",
                                53 => x"78",
                                54 => x"38",
                                55 => x"7F",
                                56 => x"D0",
                                57 => x"3F",
                                58 => x"10",
                                59 => x"F3",
                                60 => x"78",
                                61 => x"34",
                                62 => x"80",
                                63 => x"18",
                                64 => x"F5",
                                65 => x"10",
                                66 => x"F3",
                                67 => x"78",
                                68 => x"D2",
                                69 => x"4F",
                                70 => x"10",
                                71 => x"F2",
                                72 => x"18",
                                73 => x"F4",
                                74 => x"78",
                                75 => x"38",
                                76 => x"7F",
                                77 => x"D0",
                                78 => x"56",
                                79 => x"10",
                                80 => x"F2",
                                81 => x"18",
                                82 => x"F4",
                                83 => x"78",
                                84 => x"34",
                                85 => x"80",
                                86 => x"18",
                                87 => x"F2",
                                88 => x"10",
                                89 => x"F5",
                                90 => x"18",
                                91 => x"F3",
                                92 => x"4E",
                                93 => x"D7",
                                94 => x"0F",
                                95 => x"FF",
                                
 
--                                0 => x"10",
--                                1 => x"09",
--                                2 => x"78",
--                                9 => x"15",                           
                                others => "00000000"
                                );
  signal dataIn : STD_LOGIC_VECTOR(7 downto 0);
  signal dataOut : STD_LOGIC_VECTOR(7 downto 0);
begin
ram16x8_proc : process (nCE, nWE, clk) is 
    begin
        dataOut <= RAM(to_integer(unsigned(addr)));
        if nWE = '0' and nCE = '0'  then -- write
            RAM(to_integer(unsigned(addr))) <= dataIn;
        end if;
    end process;
    dataIn <= data when nWE = '0' else (others => 'Z');
    data <= dataOut when nCE = '0' and nWE = '1' else (others => 'Z');
end sap1;
