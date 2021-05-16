----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 16:22:26
-- Design Name: 
-- Module Name: DES_OutReg - Behavioral
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

entity DES_OutReg is
    Port ( D : in STD_LOGIC_VECTOR (63 downto 0);
           en_out : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (63 downto 0));
end DES_OutReg;

architecture Behavioral of DES_OutReg is

begin
    OUT_REG : process(clk) is
    begin
        if rising_edge(clk) then
            if en_out = '1' then
                Q <= D;
            end if;
        
        end if;
        
    end process;

end Behavioral;
