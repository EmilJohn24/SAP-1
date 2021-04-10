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
    signal result : STD_LOGIC_VECTOR (7 downto 0);
    alias C : STD_LOGIC is flags(0);
    alias Z : STD_LOGIC is flags(1);
    alias S : STD_LOGIC is flags(2);
    alias I : STD_LOGIC is flags(3);
    
begin
alu_proc : process (ain, bin, U) is
    variable tmpResult : STD_LOGIC_VECTOR(8 downto 0);
    begin
        case U is
            when "0000" =>
                --addition 
                tmpResult := ('0' & ain) + ('0' & bin);
                result <= ain + bin;
                C <= tmpResult(8);
            when "0001" =>
                --subtraction
                tmpResult := ('0' & ain) + not ('0' & bin) + 1;
                result <= ain + not bin + 1;
                C <= tmpResult(8);
            when "0010" =>
                result <= not ain;
            when "0011" =>
                result <= ain or bin;
            when "0100" =>
                result <= ain and bin;
            when "0101" =>
                result <= ain xor bin;
            when "0110" =>
                result <= bin + 1;
            when "0111" =>
                result <= bin - 1;
            when "1000" | "1001" =>
                C <= ain(7);
                result(7 downto 1) <= ain(6 downto 0);
                result(0) <= U(0);
            when "1010" | "1011" =>
                C <= ain(0);
                result(6 downto 0) <= ain(7 downto 1);
                result(7) <= U(0);
            when "1110" | "1111" =>
                C <= U(0);
            when others =>
                flags <= (others => '0');
        end case;
    end process;
    wbus <= result when Eu = '1' else (others => 'Z');
    Z <= '1' when result = "00000000" else '0';
    S <= result(7);
end sap1;
