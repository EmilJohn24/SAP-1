-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity accreg_tb is
end;

architecture bench of accreg_tb is

  component accreg
      Port ( clk : in STD_LOGIC;
             Ea : in STD_LOGIC;
             nLa : in STD_LOGIC;
             wbus : inout STD_LOGIC_VECTOR (7 downto 0) := (others => 'Z');
             aluout : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal Ea: STD_LOGIC;
  signal nLa: STD_LOGIC;
  signal wbus: STD_LOGIC_VECTOR (7 downto 0) := (others => 'Z');
  signal aluout: STD_LOGIC_VECTOR (7 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: accreg port map ( clk    => clk,
                         Ea     => Ea,
                         nLa    => nLa,
                         wbus   => wbus,
                         aluout => aluout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wbus <= "10001000";
    nLa <= '1';
    Ea <= '0';
    wait for clock_period;
    wbus <= "ZZZZZZZZ";
    nLa <= '0';
    Ea <= '0';
    wait for clock_period;
    Ea <= '1';
    wait for clock_period;
    Ea <= '0';

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
  