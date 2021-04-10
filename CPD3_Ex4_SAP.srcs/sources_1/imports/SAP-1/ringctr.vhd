library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ctrl_ringctr is
    Port ( nclk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset counter
           state : out STD_LOGIC_VECTOR (5 downto 0)); -- ring counter state
end ctrl_ringctr;

architecture sap1 of ctrl_ringctr is
    signal shift_reg : STD_LOGIC_VECTOR (5 downto 0) := (0 => '1', others => '0');
begin
proc_ctrl_ringctr : process (nclr, nclk) is 
    begin
        if nclr = '0' then
            shift_reg <= (0 => '1', others => '0');
        else
            if falling_edge(nclk) then
                for idx in 0 to 4 loop
                    shift_reg(idx + 1) <= shift_reg(idx);
                end loop;
                shift_reg(0) <= shift_reg(5);
            end if;
        end if;
    end process;
    state <= shift_reg;
end sap1;
