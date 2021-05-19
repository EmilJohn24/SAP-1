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

entity StackPointer is
    Port ( clk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset count
           Esp : in STD_LOGIC; -- enable output
           SPi : in STD_LOGIC; -- increment count
           SPd : in STD_LOGIC; --decrement sp
           nLsp : in STD_LOGIC; --enable load
           wbus : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end StackPointer;

architecture sap1 of StackPointer is
    signal stack_count : STD_LOGIC_VECTOR (7 downto 0);
begin
pc_proc : process (nclr, clk) is
    begin
        if nclr = '0' then
            stack_count <= (others => '0');
        else
            if rising_edge(clk) then
                if SPi = '1' then
                    stack_count <= stack_count + 1;
                elsif SPd = '1' then
                    stack_count <= stack_count - 1;
                end if;
                
                if nLsp = '0' then
                    stack_count <= wbus;
                end if;
            end if;
        end if;
    end process;
    wbus <= stack_count when Esp = '1' else (others => 'Z');
end sap1;
