----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 11:47:34
-- Design Name: 
-- Module Name: DES_datapath - Behavioral
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

entity DES_datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           key : in STD_LOGIC_VECTOR(63 downto 0);
           round : in STD_LOGIC_VECTOR(3 downto 0);
           des_ctrl : in STD_LOGIC_VECTOR (8 downto 0);
           text_in : in STD_LOGIC_VECTOR (63 downto 0);
           oe : in STD_LOGIC; --output enable
           text_out : out STD_LOGIC_VECTOR (63 downto 0));
end DES_datapath;

architecture Behavioral of DES_datapath is
    component DES_DataSwapping is
        Port ( swap_in_msb : in STD_LOGIC_VECTOR (31 downto 0);
               swap_in_lsb : in STD_LOGIC_VECTOR (31 downto 0);
               clk : in STD_LOGIC;
               en_swap : in STD_LOGIC;
               swap_out : out STD_LOGIC_VECTOR (63 downto 0));
    end component;
    
    component DES_Expansion is
    Port ( exp_in : in STD_LOGIC_VECTOR (31 downto 0);
           exp : out STD_LOGIC_VECTOR (47 downto 0));
    end component;
    
    component DES_InitialPermutation is
    Port ( text_in : in STD_LOGIC_VECTOR (63 downto 0);
           perm : out STD_LOGIC_VECTOR (63 downto 0));
    end component;

    component DES_InversePermutation is
    Port ( perm_in : in STD_LOGIC_VECTOR (63 downto 0);
           perm : out STD_LOGIC_VECTOR (63 downto 0));
    end component;
    
    component DES_Mux31b_2to1 is
    Port ( I0 : in STD_LOGIC_VECTOR (31 downto 0);
           I1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
 
    component DES_Permutation is
    Port ( perm_in : in STD_LOGIC_VECTOR (31 downto 0);
           perm : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component DES_Reg32 is
    Port ( D : in STD_LOGIC_VECTOR (31 downto 0);
           EN_Reg : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component DES_SBoxes is
    Port ( data_in : in STD_LOGIC_VECTOR (47 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component DES_keygen is
    Port ( key : in STD_LOGIC_VECTOR (63 downto 0);
           round : in STD_LOGIC_VECTOR (3 downto 0);
           genKey : out STD_LOGIC_VECTOR (47 downto 0));
    end component;
    
    component DES_OutReg is
    Port ( D : in STD_LOGIC_VECTOR (63 downto 0);
           en_out : in STD_LOGIC;
           oe : in STD_LOGIC; --output enable
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (63 downto 0));
    end component;
    alias en_cnt : STD_LOGIC is des_ctrl(8);
    alias sel_lmux : STD_LOGIC is des_ctrl(7);
    alias sel_rmux : STD_LOGIC is des_ctrl(6);
    alias en_lreg : STD_LOGIC is des_ctrl(5);
    alias en_rreg : STD_LOGIC is des_ctrl(4);
    alias en_swap : STD_LOGIC is des_ctrl(3);
    alias en_invperm : STD_LOGIC is des_ctrl(2);
    alias en_out : STD_LOGIC is des_ctrl(1);
    alias encrypt : STD_LOGIC is des_ctrl(0);
    
    signal init_perm_out : STD_LOGIC_VECTOR(63 downto 0);
    signal lmux_out : STD_LOGIC_VECTOR(31 downto 0);
    signal rmux_out : STD_LOGIC_VECTOR(31 downto 0);
    signal lreg_out : STD_LOGIC_VECTOR(31 downto 0);
    signal rreg_out : STD_LOGIC_VECTOR(31 downto 0);
    signal exp_out : STD_LOGIC_VECTOR(47 downto 0);
    signal xor_48_out : STD_LOGIC_VECTOR(47 downto 0);
    signal sbox_out : STD_LOGIC_VECTOR(31 downto 0);
    signal perm_out : STD_LOGIC_VECTOR(31 downto 0);
    signal xor_32_out : STD_LOGIC_VECTOR(31 downto 0);
    signal swap_out : STD_LOGIC_VECTOR(63 downto 0);
    signal inv_perm_out : STD_LOGIC_VECTOR(63 downto 0);
    signal curr_key : STD_LOGIC_VECTOR(47 downto 0);
begin
    INIT_PERM : DES_InitialPermutation port map(text_in => text_in,
                                                perm => init_perm_out);
--    LMUX : DES_Mux31b_2to1 port map(I0 => init_perm_out(31 downto 0), 
--                                    I1 => rreg_out,
--                                    sel => sel_lmux,
--                                    O => lmux_out);
--    RMUX : DES_Mux31b_2to1 port map(I0 => init_perm_out(63 downto 32), 
--                                    I1 => xor_32_out,
--                                    sel => sel_rmux,
--                                    O => rmux_out);
    LMUX : DES_Mux31b_2to1 port map(I0 => init_perm_out(63 downto 32), 
                                    I1 => rreg_out,
                                    sel => sel_lmux,
                                    O => lmux_out);
    RMUX : DES_Mux31b_2to1 port map(I0 => init_perm_out(31 downto 0), 
                                    I1 => xor_32_out,
                                    sel => sel_rmux,
                                    O => rmux_out);
    LREG : DES_Reg32 port map(D => lmux_out,
                              EN_Reg => en_lreg,
                              reset => rst,
                              clk => clk,
                              Q => lreg_out);
    RREG : DES_Reg32 port map(D => rmux_out,
                              EN_Reg => en_rreg,
                              reset => rst,
                              clk => clk,
                              Q => rreg_out);
                                    
    EXP : DES_Expansion port map(exp_in => rreg_out,
                                 exp => exp_out);
    KEYGEN : DES_keygen port map(key => key,
                                 round => round,
                                 genKey => curr_key);
    xor_48_out <= curr_key xor exp_out;
    
    SBOXES : DES_SBoxes port map(data_in => xor_48_out,
                                 data_out => sbox_out);
    
    PERM : DES_Permutation port map(perm_in => sbox_out,
                                    perm => perm_out);
    xor_32_out <=  lreg_out xor perm_out;
    SWAP : DES_DataSwapping port map(swap_in_msb => xor_32_out,
                                     swap_in_lsb => rreg_out,
                                     en_swap => en_swap,
                                     clk => clk,
                                     swap_out => swap_out);
     INV_PERM : DES_InversePermutation port map(perm_in => swap_out,
                                                perm => inv_perm_out);
     OUT_REG : DES_OutReg port map(D => inv_perm_out,
                                   oe => oe,
                                   clk => clk,
                                   en_out => en_out,
                                   Q => text_out);                                                                  
end Behavioral;
