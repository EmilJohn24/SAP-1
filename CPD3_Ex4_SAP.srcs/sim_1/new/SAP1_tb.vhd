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
          input : in STD_LOGIC_VECTOR(7 downto 0);
          interrupt : in STD_LOGIC;
          nhlt : out STD_LOGIC;
          ready : out STD_LOGIC;
          dispout : out STD_LOGIC_VECTOR(7 downto 0)
     );
  end component;

  signal clk: STD_LOGIC;
  signal clr: STD_LOGIC;
  signal nhlt: STD_LOGIC;
  signal input : STD_LOGIC_VECTOR(7 downto 0);
  signal interrupt : STD_LOGIC;
  signal ready : STD_LOGIC;
  signal dispout: STD_LOGIC_VECTOR(7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: SAP1 port map ( clk     => clk,
                       clr     => clr,
                       input => input,
                       interrupt => interrupt,
                       nhlt    => nhlt,
                       ready => ready,
                       dispout => dispout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    clr <= '1';
    input <= x"0F";
    interrupt <= '1';
    wait for clock_period;
    clr <= '0';
--    240 => x"15",
--241 => "11111001",    
    loop
        if ready = '1' then  
            input <= "11111001";
            interrupt <= '1';
            wait for clock_period * 10;
            interrupt <= '0';
            exit;
        end if;
        wait for clock_period;
    end loop;
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