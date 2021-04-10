-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity pc_tb is
end;

architecture bench of pc_tb is

  component pc
      Port ( nclk : in STD_LOGIC;
             nclr : in STD_LOGIC;
             Ep : in STD_LOGIC;
             Cp : in STD_LOGIC;
             wbus : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal nclk: STD_LOGIC;
  signal nclr: STD_LOGIC;
  signal Ep: STD_LOGIC;
  signal Cp: STD_LOGIC;
  signal wbus: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: pc port map ( nclk => nclk,
                     nclr => nclr,
                     Ep   => Ep,
                     Cp   => Cp,
                     wbus => wbus );

  stimulus: process
  begin
  
    -- Put initialisation code here
   Ep <= '1';
   Cp <= '1';
   nclr <= '0';
   wait for clock_period;
   nclr <= '1';
   wait for clock_period * 5;
   Cp <= '0';
   wait for clock_period;
   Ep <= '0';
   Cp <= '0';
   wait for clock_period;

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      nclk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;