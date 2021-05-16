----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 11:47:34
-- Design Name: 
-- Module Name: DES_keygen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DES_keygen is
    Port ( key : in STD_LOGIC_VECTOR (63 downto 0);
           round : in STD_LOGIC_VECTOR (3 downto 0);
           genKey : out STD_LOGIC_VECTOR (47 downto 0));
end DES_keygen;

architecture Behavioral of DES_keygen is
type PAR_DROP_TABLE is array(0 to 55) of integer;
constant parity_drop_table : PAR_DROP_TABLE := ( 57, 49, 41, 33, 25, 17, 9,
                                                 1, 58, 50, 42, 34, 26, 18,
                                                 10, 2, 59, 51, 43, 35, 27,
                                                 19, 11, 3, 60, 52, 44, 36,
                                                 63, 55, 47, 39, 31, 23, 15,
                                                 7, 62, 54, 46, 38, 30, 22,
                                                 14, 6, 61, 53, 45, 37, 29,
                                                 21, 13, 5, 28, 20, 12, 4);
signal parity_dropped : std_logic_vector(55 downto 0);

type SHIFT_TABLE_TYPE is array(0 to 15) of integer range 2 downto 0;
constant shift_table : SHIFT_TABLE_TYPE := (1, 1, 2, 2,
                                        2, 2, 2, 2,
                                        1, 2, 2, 2,
                                        2, 2, 2, 1);

type KEY_ARRAY is array(0 to 15) of std_logic_vector(47 downto 0);
signal keys : KEY_ARRAY;

type COMP_SEQ is array(0 to 47) of integer;
constant compression_sequence : COMP_SEQ := (
                         14, 17, 11, 24, 1, 5,
                         3, 28, 15, 6, 21, 10,
                         23, 19, 12, 4, 26, 8,
                         16, 7, 27, 20, 13, 2,
                         41, 52, 31, 37, 47, 55,
                         30, 40, 51, 45, 33, 48,
                         44, 49, 39, 56, 34, 53,
                         46, 42, 50, 36, 29, 32);
begin
    PAR_DROP : process (key) is
    begin
        for i in 0 to 55 loop
            parity_dropped(parity_dropped'left - i) <= key(key'left - (parity_drop_table(i) - 1));
        end loop; 
    end process;
    
    KEY_GEN : process (key, parity_dropped) is
    variable left_split : std_logic_vector(27 downto 0);
    variable right_split : std_logic_vector(27 downto 0);
    variable joint : std_logic_vector(55 downto 0);
    variable shift_tmp : std_logic;
    variable keys_tmp : KEY_ARRAY;
    variable round_key : std_logic_vector(47 downto 0);
    begin
        left_split := parity_dropped(55 downto 28);
        right_split := parity_dropped(27 downto 0);
        
        for r in 0 to 15 loop
           for k in 0 to shift_table(r) - 1 loop
                shift_tmp := left_split(27);
                left_split(27 downto 1) := left_split(26 downto 0);
                left_split(0) := shift_tmp;
                shift_tmp := right_split(27);
                right_split(27 downto 1) := right_split(26 downto 0);
                right_split(0) := shift_tmp;
            end loop;
            joint := left_split & right_split;
            for i in 0 to 47 loop
                round_key(round_key'left - i) := joint(joint'left - (compression_sequence(i) - 1));
            end loop;
            keys_tmp(r) := round_key;
            
           
        end loop;
        keys <= keys_tmp;
    
    end process;
    
    
    KEY_MUX : process(round, keys) is
    begin
        genKey <= keys(to_integer(unsigned(round)));
    end process;
     
end Behavioral;
