library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TmpReg is
    Port ( clk : in STD_LOGIC; -- clock
           nLt : in STD_LOGIC; -- load data from W bus
           Et : in STD_LOGIC; -- enable output data to W bus
           wbus : inout STD_LOGIC_VECTOR (63 downto 0); -- connected to W bus
           aluout : out STD_LOGIC_VECTOR (63 downto 0)); -- connected to ALU
end TmpReg;

architecture sap1 of TmpReg is
    signal tmp_reg : STD_LOGIC_VECTOR (63 downto 0) := (others => '0');
begin
tmpreg_proc : process (clk) is
    begin
        if rising_edge(clk) then
            if nLt = '0' then
                tmp_reg <= wbus;
            end if;
            
        end if;
    end process;
    wbus <= tmp_reg when Et = '1' else (others => 'Z');
    aluout <= tmp_reg;
end sap1;
