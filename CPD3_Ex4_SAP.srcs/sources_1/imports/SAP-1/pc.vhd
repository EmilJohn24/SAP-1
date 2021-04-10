library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
    Port ( nclk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset count
           Ep : in STD_LOGIC; -- enable output
           Cp : in STD_LOGIC; -- increment count
           nLp : in STD_LOGIC; --enable load
           wbus : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end pc;

architecture sap1 of pc is
    signal prog_count : STD_LOGIC_VECTOR (7 downto 0);
begin
pc_proc : process (nclr, nclk) is
    begin
        if nclr = '0' then
            prog_count <= (others => '0');
        else
            if falling_edge(nclk) then
                if Cp = '1' then
                    prog_count <= prog_count + 1;
                end if;
                
                if nLp = '0' then
                    prog_count <= wbus;
                end if;
            end if;
        end if;
    end process;
    wbus <= prog_count when Ep = '1' else (others => 'Z');
end sap1;
