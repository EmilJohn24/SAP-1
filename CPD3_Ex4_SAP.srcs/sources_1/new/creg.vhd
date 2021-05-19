library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity creg is
    Port ( clk : in STD_LOGIC; -- clock
           nLc : in STD_LOGIC; -- load data from W bus
           Ec : in STD_LOGIC; --enable output
           wbus : inout STD_LOGIC_VECTOR (63 downto 0)); -- connected to W bus
end creg;

architecture sap1 of creg is
    signal c_reg : STD_LOGIC_VECTOR (63 downto 0) := x"00000000000000FF";
begin
creg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLc = '0' then
                c_reg <= wbus;
            end if;
        end if;
    end process;
    wbus <= c_reg when Ec = '1' else (others => 'Z');
end sap1;
