library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
    Port ( clk : in STD_LOGIC; -- clock
           nclr : in STD_LOGIC; -- reset controller
           inst : in STD_LOGIC_VECTOR (7 downto 0); -- connected to ireg
           flags : in STD_LOGIC_VECTOR (3 downto 0); --connected to flag register
           cbus : out STD_LOGIC_VECTOR (23 downto 0); -- control bus output
           nhlt : out STD_LOGIC); -- CPU halt signal
end controller;

architecture sap1 of controller is
--    component ctrl_ringctr is
--        Port ( nclk : in STD_LOGIC; -- clock
--               nclr : in STD_LOGIC; -- reset counter
--               state : out STD_LOGIC_VECTOR (5 downto 0)); -- ring counter state
--    end component;
--    component ctrl_decoder is
--        Port ( inst : in STD_LOGIC_VECTOR (3 downto 0); -- op code
--           op_decode : out STD_LOGIC_VECTOR (4 downto 0)); -- decoder output
--    end component;
--    component ctrl_matrix is
--        Port ( state : in STD_LOGIC_VECTOR (5 downto 0); -- ring counter state
--               op_decode : in STD_LOGIC_VECTOR (4 downto 0); -- decoder output
--               cbus : out STD_LOGIC_VECTOR (23 downto 0); -- control bus output
--               nhlt : out STD_LOGIC); -- CPU halt signal
--    end component;
    
--    signal state : STD_LOGIC_VECTOR (5 downto 0);
--    signal op_decode : STD_LOGIC_VECTOR (4 downto 0);
    alias C : STD_LOGIC is flags(0);
    alias Z : STD_LOGIC is flags(1);
    alias S : STD_LOGIC is flags(2);
    alias I : STD_LOGIC is flags(3);
    
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
    
    
    type STATE_T is (
            FETCH1, FETCH2, FETCH3, DECODE4,
            LDA5, LDA6, LDA7, LDA8,
            STA5, STA6, STA7);
    signal state : STATE_T := FETCH1;
begin
    controller_fsm : process(clk, nclr) 
    begin 
        if nclr = '0' then
            cbus <= (others => 'Z');
        elsif falling_edge(clk) then
            --begin fsm
            --empty state
            cbus <= (others => '0');
            nLo <= '1';
            nLc <= '1';
            nLb <= '1';
            nLt <= '1';
            nLa <= '1';
            nLi <= '1';
            nWE <= '1';
            nCE <= '1';
            nLm <= '1';
            nLp <= '1';
            nHlt <= '1'; 
            
            
            case state is 
                when FETCH1 =>
                    nLm <= '0';
                    Ep <= '1';
                    state <= FETCH2;
                when FETCH2 =>
                    Cp <= '1';
                    state <= FETCH3;
                when FETCH3 =>
                    nLi <= '0';
                    nCE <= '0';
                    state <= DECODE4;
                when DECODE4 =>
                    case inst is
                        when x"10" =>
                            nLm <= '0';
                            Ep <= '1';
                            state <= LDA5;
                        when x"18" =>
                            --STA
                            nLm <= '0';
                            Ep <= '1';
                            state <= STA5;
                        when x"24" =>
                            nLa <= '0';
                            Eb <= '1';
                            state <= FETCH1;
                        when x"25" =>
                            nLa <= '0';
                            Ec <= '1';
                            state <= FETCH1;
                        when x"28" =>
                            nLb <= '0';
                            Ea <= '1';
                            state <= FETCH1;
                        when x"29" =>
                            nLb <= '0';
                            Ec <= '1';
                            state <= FETCH1;
                        when x"2C" =>
                            nLc <= '0';
                            Ea <= '1';
                            state <= FETCH1;
                        when x"2D" =>
                            nLc <= '0';
                            Eb <= '1';
                            state <= FETCH1;
                        when others =>
                            state <= FETCH1;
                    end case;
                    
                when LDA5 =>
                    Cp <= '1';
                    state <= LDA6;
                when LDA6 =>
                    nLm <= '0';
                    nCE <= '0';
                    state <= LDA7;
                when LDA7 =>
                    nLA <= '0';
                    nCE <= '0';
                    state <= FETCH1;
                when STA5 =>
                    Cp <= '1';
                    state <= STA6;
                when STA6 =>
                    nLm <= '0';
                    nCE <= '0';
                    state <= STA7;
                when STA7 =>
                    nWE <= '1';
                    Ea <= '0';
                    state <= FETCH1;
                when others =>
                    nHlt <= '0';
                    state <= FETCH1; 
            end case;
        end if;
    end process;
--    ringctr : ctrl_ringctr port map (nclk => clk, nclr => nclr, state => state);
--    decoder : ctrl_decoder port map (inst => inst(7 downto 4), op_decode => op_decode);
--    matrix : ctrl_matrix port map (state => state, op_decode => op_decode, cbus => cbus, nhlt => nhlt);
end sap1;
