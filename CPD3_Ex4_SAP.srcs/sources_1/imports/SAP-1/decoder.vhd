library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ctrl_decoder is
    Port ( inst : in STD_LOGIC_VECTOR (3 downto 0); -- op code
           op_decode : out STD_LOGIC_VECTOR (4 downto 0)); -- decoder output
end ctrl_decoder;
-- for op_decode, note the following:
-- op_decode(0) is lda
-- op_decode(1) is add
-- op_decode(2) is sub
-- op_decode(3) is outr
-- op_decode(4) is nhlt

architecture sap1 of ctrl_decoder is

begin
    with inst select
        op_decode <= "10001" when "0000",
            "10010" when "0001",
            "10100" when "0010",
            "11000" when "1110",
            "00000" when "1111",
            (others => 'Z') when others;
end sap1;
