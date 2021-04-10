library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ireg is
    Port ( clk : in STD_LOGIC; -- clock
           clr : in STD_LOGIC; -- reset instruction
           nLi : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           inst : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to controller
end ireg;

architecture sap1 of ireg is
    signal i_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
ireg_proc : process (clr, clk) is
    begin
        if clr = '1' then
            i_reg <= (others => '0');
        else
            if rising_edge(clk) then
                if nLi = '0' then
                    i_reg <= wbus;
                end if;
            end if;
        end if;
    end process;
    inst <= i_reg;
--    wbus(7 downto 4) <= (others => 'Z');
--    wbus(3 downto 0) <= i_reg(3 downto 0) when nEi = '0' else (others => 'Z');
end sap1;
