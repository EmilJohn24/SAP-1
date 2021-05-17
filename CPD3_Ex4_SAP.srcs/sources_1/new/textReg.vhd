----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2021 11:56:00
-- Design Name: 
-- Module Name: textReg - Behavioral
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

entity textReg is
    Port ( textIn : in STD_LOGIC_VECTOR (63 downto 0);
           nLtxt : in STD_LOGIC;
           clk : in STD_LOGIC;
           textOut : out STD_LOGIC_VECTOR (63 downto 0));
end textReg;

architecture Behavioral of textReg is
    signal text_reg : STD_LOGIC_VECTOR(63 downto 0);
begin
    textOut <= text_reg;
    TEXTREG_PROC : process(clk) is
    begin
        if rising_edge(clk) then
            if nLtxt = '0' then
                text_reg <= textIn;
            end if;
        end if;
    
    end process;

end Behavioral;
