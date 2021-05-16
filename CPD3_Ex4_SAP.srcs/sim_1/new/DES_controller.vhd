----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 11:43:00
-- Design Name: 
-- Module Name: DES_controller - Behavioral
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

entity DES_controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           mode : in STD_LOGIC;
           ctrl_bus : out STD_LOGIC_VECTOR (8 downto 0));
end DES_controller;

architecture Behavioral of DES_controller is

begin


end Behavioral;
