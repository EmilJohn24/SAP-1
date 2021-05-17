library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity accreg is
    Port ( clk : in STD_LOGIC; -- clock
           Ea : in STD_LOGIC; -- enable output
           nLa : in STD_LOGIC; -- load data from W bus
           wbus : inout STD_LOGIC_VECTOR (63 downto 0) := (others => 'Z'); -- connected to W bus
           aluout : out STD_LOGIC_VECTOR (63 downto 0)); -- connected to ALU
end accreg;

architecture sap1 of accreg is
    signal acc_reg : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
begin
accreg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLa = '0' then
                acc_reg <= wbus;
            end if;
        end if;
    end process;
    wbus <= acc_reg when Ea = '1' else (others => 'Z');
    aluout <= acc_reg;
end sap1;
