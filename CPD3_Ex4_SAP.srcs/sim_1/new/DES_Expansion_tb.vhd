-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DES_Expansion_tb is
end;

architecture bench of DES_Expansion_tb is

  component DES_Expansion
      Port ( exp_in : in STD_LOGIC_VECTOR (31 downto 0);
             exp : out STD_LOGIC_VECTOR (47 downto 0));
  end component;

  signal exp_in: STD_LOGIC_VECTOR (31 downto 0);
  signal exp: STD_LOGIC_VECTOR (47 downto 0);

begin

  uut: DES_Expansion port map ( exp_in => exp_in,
                                exp    => exp );

  stimulus: process
  begin
  
    -- Put initialisation code here
    exp_in <= x"18CA18AD";

    -- Put test bench stimulus code here

    wait;
  end process;


end;
  