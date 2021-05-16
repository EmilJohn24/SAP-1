-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DES_unit_tb is
end;

architecture bench of DES_unit_tb is

  component DES_unit
      Port ( text_in : in STD_LOGIC_VECTOR (63 downto 0);
             key : in STD_LOGIC_VECTOR (63 downto 0);
             clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             mode : in STD_LOGIC;
             text_out : out STD_LOGIC_VECTOR (63 downto 0));
  end component;

  signal text_in: STD_LOGIC_VECTOR (63 downto 0);
  signal key: STD_LOGIC_VECTOR (63 downto 0);
  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal mode: STD_LOGIC;
  signal text_out: STD_LOGIC_VECTOR (63 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: DES_unit port map ( text_in  => text_in,
                           key      => key,
                           clk      => clk,
                           rst      => rst,
                           mode     => mode,
                           text_out => text_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    text_in <= x"C0B7A8D05F3A829C";
    key <= x"AABB09182736CCDD";
    mode <= '0'; --encrypt mode

    -- Put test bench stimulus code here

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