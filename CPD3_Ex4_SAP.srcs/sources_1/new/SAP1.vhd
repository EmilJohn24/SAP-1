----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 21:04:33
-- Design Name: 
-- Module Name: SAP1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SAP1 is
  Port (
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        nhlt : out STD_LOGIC;
        dispout : out STD_LOGIC_VECTOR(7 downto 0)
   );
end SAP1;

architecture Behavioral of SAP1 is

component controller is
    Port ( clk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset controller
           inst : in STD_LOGIC_VECTOR (7 downto 0); -- connected to ireg
           flags : in STD_LOGIC_VECTOR (3 downto 0); --connected to flags
           cbus : out STD_LOGIC_VECTOR (23 downto 0); -- control bus output
           nhlt : out STD_LOGIC); -- CPU halt signal
end component;

component accreg is
    Port ( clk : in STD_LOGIC; -- clock
           Ea : in STD_LOGIC; -- enable output
           nLa : in STD_LOGIC; -- load data from W bus
           wbus : inout STD_LOGIC_VECTOR (7 downto 0) := (others => 'Z'); -- connected to W bus
           aluout : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to ALU
end component;

component alu is
    Port ( Eu : in STD_LOGIC; -- enable output
           U : in STD_LOGIC_VECTOR(3 downto 0); -- operation, add if Su = 0, subtract if Su = 1
           ain : in STD_LOGIC_VECTOR (7 downto 0); -- connected to accreg
           bin : in STD_LOGIC_VECTOR (7 downto 0); -- connected to breg
           flags : out STD_LOGIC_VECTOR(3 downto 0);
           wbus : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component breg is
    Port ( clk : in STD_LOGIC; -- clock
           nLb : in STD_LOGIC; -- load data from W bus
           Eb : in STD_LOGIC; --enable output
           wbus : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component creg is
    Port ( clk : in STD_LOGIC; -- clock
           nLc : in STD_LOGIC; -- load data from W bus
           Ec : in STD_LOGIC; --enable output
           wbus : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component ireg is
    Port ( clk : in STD_LOGIC; -- clock
           clr : in STD_LOGIC; -- reset instruction
           nLi : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           inst : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to controller
end component;

component memaddreg is
    Port ( clk : in STD_LOGIC; -- clock
           nLm : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           memaddr : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to memory address
end component;

component outreg is
    Port ( clk : in STD_LOGIC; -- clock
           nLo : in STD_LOGIC; -- load data from W bus
           wbus : in STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           dispout : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to binary display
end component;

component pc is
    Port ( nclk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset count
           Ep : in STD_LOGIC; -- enable output
           Cp : in STD_LOGIC; -- increment count
           nLp : in STD_LOGIC; --enable load
           wbus : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component ram16x8 is
    Port ( nCE : in STD_LOGIC; -- enable memory output
           nWE : in STD_LOGIC; -- read/write, read if nWE = 1, write if nWE = 0
           addr : in STD_LOGIC_VECTOR (3 downto 0); -- connected to memaddreg
           clk : in STD_LOGIC; --clock
           data : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component TmpReg is
    Port ( clk : in STD_LOGIC; -- clock
           nLt : in STD_LOGIC; -- load data from W bus
           Et : in STD_LOGIC; -- enable output data to W bus
           wbus : inout STD_LOGIC_VECTOR (7 downto 0); -- connected to W bus
           aluout : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to ALU
end component;
component ram256x8 is
    Port ( nCE : in STD_LOGIC; -- enable memory output
           nWE : in STD_LOGIC; -- read/write, read if nWE = 1, write if nWE = 0
           addr : in STD_LOGIC_VECTOR (7 downto 0); -- connected to memaddreg
           clk : in STD_LOGIC; --clock
           data : inout STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end component;

component flagReg is
    Port ( Lf : in STD_LOGIC; --load flags from ALU
           aluFlagIn : in STD_LOGIC_VECTOR (3 downto 0);
           ctrlFlagOut : out STD_LOGIC_VECTOR (3 downto 0));
end component;
    signal wbus : STD_LOGIC_VECTOR(7 downto 0);
    
    --PC
--    signal Cp : STD_LOGIC;
--    signal Ep : STD_LOGIC;
    
    --A
--    signal nLa : STD_LOGIC;
--    signal Ea : STD_LOGIC;
    
    --MAR
    signal memaddr : STD_LOGIC_VECTOR(7 downto 0);
--    signal nLm : STD_LOGIC; 
    
    --ALU
--    signal Su : STD_LOGIC;
--    signal Eu : STD_LOGIC; 
    
    --RAM
--    signal nCE : STD_LOGIC;
--    signal nWE : STD_LOGIC;
    
    --Register B
--    signal nLb : STD_LOGIC;
    signal tmpregout : STD_LOGIC_VECTOR(7 downto 0);
    
    --Register I
--    signal nLi : STD_LOGIC;
--    signal nEi : STD_LOGIC;
    signal inst : STD_LOGIC_VECTOR(7 downto 0);
    
    --Output register
--    signal nLo : STD_LOGIC;
    signal ain : STD_LOGIC_VECTOR(7 downto 0);
    --Controller
    signal cbus : STD_LOGIC_VECTOR(23 downto 0);
    signal nClr : STD_LOGIC;
    signal nClk : STD_LOGIC;
    
    signal aluFlagOut : STD_LOGIC_VECTOR(3 downto 0);
    signal ctrlFlagIn : STD_LOGIC_VECTOR(3 downto 0);
--    signal nWE : STD_LOGIC := '1';

    alias Ep : STD_LOGIC is cbus(22);
    alias Cp : STD_LOGIC is cbus(21);
    alias nLp : STD_LOGIC is cbus(20);
    alias nLm : STD_LOGIC is cbus(19);
    alias nCE : STD_LOGIC is cbus(18);
    alias nWE : STD_LOGIC is cbus(17);
    alias nLi : STD_LOGIC is cbus(16);
    alias Ea : STD_LOGIC is cbus(15);
    alias nLa : STD_LOGIC is cbus(14);
    alias Eu : STD_LOGIC is cbus(13);
    alias U : STD_LOGIC_VECTOR is cbus(12 downto 9);
    alias Lf : STD_LOGIC is cbus(8);
    alias Et : STD_LOGIC is cbus(7);
    alias nLt : STD_LOGIC is cbus(6);
    alias Eb : STD_LOGIC is cbus(5);
    alias nLb : STD_LOGIC is cbus(4);
    alias Ec : STD_LOGIC is cbus(3);
    alias nLc : STD_LOGIC is cbus(2);
    alias Eip : STD_LOGIC is cbus(1);
    alias nLo : STD_LOGIC is cbus(0); 
begin
    nClr <= not clr;
    nClk <= not clk;
    CONTROL : controller port map(
                             clk => clk,
                             nclr => nClr,
                             inst => inst,
                             flags => ctrlFlagIn,
                             cbus => cbus,
                             nhlt => nhlt);
     ACC : accreg port map(
                             clk => clk,
                             Ea => Ea,
                             nLa => nLa,
                             wbus => wbus,
                             aluout => ain);
     ALU_Module : alu port map(
                             Eu => Eu,
                             U => U,
                             ain => ain,
                             bin => tmpregout,
                             flags => aluFlagOut,
                             wbus => wbus);
     FLAGREG_Module : flagreg port map(
                             Lf => Lf,
                             aluFlagIn => aluFlagOut,
                             ctrlFlagOut => ctrlFlagIn);
     BREG_Module : breg port map(
                             clk => clk,
                             nLb => nLb,
                             Eb => Eb,
                             wbus => wbus);
     CREG_Module : creg port map(
                             clk => clk,
                             nLc => nLc,
                             Ec => Ec,
                             wbus => wbus);
     TMPTEG_Module : tmpreg port map(
                             clk => clk,
                             nLt => nLt,
                             Et => Et,
                             wbus => wbus,
                             aluout => tmpregout);
     IREG_Module : ireg port map(
                             clk => clk,
                             clr => clr,
                             nLi => nLi,
                             wbus => wbus,
                             inst => inst);
     MAR : memaddreg port map(
                             clk => clk,
                             nLm => nLm,
                             wbus => wbus,
                             memaddr => memaddr);
     OUTREG_Module : outreg port map(
                             clk => clk,
                             nLo => nLo,
                             wbus => wbus,
                             dispout => dispout);
     PC_Unit : PC port map(
                             nclk => nClk,
                             nclr => nClr,
                             Ep => Ep,
                             Cp => Cp,
                             nLp => nLp,
                             wbus => wbus);
     RAM : ram256x8 port map(
                             nCE => nCE,
                             nWE => nWE,
                             addr => memaddr,
                             clk => clk,
                             data => wbus);
                             
    process (clk) begin
        if rising_edge(clk) then
        
        end if;
    end process;                                
                             
    
end Behavioral;
