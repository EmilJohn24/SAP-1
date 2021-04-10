library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ctrl_matrix is
    Port ( state : in STD_LOGIC_VECTOR (5 downto 0); -- ring counter state
           op_decode : in STD_LOGIC_VECTOR (4 downto 0); -- decoder output
           cbus : out STD_LOGIC_VECTOR (23 downto 0); -- control bus output
           nhlt : out STD_LOGIC); -- CPU halt signal
end ctrl_matrix;

architecture sap1 of ctrl_matrix is
-- state aliases
    alias T1 : STD_LOGIC is state(0);
    alias T2 : STD_LOGIC is state(1);
    alias T3 : STD_LOGIC is state(2);
    alias T4 : STD_LOGIC is state(3);
    alias T5 : STD_LOGIC is state(4);
    alias T6 : STD_LOGIC is state(5);

-- op_decode aliases
    alias lda : STD_LOGIC is op_decode(0);
    alias add : STD_LOGIC is op_decode(1);
    alias sub : STD_LOGIC is op_decode(2);
    alias outr : STD_LOGIC is op_decode(3);
    alias invhlt : STD_LOGIC is op_decode(4);

-- cbus aliases
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
   
end sap1;
