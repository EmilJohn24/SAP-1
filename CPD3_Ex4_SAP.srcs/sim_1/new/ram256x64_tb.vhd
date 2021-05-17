-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ram256x64_tb is
end;

architecture bench of ram256x64_tb is

  component ram256x64
      Port ( nCE : in STD_LOGIC;
             nWE_byte : in STD_LOGIC;
             nWE_word : in STD_LOGIC;
             RD_byte : in STD_LOGIC;
             addr : in STD_LOGIC_VECTOR (7 downto 0);
             clk : in STD_LOGIC;
             data : inout STD_LOGIC_VECTOR (63 downto 0));
  end component;

  signal nCE: STD_LOGIC;
  signal nWE_byte: STD_LOGIC;
  signal nWE_word: STD_LOGIC;
  signal RD_byte: STD_LOGIC;
  signal addr: STD_LOGIC_VECTOR (7 downto 0);
  signal clk: STD_LOGIC;
  signal data: STD_LOGIC_VECTOR (63 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: ram256x64 port map ( nCE      => nCE,
                            nWE_byte => nWE_byte,
                            nWE_word => nWE_word,
                            RD_byte  => RD_byte,
                            addr     => addr,
                            clk      => clk,
                            data     => data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    nWE_byte <= '1';
    nWE_word <= '0';
    RD_byte <= '0';
    nCE <= '0';
    addr <= x"00";
    data <= x"CAFEFEFEAAFEDAFE";
    wait for clock_period;
    data <= (others => 'Z');
    nWE_byte <= '0';
    nWE_word <= '0';
    RD_byte <= '1';
    nCE <= '0';
    addr <= x"00";
--    data <= x"FEFEFEFEFEFEFEFE";
    wait for clock_period;
    
    
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