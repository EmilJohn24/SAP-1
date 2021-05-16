-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DES_SBoxes_tb is
end;

architecture bench of DES_SBoxes_tb is

  component DES_SBoxes
      Port ( data_in : in STD_LOGIC_VECTOR (47 downto 0);
             data_out : out STD_LOGIC_VECTOR (31 downto 0));
  end component;

  signal data_in: STD_LOGIC_VECTOR (47 downto 0);
  signal data_out: STD_LOGIC_VECTOR (31 downto 0);

begin

  uut: DES_SBoxes port map ( data_in  => data_in,
                             data_out => data_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
--    data_in <= (others => '0');
    data_in <= x"505050505050";
    wait for 10ns;
    data_in <= x"515151515151";
    -- Put test bench stimulus code here

    wait;
  end process;


end;
  