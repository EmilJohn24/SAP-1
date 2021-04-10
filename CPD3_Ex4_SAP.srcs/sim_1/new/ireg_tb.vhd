-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ireg_tb is
end;

architecture bench of ireg_tb is

  component ireg
      Port ( clk : in STD_LOGIC;
             clr : in STD_LOGIC;
             nLi : in STD_LOGIC;
             nEi : in STD_LOGIC;
             wbus : inout STD_LOGIC_VECTOR (7 downto 0);
             inst : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal clr: STD_LOGIC;
  signal nLi: STD_LOGIC;
  signal nEi: STD_LOGIC;
  signal wbus: STD_LOGIC_VECTOR (7 downto 0);
  signal inst: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: ireg port map ( clk  => clk,
                       clr  => clr,
                       nLi  => nLi,
                       nEi  => nEi,
                       wbus => wbus,
                       inst => inst );

  stimulus: process
  begin
  
    -- Put initialisation code here


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