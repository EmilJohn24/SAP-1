----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 21:10:01
-- Design Name: 
-- Module Name: DES_SBoxes - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DES_SBoxes is
    Port ( data_in : in STD_LOGIC_VECTOR (47 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end DES_SBoxes;

architecture Behavioral of DES_SBoxes is
type sbox is array(0 to 3, 0 to 15) of integer range 0 to 15;
signal sbox_reg : STD_LOGIC_VECTOR(31 downto 0);
constant box1 : sbox := 
        ((14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7),
		(0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8),
		(4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0),
		(15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13));
constant box2: sbox:= 
		((15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10),
		(3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5),
		(0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15),
		(13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9));
constant box3: sbox:= 
		((10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8),
		(13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1),
		(13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7),
		(1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12));
constant box4: sbox:= 
		((7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15),
		(13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9),
		(10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4),
		(3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14));
constant box5: sbox:= 
		((2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9),
		(14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6),
		(4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14),
		(11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3));
constant box6: sbox:= 
		((12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11),
		(10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8),
		(9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6),
		(4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13));
constant box7: sbox:= 
		((4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1),
		(13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6),
		(1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2),
		(6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12));
constant box8: sbox:= 
		((13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7),
		(1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2),
		(7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8),
		(2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11));
		
function reverse (a: in std_logic_vector)
return std_logic_vector is
  variable result: std_logic_vector(a'RANGE);
  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
begin
  for i in aa'RANGE loop
    result(i) := aa(i);
  end loop;
  return result;
end; -- function reverse_any_vecto

begin
    data_out <= sbox_reg;
    SBOX1 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 0;
    variable input : std_logic_vector(5 downto 0);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box8(row, col), output'length));
        sbox_reg(3 downto 0) <= output;
    end process;
    
    SBOX2 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 1;
    variable input : std_logic_vector(5 downto 0) := data_in(((index + 1) * 6) - 1 downto index * 6);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box7(row, col), output'length));
        sbox_reg(7 downto 4) <= output;
    end process;
    
    SBOX3 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 2;
    variable input : std_logic_vector(5 downto 0) := data_in(((index + 1) * 6) - 1 downto index * 6);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box6(row, col), output'length));
        sbox_reg(11 downto 8) <= output;
    end process;
    
    SBOX4 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 3;
    variable input : std_logic_vector(5 downto 0) := data_in(((index + 1) * 6) - 1 downto index * 6);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);

        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box5(row, col), output'length));
        sbox_reg(15 downto 12) <= output;
    end process;
    
    SBOX5 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 4;
    variable input : std_logic_vector(5 downto 0) := data_in(((index + 1) * 6) - 1 downto index * 6);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box4(row, col), output'length));
        sbox_reg(19 downto 16) <= output;
    end process;
    
    SBOX6 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 5;
    variable input : std_logic_vector(5 downto 0) := data_in(((index + 1) * 6) - 1 downto index * 6);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box3(row, col), output'length));
        sbox_reg(23 downto 20) <= output;
    end process;
    
    SBOX7 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 6;
    variable input : std_logic_vector(5 downto 0);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box2(row, col), output'length));
        sbox_reg(27 downto 24) <= output;
    end process;
    
    SBOX8 : process(data_in) is
    variable row_concat : std_logic_vector(1 downto 0);
    variable col : integer range 0 to 15;
    variable row : integer range 0 to 3;
    variable index : integer := 7;
    variable input : std_logic_vector(5 downto 0);
    variable output : std_logic_vector(3 downto 0);
    begin
        input := data_in(((index + 1) * 6) - 1 downto index * 6);
        col := to_integer(unsigned(input(4 downto 1)));
        row_concat := input(5) & input(0);
        row := to_integer(unsigned(row_concat));
        output := std_logic_vector(to_unsigned(box1(row, col), output'length));
        sbox_reg(31 downto 28) <= output;
    end process;
    
end Behavioral;
