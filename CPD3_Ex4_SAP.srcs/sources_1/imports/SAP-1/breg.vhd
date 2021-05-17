library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity breg is
    Port ( clk : in STD_LOGIC; -- clock
           nLb : in STD_LOGIC; -- load data from W bus
           Eb : in STD_LOGIC; --enable output
           wbus : inout STD_LOGIC_VECTOR (63 downto 0)); -- connected to W bus
end breg;

architecture sap1 of breg is
    signal b_reg : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
begin
breg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLb = '0' then
                b_reg <= wbus;
            end if;
        end if;
    end process;
    wbus <= b_reg when Eb = '1' else (others => 'Z');
end sap1;
