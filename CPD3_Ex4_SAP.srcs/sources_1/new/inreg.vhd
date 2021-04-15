----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2021 08:11:16
-- Design Name: 
-- Module Name: inreg - Behavioral
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

entity inreg is
--  Port ( );
    Port ( data : in STD_LOGIC_VECTOR(7 downto 0); 
           clk : in STD_LOGIC;
           Eip : in STD_LOGIC;
           wbus : out STD_LOGIC_VECTOR(7 downto 0));
end inreg;

architecture Behavioral of inreg is
    signal input_reg : STD_LOGIC_VECTOR(7 downto 0);
begin
    input_proc : process (clk) is
    begin
        if rising_edge(clk) then
            input_reg <= data;
        end if;
    end process;
    wbus <= input_reg when Eip = '1' else (others => 'Z');
end Behavioral;
