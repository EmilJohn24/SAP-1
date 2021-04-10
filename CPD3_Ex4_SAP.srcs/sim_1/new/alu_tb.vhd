-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity alu_tb is
end;

architecture bench of alu_tb is

  component alu
      Port ( Eu : in STD_LOGIC;
             Su : in STD_LOGIC;
             ain : in STD_LOGIC_VECTOR (7 downto 0);
             bin : in STD_LOGIC_VECTOR (7 downto 0);
             wbus : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal Eu: STD_LOGIC;
  signal Su: STD_LOGIC;
  signal ain: STD_LOGIC_VECTOR (7 downto 0);
  signal bin: STD_LOGIC_VECTOR (7 downto 0);
  signal wbus: STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: alu port map ( Eu   => Eu,
                      Su   => Su,
                      ain  => ain,
                      bin  => bin,
                      wbus => wbus );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Eu <= '0';
    Su <= '0';
    ain <= "00101000";
    bin <= "00000011";
    wait for 10ns;
    Eu <= '1';
    wait for 10ns;
    Su <= '1';
    wait for 10ns;
    bin <= "00110010";

    -- Put test bench stimulus code here

    wait;
  end process;


end;