----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 18:10:14
-- Design Name: 
-- Module Name: DES_Reg32 - Behavioral
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

entity DES_Reg32 is
    Port ( D : in STD_LOGIC_VECTOR (31 downto 0);
           EN_Reg : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end DES_Reg32;

architecture Behavioral of DES_Reg32 is
signal reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
--    Q <= reg;
    
--    REG_PROC : process (clk) is
--    begin
--        if rising_edge(clk) then
--            if EN_Reg = '1' then 
--                reg <= D;    
--            end if;
        
--        end if;
--    end process;
    REG_PROC : process (clk) is
    begin
        if rising_edge(clk) then
           reg <= D;    
        end if;
    end process;
    
    Q <= reg when EN_reg = '1' else (others => '0');

end Behavioral;
