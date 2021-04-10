library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity outreg is
    Port ( clk : in STD_LOGIC; -- clock
           nLo : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           dispout : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to binary display
end outreg;

architecture sap1 of outreg is
    signal out_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
breg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLo = '0' then
                out_reg <= wbus;
            end if;
        end if;
    end process;
    dispout <= out_reg;
end sap1;
