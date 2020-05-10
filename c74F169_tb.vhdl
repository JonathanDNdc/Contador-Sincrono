library ieee;
use ieee.std_logic_1164.all;

entity c74F169_tb is
end c74F169_tb;

architecture arch of c74F169_tb is
    component c74F169 is
        port(
            D   : in  std_logic_vector(3 downto 0); -- Parallel data inputs
            CEP : in  std_logic;                    -- Count Enable parallel input (active Low)
            CET : in  std_logic;                    -- Count Enable Trickle input (active Low)
            CP  : in  std_logic;                    -- Clock input (active rising edge)
            PE  : in  std_logic;                    -- Parallel Enable input (active Low)
            UD  : in  std_logic;                    -- Up/Down count control input
            Q   : out std_logic_vector(3 downto 0); -- Flip-flop outputs
            TC  : out std_logic                     -- Terminal count output (active Low)
        );
    end component;
    signal CEP, CET, TC : std_logic;
    signal PE, UD       : std_logic;
    signal CP           : std_logic := '0';
    signal D, Q         : std_logic_vector(3 downto 0);
begin

        uut : c74F169 port map(D, CEP, CET, CP, PE, UD, Q, TC);

    CP <= not CP after 10 ns;

    process
    begin
        D <= "0110";
        UD <= '0';
        PE <= '0';
        CEP <= '0';
        CET <= '0';
        wait for 50 ns;
        UD <= '1';
        PE <= '1';
        wait for 500 ns;
        UD <= '0';
        wait for 500 ns;
        CEP <= '1';
        wait for 30 ns;
        wait; 
    end process;
end arch;