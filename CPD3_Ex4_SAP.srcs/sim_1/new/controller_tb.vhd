library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity controller_tb is
end;

architecture bench of controller_tb is

  component controller
      Port ( clk : in STD_LOGIC;
             nclr : in STD_LOGIC;
             inst : in STD_LOGIC_VECTOR (3 downto 0);
             cbus : out STD_LOGIC_VECTOR (11 downto 0);
             nhlt : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal nclr: STD_LOGIC;
  signal inst: STD_LOGIC_VECTOR (3 downto 0);
  signal cbus: STD_LOGIC_VECTOR (11 downto 0);
  signal nhlt: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: controller port map ( clk  => clk,
                             nclr => nclr,
                             inst => inst,
                             cbus => cbus,
                             nhlt => nhlt );

  stimulus: process
  begin
  
    -- Put initialisation code here
        nclr <= '1';
        inst <= "0000"; --LDA
        wait for clock_period * 6; 
        inst <= "0001"; --ADD
        wait for clock_period * 6;
        inst <= "0010"; --SUB
        wait for clock_period * 6;
        inst <= "1110"; --OUT
        wait for clock_period * 6;
        inst <= "1111"; --HLT
        wait for clock_period * 6;
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
  