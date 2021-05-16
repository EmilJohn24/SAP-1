----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 09:10:15
-- Design Name: 
-- Module Name: DES_InversePermutation - Behavioral
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

entity DES_InversePermutation is
    Port ( perm_in : in STD_LOGIC_VECTOR (63 downto 0);
           perm : out STD_LOGIC_VECTOR (63 downto 0));
end DES_InversePermutation;

architecture Behavioral of DES_InversePermutation is
type PERM_SEQ is array(0 to 63) of integer;
constant perm_sequence : PERM_SEQ :=  (
                           40, 8, 48, 16, 56, 24, 64, 32,
                           39, 7, 47, 15, 55, 23, 63, 31,
                           38, 6, 46, 14, 54, 22, 62, 30,
                           37, 5, 45, 13, 53, 21, 61, 29,
                           36, 4, 44, 12, 52, 20, 60, 28,
                           35, 3, 43, 11, 51, 19, 59, 27,
                           34, 2, 42, 10, 50, 18, 58, 26,
                           33, 1, 41, 9, 49, 17, 57, 25 ); 
begin
    INV_PERM : process (perm_in) is
    begin
        for i in 0 to 63 loop
            perm(perm'left - i) <= perm_in(perm_in'left - (perm_sequence(i) - 1));
        end loop; 
    end process;

end Behavioral;

