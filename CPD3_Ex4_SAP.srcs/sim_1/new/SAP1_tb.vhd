-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity SAP1_tb is
end;

architecture bench of SAP1_tb is

  component SAP1
    Port (
          clk : in STD_LOGIC;
          clr : in STD_LOGIC;
          nhlt : out STD_LOGIC;
          dispout : out STD_LOGIC_VECTOR(7 downto 0)
     );
  end component;

  signal clk: STD_LOGIC;
  signal clr: STD_LOGIC;
  signal nhlt: STD_LOGIC;
  signal dispout: STD_LOGIC_VECTOR(7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: SAP1 port map ( clk     => clk,
                       clr     => clr,
                       nhlt    => nhlt,
                       dispout => dispout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    clr <= '1';
    wait for clock_period;
    clr <= '0';
    wait for 100 * clock_period;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;