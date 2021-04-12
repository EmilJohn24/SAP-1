----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2021 09:35:51
-- Design Name: 
-- Module Name: flagReg - Behavioral
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

entity flagReg is
    Port ( Lf : in STD_LOGIC; --load flags from ALU
           aluFlagIn : in STD_LOGIC_VECTOR (3 downto 0);
           ctrlFlagOut : out STD_LOGIC_VECTOR (3 downto 0));
end flagReg;

architecture Behavioral of flagReg is
    signal flag_reg : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    alias C : STD_LOGIC is flag_reg(0);
    alias Z : STD_LOGIC is flag_reg(1);
    alias S : STD_LOGIC is flag_reg(2);
    alias I : STD_LOGIC is flag_reg(3);
begin
   flag_proc : process (Lf)
   begin
        if Lf = '1' then
            flag_reg <= aluFlagIn;
        end if;
   end process;
   
   ctrlFlagOut <= flag_reg;

end Behavioral;
