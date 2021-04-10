-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ram16x8_tb is
end;

architecture bench of ram16x8_tb is

  component ram16x8
      Port ( nCE : in STD_LOGIC;
             nWE : in STD_LOGIC;
             addr : in STD_LOGIC_VECTOR (3 downto 0);
             data : inout STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal nCE: STD_LOGIC;
  signal nWE: STD_LOGIC;
  signal addr: STD_LOGIC_VECTOR (3 downto 0);
  signal data: STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: ram16x8 port map ( nCE  => nCE,
                          nWE  => nWE,
                          addr => addr,
                          data => data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    --writing
    addr <= "0000";
    data <= "10010001";
    nCE <= '0';
    nWE <= '1';
    wait for 10ns;
    nCE <= '1';
    wait for 10ns;
    nWE <= '0';
    addr <= "0001";
    wait for 10ns;
    addr <= "0000"; 
    
    

    -- Put test bench stimulus code here

    wait;
  end process;


end;
  