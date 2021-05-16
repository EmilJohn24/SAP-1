----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 11:47:34
-- Design Name: 
-- Module Name: DES_unit - Behavioral
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

entity DES_unit is
    Port ( text_in : in STD_LOGIC_VECTOR (63 downto 0);
           key : in STD_LOGIC_VECTOR (63 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           mode : in STD_LOGIC;
           text_out : out STD_LOGIC_VECTOR (63 downto 0));
end DES_unit;
    
architecture Behavioral of DES_unit is
    component DES_datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           key : in STD_LOGIC_VECTOR(63 downto 0);
           round : in STD_LOGIC_VECTOR(3 downto 0);
           des_ctrl : in STD_LOGIC_VECTOR (8 downto 0);
           text_in : in STD_LOGIC_VECTOR (63 downto 0);
           text_out : out STD_LOGIC_VECTOR (63 downto 0));
    end component;
    
    component DES_controller is
    Port ( mode : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           round : out STD_LOGIC_VECTOR(3 downto 0);
           des_ctrl : out STD_LOGIC_VECTOR (8 downto 0));
    end component;
    
    
    
    signal des_ctrl : STD_LOGIC_VECTOR(8 downto 0);
    signal round_sig : STD_LOGIC_VECTOR(3 downto 0);
begin
    DATAPATH : DES_datapath port map(clk => clk,
                                     rst => rst,
                                     key => key,
                                     round => round_sig,
                                     des_ctrl => des_ctrl,
                                     text_in => text_in,
                                     text_out => text_out);
    CONTROL : DES_controller port map(mode => mode,
                                      clk => clk,
                                      rst => rst,
                                      round => round_sig,
                                      des_ctrl => des_ctrl);                            
end Behavioral;    
