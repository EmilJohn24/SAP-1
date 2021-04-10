library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram16x8 is
    Port ( nCE : in STD_LOGIC; -- enable memory output
           nWE : in STD_LOGIC; -- read/write, read if nWE = 1, write if nWE = 0
           addr : in STD_LOGIC_VECTOR (3 downto 0); -- connected to memaddreg
           data : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end ram16x8;

architecture sap1 of ram16x8 is
    type RAM_type is array (0 to 2**addr'length - 1) of std_logic_vector (7 downto 0);
    signal RAM : RAM_type := (
                                0 => "00001101",
                                1 => "11100000",
                                2 => "00011110",
                                3 => "11100000",
                                4 => "00101111",
                                5 => "11100000",
                                6 => "11110000",
                                13 => "00000100",
                                14 => "00001000",
                                15 => "00010000",
                                others => "00000000"
                                );
begin
ram16x8_proc : process (nCE, nWE, addr) is 
    begin
        if nCE = '0' then
            if nWE = '1' then -- read
                data <= RAM(to_integer(unsigned(addr)));
            else -- write
                RAM(to_integer(unsigned(addr))) <= data;
            end if;
        else
            data <= (others => 'Z');
        end if;
    end process;
end sap1;
