library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memaddreg is
    Port ( clk : in STD_LOGIC; -- clock
           nLm : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           memaddr : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to memory address
end memaddreg;

architecture sap1 of memaddreg is
    signal mar_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
memaddreg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLm = '0' then
                mar_reg <= wbus;
            end if;
        end if;
    end process;
    memaddr <= mar_reg;
end sap1;
