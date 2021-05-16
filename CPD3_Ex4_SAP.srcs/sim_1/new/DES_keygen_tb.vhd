-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DES_keygen_tb is
end;

architecture bench of DES_keygen_tb is

  component DES_keygen
      Port ( key : in STD_LOGIC_VECTOR (63 downto 0);
             round : in STD_LOGIC_VECTOR (3 downto 0);
             genKey : out STD_LOGIC_VECTOR (47 downto 0));
  end component;

  signal key: STD_LOGIC_VECTOR (63 downto 0);
  signal round: STD_LOGIC_VECTOR (3 downto 0);
  signal genKey: STD_LOGIC_VECTOR (47 downto 0);

begin

  uut: DES_keygen port map ( key    => key,
                             round  => round,
                             genKey => genKey );

  stimulus: process
  begin
  
    -- Put initialisation code here
    key <= x"AABB09182736CCDD";
    round <= "0000";
    wait for 10ns;
    round <= "0001";
    wait for 10ns;
    round <= "0010";
    wait for 10ns;
    round <= "1111";
    wait for 10ns;
    -- Put test bench stimulus code here

    wait;
  end process;


end;
  