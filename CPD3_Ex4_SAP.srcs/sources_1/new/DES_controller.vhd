----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 11:47:34
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DES_controller is
    Port ( mode : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           round : out STD_LOGIC_VECTOR(3 downto 0);
           des_ctrl : out STD_LOGIC_VECTOR (8 downto 0));
end DES_controller;

architecture Behavioral of DES_controller is
    alias en_cnt : STD_LOGIC is des_ctrl(8);
    alias sel_lmux : STD_LOGIC is des_ctrl(7);
    alias sel_rmux : STD_LOGIC is des_ctrl(6);
    alias en_lreg : STD_LOGIC is des_ctrl(5);
    alias en_rreg : STD_LOGIC is des_ctrl(4);
    alias en_swap : STD_LOGIC is des_ctrl(3);
    alias en_invperm : STD_LOGIC is des_ctrl(2);
    alias en_out : STD_LOGIC is des_ctrl(1);
    alias encrypt : STD_LOGIC is des_ctrl(0);
    signal encrypt_sig : STD_LOGIC;
    signal decrypt_sig : STD_LOGIC;
    signal round_reg : STD_LOGIC_VECTOR(3 downto 0);
    
    type state_t is (idle, enc, dec, enc_process, dec_process, result);
    signal state : state_t := idle;
begin
    round <= round_reg;
    FSM : process(clk, rst) is
    begin
        if rst = '1' then
            round_reg <= "0000";
            state <= idle;
        elsif rising_edge(clk) then 
            des_ctrl <= (others => '0');
            case state is
                when idle =>
                    sel_lmux <= '0';
                    sel_rmux <= '0';
                    if mode = '1' then --encrypt
                        round_reg <= "0000";
                        state <= enc;
                    elsif mode = '0' then --decrypt
                        round_reg <= "1111";
                        state <= dec;
                    end if;
                    
                when enc =>
                    en_cnt <= '1';
                    encrypt <= '1';
                    state <= enc_process;
                when dec =>
                    en_cnt <= '1';
                    encrypt <= '0';
                    state <= dec_process;
                when enc_process =>
                    en_cnt <= '1';
                    encrypt <= '1';
                    encrypt_sig <= '1';
                    sel_lmux <= '1';
                    sel_rmux <= '1';
                    en_lreg <= '1';
                    en_rreg <= '1';
                    if round_reg /= "1111" and encrypt_sig = '1' then
                        round_reg <= std_logic_vector(unsigned(round_reg) + 1);
                    elsif round_reg = "1111" then
                        en_cnt <= '0';
                        encrypt <= '1';
                        encrypt_sig <= '0';
                        en_lreg <= '0';
                        en_rreg <= '0';                
                        en_swap <= '1';
                        en_invperm <= '1';
                        en_out <= '1';
                        state <= result;
                    end if;
                when dec_process =>
                    en_cnt <= '1';
                    encrypt <= '0';
                    decrypt_sig <= '1';
                    sel_lmux <= '1';
                    sel_rmux <= '1';
                    en_lreg <= '1';
                    en_rreg <= '1';
                    if round_reg /= "0000" and decrypt_sig = '1' then
                        round_reg <= std_logic_vector(unsigned(round_reg) - 1);
                    elsif round_reg = "0000" then
                        state <= result;
                        en_cnt <= '0';
                        encrypt <= '0';
                        decrypt_sig <= '0';
                        en_lreg <= '0';
                        en_rreg <= '0';                
                        en_swap <= '1';
                        en_invperm <= '1';
                        en_out <= '1';
                        state <= result;
                    end if;    
                when result =>
                    en_swap <= '0';
                    en_invperm <= '0';
                    en_out <= '0';
                
            end case;
        end if;
    end process;
    

end Behavioral;
