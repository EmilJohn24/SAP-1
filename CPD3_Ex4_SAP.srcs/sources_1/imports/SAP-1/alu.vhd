library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( Eu : in STD_LOGIC; -- enable output
           U : in STD_LOGIC_VECTOR(3 downto 0); -- operation
           ain : in STD_LOGIC_VECTOR (7 downto 0); -- connected to accreg
           bin : in STD_LOGIC_VECTOR (7 downto 0); -- connected to breg
           flags : out STD_LOGIC_VECTOR (3 downto 0); --flags
           wbus : out STD_LOGIC_VECTOR (7 downto 0)); -- connected to W bus
end alu;

architecture sap1 of alu is
    signal result : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    alias C : STD_LOGIC is flags(0);
    alias Z : STD_LOGIC is flags(1);
    alias S : STD_LOGIC is flags(2);
    alias I : STD_LOGIC is flags(3);
    
begin
alu_proc : process (U, ain, bin) is
    variable ain9 : STD_LOGIC_VECTOR(8 downto 0);
    variable bin9 : STD_LOGIC_VECTOR(8 downto 0);
    begin
        ain9 := '0' & ain;
        bin9 := '0' & bin;
        case U is
            when "0000" =>
                --addition 
                result <= ain9 + bin9;
            when "0001" =>
                --subtraction
                result <= ain9 + not bin9 + 1;
            when "0010" =>
                result <= not ain9;
            when "0011" =>
                result <= ain9 or bin9;
            when "0100" =>
                result <= ain9 and bin9;
            when "0101" =>
                result <= ain9 xor bin9;
            when "0110" =>
                result <= bin9 + 1;
            when "0111" =>
                result <= bin9 - 1;
            when "1000" | "1001" =>
                result(8 downto 1) <= ain(7 downto 0);
                result(0) <= U(0);
            when "1010" | "1011" =>
                result(8) <= ain(0);
                result(6 downto 0) <= ain(7 downto 1);
                result(7) <= U(0);
            when "1110" | "1111" =>
                result(8) <= U(0);
            when others =>
                result <= (others => '0');
        end case;
    end process;
    wbus <= result(7 downto 0) when Eu = '1' else (others => 'Z');
    C <= result(8);
    Z <= '1' when result(7 downto 0) = "00000000" else '0';
    S <= result(7);
end sap1;
