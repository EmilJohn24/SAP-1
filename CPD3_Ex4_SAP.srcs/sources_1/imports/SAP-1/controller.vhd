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
           ready : out STD_LOGIC;
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
    alias U3 : STD_LOGIC is cbus(12);
    alias U2 : STD_LOGIC is cbus(11);
    alias U1 : STD_LOGIC is cbus(10);
    alias U0 : STD_LOGIC is cbus(9);
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
            STA5, STA6, STA7,
            MVI5, MVI6,
            ADD5,
            SUB5,
            JMP5,
            JC5,
            JNC5,
            JZ5,
            JNZ5,
            ORIANI5, ORIANI6, ORIANI7,
            RRC5,
            DEC5,
            HLT);
    
    type ins_cycle_count is array(7 downto 0) of integer;
    signal state : STATE_T := FETCH1;
    signal ready_sig : STD_LOGIC;
    signal instructionCount : integer := 0;
    signal cycleCount : integer := 0;
    signal count_trackers : ins_cycle_count := (others => 0);
    signal singleInsCycleCount : integer := 0;
begin
    controller_fsm : process(clk, nclr) 
    begin 
        if nclr = '0' then
            cbus <= (others => 'Z');
        elsif falling_edge(clk) then
            --begin fsm
            --empty state
            singleInsCycleCount <= singleInsCycleCount + 1;
            cycleCount <= cycleCount + 1;
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
                    count_trackers(singleInsCycleCount) <= count_trackers(singleInsCycleCount) + 1;
                    singleInsCycleCount <= 1;
                    instructionCount <= instructionCount + 1;
                    nLm <= '0';
                    Ep <= '1';
                    ready_sig <= '0';
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
                        when x"22" =>
                            nLm <='0';
                            Ep <= '1';
                            state <= MVI5;
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
                        when x"40" =>
                            nLt <= '0';
                            Eb <= '1';
                            state <= ADD5;
                        when x"42" =>
                            nLt <= '0';
                            Eb <= '1';
                            state <= SUB5;
                        when x"D0" =>
                            nLm <= '0';
                            Ep <= '1';
                            state <= JMP5;
                        when x"D2" =>
                            if C = '0' then
                                Cp <= '1';
                                state <=FETCH1;
                            else
                                nLm<='0';
                                Ep<='1';
                                state <= JC5;
                            end if; 
                        when x"D3" =>
                            if C = '1' then
                                Cp <= '1';
                                state <=FETCH1;
                            else
                                nLm<='0';
                                Ep<='1';
                                state <= JNC5;
                            end if; 
                        when x"D6" =>
                            if Z = '0' then
                                Cp <= '1';
                                state <=FETCH1;
                            else
                                nLm<='0';
                                Ep<='1';
                                state <= JZ5;
                            end if;
                         when x"D7" =>
                            if Z = '1' then
                                Cp <= '1';
                                state <=FETCH1;
                            else
                                nLm<='0';
                                Ep<='1';
                                state <= JNZ5;
                            end if;
                        when x"34" | x"38" =>
                            nLm <= '0';
                            Ep <= '1';
                            state <= ORIANI5;
                        when x"4E" =>
                            nLt <= '0';
                            Ec <= '1';
                            state <= DEC5;
                        when x"78" =>
                            U <= "1010";
                            Eu <= '1';
                            Lf <= '1';
                            state <= RRC5;
                        when x"EE" =>
                            --IN
                            if I = '1' then
                                Eip <= '1';
                                nLa <= '0';
                                ready_sig <= '1';
                            end if; 
                            state <= FETCH1;
                        when x"FF" =>
                            state <= HLT;
                        when others =>
                            state <= FETCH1;
                    end case;
                when RRC5 =>
                    Lf <= '0';
                    if C = '1' then
                        U <= "1011";
                    else
                        U <= "1010";
                    end if; 
                    Eu <= '1';
                    nLa <= '0';
                    state <= FETCH1;
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
                    nWE <= '0';
                    nCE <= '0';
                    Ea <= '1';
                    state <= FETCH1;
                when MVI5 =>
                    Cp <= '1';
                    state <= MVI6;
                when MVI6 =>
                    nLc <= '0';
                    nCE <= '0';
                    state<= FETCH1;
                when ADD5 =>
                    U<="0000";
                    Eu <= '1';
                    nLa <= '0';
                    state <= FETCH1;
                when SUB5 =>
                    U<="0001";
                    nLa <= '0';
                    Eu <= '1';
                    state <= FETCH1;
                when JMP5 | JZ5 | JNZ5 | JC5 | JNC5=>
                    nLp <= '0';
                    nCE <= '0';
                    state <= FETCH1;
                when ORIANI5 =>
                    Cp <= '1';
                    state <= ORIANI6;
                when ORIANI6 =>
                    --TMP <= RAM[MAR]
                    nLt <= '0';
                    nCE <= '0';
                    state <= ORIANI7;
                when ORIANI7 =>
                    if inst = x"34" then 
                        U <= "0011";
                    elsif inst = x"38" then 
                        U <= "0100";
                    end if;
                    nLa <= '0';
                    Eu <= '1';
                    Lf <= '1';
                    state <= FETCH1;
                when DEC5 =>
                    U <= "0111";
                    nLc <= '0';
                    Eu <= '1';
                    Lf <= '1';
                    state <= FETCH1;
                when HLT =>
                    nHlt <= '0';
                    state <= HLT;
                when others =>
                    nHlt <= '0';
                    state <= FETCH1; 
            end case;
        end if;
    end process;
    ready <= ready_sig;
--    ringctr : ctrl_ringctr port map (nclk => clk, nclr => nclr, state => state);
--    decoder : ctrl_decoder port map (inst => inst(7 downto 4), op_decode => op_decode);
--    matrix : ctrl_matrix port map (state => state, op_decode => op_decode, cbus => cbus, nhlt => nhlt);
end sap1;
