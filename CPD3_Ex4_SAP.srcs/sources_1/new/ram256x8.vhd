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
                                0 => "00000000",
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
                                15 => x"19",
                                16 => x"10",
                                17 => x"F4",
                                18 => x"38",
                                19 => x"01",
                                20 => x"D7",
                                21 => x"20",
                                22 => x"42",
                                23 => x"D0",
                                24 => x"20",
                                25 => x"10",
                                26 => x"F4",
                                27 => x"38",
                                28 => x"01",
                                29 => x"D6",
                                30 => x"20",
                                31 => x"41",
                                32 => x"10",
                                33 => x"F3",
                                34 => x"38",
                                35 => x"80",
                                36 => x"D7",
                                37 => x"2B",
                                38 => x"78",
                                39 => x"38",
                                40 => x"7F",
                                41 => x"D0",
                                42 => x"2E",
                                43 => x"78",
                                44 => x"34",
                                45 => x"80",
                                46 => x"18",
                                47 => x"F5",
                                48 => x"10",
                                49 => x"F3",
                                50 => x"78",
                                51 => x"D2",
                                52 => x"3E",
                                53 => x"10",
                                54 => x"F2",
                                55 => x"18",
                                56 => x"F4",
                                57 => x"78",
                                58 => x"38",
                                59 => x"80",
                                60 => x"D0",
                                61 => x"45",
                                62 => x"10",
                                63 => x"F2",
                                64 => x"18",
                                65 => x"F4",
                                66 => x"78",
                                67 => x"34",
                                68 => x"80",
                                69 => x"18",
                                70 => x"F2",
                                71 => x"10",
                                72 => x"F5",
                                73 => x"18",
                                74 => x"F3",
                                75 => x"4E",
                                76 => x"D7",
                                77 => x"0A",
                                78 => x"FF",
                                
                                240 => x"15",
                                241 => "11111001",                                
                                others => "00000000"
                                );
  signal dataIn : STD_LOGIC_VECTOR(7 downto 0);
  signal dataOut : STD_LOGIC_VECTOR(7 downto 0);
begin
ram16x8_proc : process (clk) is 
    begin
        if rising_edge(clk) then
            if nCE = '0' then
                dataOut <= RAM(to_integer(unsigned(addr)));
                if nWE = '0'  then -- write
                    RAM(to_integer(unsigned(addr))) <= dataIn;
                end if;
            end if;
        end if;
    end process;
    dataIn <= data when nWE = '0' else (others => 'Z');
    data <= dataOut when nCE = '0' and nWE = '1' else (others => 'Z');
end sap1;
