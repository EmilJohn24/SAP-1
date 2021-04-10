-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity outreg_tb is
end;

architecture bench of outreg_tb is

  component outreg
      Port ( clk : in STD_LOGIC;
             nLo : in STD_LOGIC;
             wbus : in STD_LOGIC_VECTOR (7 downto 0);
             dispout : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal nLo: STD_LOGIC;
  signal wbus: STD_LOGIC_VECTOR (7 downto 0);
  signal dispout: STD_LOGIC_VECTOR (7 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: outreg port map ( clk     => clk,
                         nLo     => nLo,
                         wbus    => wbus,
                         dispout => dispout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wbus <= "10001000";
    nLo <= '1';
    wait for clock_period;
    wbus <= "11100100";
    nLo <= '0';
    wait for clock_period;

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
  