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
                             0 => x"10",
                            1 => x"32",
                            2 => x"40",
                            3 => x"28",
                            4 => x"10",
                            5 => x"33",
                            6 => x"40",
                            7 => x"28",
                            8 => x"10",
                            9 => x"34",
                            10 => x"40",
                            11 => x"28",
                            12 => x"10",
                            13 => x"35",
                            14 => x"40",
                            15 => x"28",
                            16 => x"10",
                            17 => x"36",
                            18 => x"40",
                            19 => x"28",
                            20 => x"10",
                            21 => x"37",
                            22 => x"40",
                            23 => x"28",
                            24 => x"10",
                            25 => x"38",
                            26 => x"40",
                            27 => x"28",
                            28 => x"10",
                            29 => x"39",
                            30 => x"40",
                            31 => x"28",
                            32 => x"38",
                            33 => x"01",
                            34 => x"D7",
                            35 => x"29",
                            36 => x"20",
                            37 => x"00",
                            38 => x"18",
                            39 => x"3A",
                            40 => x"FF",
                            41 => x"20",
                            42 => x"FF",
                            43 => x"18",
                            44 => x"3A",
                            45 => x"FF",
                            50 => x"01",
                            51 => x"01",
                            52 => x"08",
                            53 => x"01",
                            54 => x"06",
                            55 => x"06",
                            56 => x"00",
                            57 => x"00",
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
    ram_proc : process (nCE, nWE_word, nWE_byte, clk) is 
        variable address : integer;
        variable word_address : integer;
        begin
            if rising_edge(clk) then
            end if;
            word_address := to_integer(unsigned(word_addr));
            address := to_integer(unsigned(addr));
            if readMode = '1' and nCE = '0' then
                if RD_byte = '0' then --read word
                    dataOut <= RAM(to_integer(unsigned(word_addr))) & RAM(to_integer(unsigned(word_addr)) + 1) & 
                            RAM(to_integer(unsigned(word_addr)) + 2) & RAM(to_integer(unsigned(word_addr)) + 3) & 
                            RAM(to_integer(unsigned(word_addr)) + 4) & RAM(to_integer(unsigned(word_addr)) + 5) &  
                            RAM(to_integer(unsigned(word_addr)) + 6) & RAM(to_integer(unsigned(word_addr)) + 7);
                elsif RD_byte = '1' then
                    dataOut(7 downto 0) <= RAM(to_integer(unsigned(addr)));
                    dataOut(63 downto 8) <= (others => 'Z');
                end if;
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
        dataIn <= data when nWE_byte = '0' or nWE_word = '0' else (others => 'Z');
        data <= dataOut when nCE = '0' and readMode = '1' else (others => 'Z');
 end sap1;
