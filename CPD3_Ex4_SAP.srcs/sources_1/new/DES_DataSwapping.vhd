----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 09:05:42
-- Design Name: 
-- Module Name: DES_DataSwapping - Behavioral
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

entity DES_DataSwapping is
    Port ( swap_in_msb : in STD_LOGIC_VECTOR (31 downto 0);
           swap_in_lsb : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           en_swap : in STD_LOGIC;
           swap_out : out STD_LOGIC_VECTOR (63 downto 0));
end DES_DataSwapping;

architecture Behavioral of DES_DataSwapping is
signal swap_reg : STD_LOGIC_VECTOR(63 downto 0);
begin

--    swap_out <= swap_reg;
    
    SWAP_REG_PROC : process(clk) is
    begin
--        if rising_edge(clk) then
--            if en_swap = '1' then
--                swap_reg(63 downto 32) <= swap_in_msb;
--                swap_reg(31 downto 0) <= swap_in_lsb;        
--            end if;
        
--        end if;
        if rising_edge(clk) then
            swap_reg(63 downto 32) <= swap_in_msb;
            swap_reg(31 downto 0) <= swap_in_lsb;      
        end if;
    end process;
    
    swap_out <= swap_reg when en_swap = '1' else (others => 'Z');
end Behavioral;
