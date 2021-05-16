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

entity DES_Permutation is
    Port ( perm_in : in STD_LOGIC_VECTOR (31 downto 0);
           perm : out STD_LOGIC_VECTOR (31 downto 0));
end DES_Permutation;

architecture Behavioral of DES_Permutation is
type PERM_SEQ is array(0 to 31) of integer;
constant perm_sequence : PERM_SEQ :=  ( 16, 7, 20, 21,
                                        29, 12, 28, 17,
                                        1, 15, 23, 26,
                                        5, 18, 31, 10,
                                        2, 8, 24, 14,
                                        32, 27, 3, 9,
                                        19, 13, 30, 6,
                                        22, 11, 4, 25); 
begin
    MID_PERM : process (perm_in) is
    begin
        for i in 0 to 31 loop
            perm(perm'left - i) <= perm_in(perm_in'left - (perm_sequence(i) - 1));
        end loop; 
    end process;

end Behavioral;
