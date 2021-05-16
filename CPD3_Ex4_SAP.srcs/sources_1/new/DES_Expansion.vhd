----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 18:16:53
-- Design Name: 
-- Module Name: DES_Expansion - Behavioral
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

entity DES_Expansion is
    Port ( exp_in : in STD_LOGIC_VECTOR (31 downto 0);
           exp : out STD_LOGIC_VECTOR (47 downto 0));
end DES_Expansion;

architecture Behavioral of DES_Expansion is
type EXP_SEQ is array(0 to 47) of integer;
constant exp_sequence : EXP_SEQ :=  (32, 1, 2, 3, 4, 5, 4, 5,
                                      6, 7, 8, 9, 8, 9, 10, 11,
                                      12, 13, 12, 13, 14, 15, 16, 17,
                                      16, 17, 18, 19, 20, 21, 20, 21,
                                      22, 23, 24, 25, 24, 25, 26, 27,
                                      28, 29, 28, 29, 30, 31, 32, 1 ); 
begin
    INIT_EXP : process (exp_in) is
    begin
        for i in 0 to 47 loop
            exp(exp'left - i) <= exp_in(exp_in'left - (exp_sequence(i) - 1));
        end loop; 
    end process;
end Behavioral;