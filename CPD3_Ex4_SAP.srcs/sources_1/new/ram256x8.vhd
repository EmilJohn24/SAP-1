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
                                1 => x"10",
                                2 => x"F1",
                                3 => x"18",
                                4 => x"F2",
                                5 => x"22",
                                6 => x"08",
                                7 => x"10",
                                8 => x"F0",
                                9 => x"28",
                                10 => x"10",
                                11 => x"F2",
                                12 => x"38",
                                13 => x"01",
                                14 => x"D6",
                                15 => x"1D",
                                16 => x"10",
                                17 => x"F4",
                                18 => x"38",
                                19 => x"01",
                                20 => x"D7",
                                21 => x"28",
                                22 => x"10",
                                23 => x"F3",
                                24 => x"42",
                                25 => x"18",
                                26 => x"F3",
                                27 => x"D0",
                                28 => x"28",
                                29 => x"10",
                                30 => x"F4",
                                31 => x"38",
                                32 => x"01",
                                33 => x"D6",
                                34 => x"28",
                                35 => x"10",
                                36 => x"F3",
                                37 => x"40",
                                38 => x"18",
                                39 => x"F3",
                                40 => x"10",
                                41 => x"F3",
                                42 => x"38",
                                43 => x"80",
                                44 => x"D7",
                                45 => x"35",
                                46 => x"10",
                                47 => x"F3",
                                48 => x"78",
                                49 => x"38",
                                50 => x"7F",
                                51 => x"D0",
                                52 => x"3A",
                                53 => x"10",
                                54 => x"F3",
                                55 => x"78",
                                56 => x"34",
                                57 => x"80",
                                58 => x"18",
                                59 => x"F5",
                                60 => x"10",
                                61 => x"F3",
                                62 => x"78",
                                63 => x"D2",
                                64 => x"4A",
                                65 => x"10",
                                66 => x"F2",
                                67 => x"18",
                                68 => x"F4",
                                69 => x"78",
                                70 => x"38",
                                71 => x"7F",
                                72 => x"D0",
                                73 => x"51",
                                74 => x"10",
                                75 => x"F2",
                                76 => x"18",
                                77 => x"F4",
                                78 => x"78",
                                79 => x"34",
                                80 => x"80",
                                81 => x"18",
                                82 => x"F2",
                                83 => x"10",
                                84 => x"F5",
                                85 => x"18",
                                86 => x"F3",
                                87 => x"4E",
                                88 => x"D7",
                                89 => x"0A",
                                90 => x"FF",
                                240 => x"15",
                                241 => "11111001",     
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
