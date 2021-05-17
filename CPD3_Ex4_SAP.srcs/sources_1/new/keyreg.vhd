----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2021 11:48:59
-- Design Name: 
-- Module Name: keyreg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyreg is
    Port ( keyIn : in STD_LOGIC_VECTOR (63 downto 0);
           nLk : in STD_LOGIC;
           clk : in STD_LOGIC;
           keyOut : out STD_LOGIC_VECTOR (63 downto 0));
end keyreg;

architecture Behavioral of keyreg is
signal key_reg : STD_LOGIC_VECTOR(63 downto 0);
begin
    keyOut <= key_reg;
    KEYREG_PROC : process(clk) is
    begin
        if rising_edge(clk) then
            if nLk = '0' then
                key_reg <= keyIn;
            end if;
        end if;
    
    end process;

end Behavioral;
