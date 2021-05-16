----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 17:56:46
-- Design Name: 
-- Module Name: DES_InitialPermutation - Behavioral
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

entity DES_InitialPermutation is
    Port ( text_in : in STD_LOGIC_VECTOR (63 downto 0);
           perm : out STD_LOGIC_VECTOR (63 downto 0));
end DES_InitialPermutation;

architecture Behavioral of DES_InitialPermutation is
type PERM_SEQ is array(0 to 63) of integer;
constant perm_sequence : PERM_SEQ :=  (
                            58, 50, 42, 34, 26, 18, 10, 2,
                             60, 52, 44, 36, 28, 20, 12, 4,
                             62, 54, 46, 38, 30, 22, 14, 6,
                             64, 56, 48, 40, 32, 24, 16, 8,
                             57, 49, 41, 33, 25, 17, 9, 1,
                             59, 51, 43, 35, 27, 19, 11, 3,
                             61, 53, 45, 37, 29, 21, 13, 5,
                             63, 55, 47, 39, 31, 23, 15, 7); 
begin
    INIT_PERM : process (text_in) is
    begin
        for i in 0 to 63 loop
            perm(perm'left - i) <= text_in(text_in'left - (perm_sequence(i) - 1));
        end loop; 
    end process;

end Behavioral;
