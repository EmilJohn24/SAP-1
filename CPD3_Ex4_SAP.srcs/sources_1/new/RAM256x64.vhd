library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram256x64 is
    Port ( nCE : in STD_LOGIC; -- enable memory output
           nWE_byte : in STD_LOGIC; -- byte write
           nWE_word : in STD_LOGIC; --word write
           RD_byte : in STD_LOGIC; --byte mode = 1, word mode = 0
           addr : in STD_LOGIC_VECTOR (7 downto 0); -- connected to memaddreg
           clk : in STD_LOGIC; --clock
           data : inout STD_LOGIC_VECTOR (63 downto 0)); -- connected to W bus
end ram256x64;

architecture sap1 of ram256x64 is
    type RAM_type is array (0 to 2**addr'length - 1) of std_logic_vector (7 downto 0);
    signal RAM : RAM_type := (
                            0 => x"B0",
                            1 => x"E0",
                            2 => x"10",
                            3 => x"38",
                            4 => x"F2",
                            5 => x"10",
                            6 => x"48",
                            7 => x"F3",
                            8 => x"F0",
                            9 => x"D0",
                            10 => x"09",
                            11 => x"D0",
                            12 => x"09",
                            
                            --INTERRUPT POINT
                            --24 => x"F4",
                            24 => x"10",
                            25 => x"38",
                            26 => x"F3",
                            27 => x"F0",
                            28 => x"F4",
                            29 => x"B2",
                           
                            --text
                            56 => x"11",
                            57 => x"22",
                            58 => x"11",
                            59 => x"22",
                            60 => x"11",
                            61 => x"22",
                            62 => x"11",
                            63 => x"22",
                           
                            64 => x"12",
                            65 => x"34", 
                            66 => x"56",
                            67 => x"AB",
                            68 => x"CD",
                            69 => x"13",
                            70 => x"25",
                            71 => x"36",
                            
                            --key
                            72 => x"AA",
                            73 => x"BB",
                            74 => x"09",
                            75 => x"18",
                            76 => x"27",
                            77 => x"36",
                            78 => x"CC",
                            79 => x"DD",
                            255 => x"18",
--                            68 to 75 => x"AABB09182736CCDD",
                           others => "00000000"                         
                           );
  signal dataIn : STD_LOGIC_VECTOR(63 downto 0);
  signal dataOut : STD_LOGIC_VECTOR(63 downto 0);
  signal word_addr : STD_LOGIC_VECTOR(7 downto 0);
  signal offset : STD_LOGIC_VECTOR(2 downto 0);
  signal word : STD_LOGIC_VECTOR(63 downto 0);
  signal readMode : STD_LOGIC;
begin
    offset <= addr(2 downto 0);
    word_addr <= addr(7 downto 3) & "000";
    readMode <= nWE_byte nor nWE_word;   
    ram_proc : process (nCE, nWE_word, RD_byte, nWE_byte, clk) is 
        
        begin
            if RD_byte = '0' then --read word
                dataOut <= RAM(to_integer(unsigned(word_addr))) & RAM(to_integer(unsigned(word_addr)) + 1) & 
                        RAM(to_integer(unsigned(word_addr)) + 2) & RAM(to_integer(unsigned(word_addr)) + 3) & 
                        RAM(to_integer(unsigned(word_addr)) + 4) & RAM(to_integer(unsigned(word_addr)) + 5) &  
                        RAM(to_integer(unsigned(word_addr)) + 6) & RAM(to_integer(unsigned(word_addr)) + 7);
--                elsif RD_byte = '1' then
            else
                dataOut(7 downto 0) <= RAM(to_integer(unsigned(addr)));
                dataOut(63 downto 8) <= (others => 'Z');
            end if;
            if nWE_byte = '0' and readMode = '0' and nCE = '0'  then -- write
                RAM(to_integer(unsigned(addr))) <= dataIn(7 downto 0);
            elsif nWE_word = '0' and nCE = '0' and readMode = '0'  then -- write
                RAM(to_integer(unsigned(word_addr)) + 0) <= dataIn(63 downto 56);
                RAM(to_integer(unsigned(word_addr)) + 1) <= dataIn(55 downto 48);
                RAM(to_integer(unsigned(word_addr)) + 2) <= dataIn(47 downto 40);
                RAM(to_integer(unsigned(word_addr)) + 3) <= dataIn(39 downto 32);
                RAM(to_integer(unsigned(word_addr)) + 4) <= dataIn(31 downto 24);
                RAM(to_integer(unsigned(word_addr)) + 5) <= dataIn(23 downto 16);
                RAM(to_integer(unsigned(word_addr)) + 6) <= dataIn(15 downto 8);
                RAM(to_integer(unsigned(word_addr)) + 7) <= dataIn(7 downto 0);
                
            end if;
        end process;
        dataIn <= data when nCE = '0' and (nWE_byte = '0' or nWE_word = '0') else (others => 'Z');
        data <= dataOut when nCE = '0' and (nWE_byte = '1' and nWE_word = '1') else (others => 'Z');
 end sap1;
