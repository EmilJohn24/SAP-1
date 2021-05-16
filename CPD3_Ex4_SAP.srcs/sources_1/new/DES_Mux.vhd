----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 18:05:28
-- Design Name: 
-- Module Name: DES_Mux31b_2to1 - Behavioral
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

entity DES_Mux31b_2to1 is
    Port ( I0 : in STD_LOGIC_VECTOR (31 downto 0);
           I1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
end DES_Mux31b_2to1;

architecture Behavioral of DES_Mux31b_2to1 is

begin
    O <= I0 when sel = '0' else I1 when sel = '1' else I0;
end Behavioral;
