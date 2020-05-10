library ieee;
use ieee.std_logic_1164.all;

entity c74F169_8b_tb is
end c74F169_8b_tb;

architecture arch of c74F169_8b_tb is
    component c74F169_8b is
        port(
            CLK : in  std_logic;
            UD  : in  std_logic;
            Q   : out std_logic_vector(7 downto 0)
        );
    end component;
    signal CLK, UD : std_logic := '0';
    signal Q       : std_logic_vector(7 downto 0);
begin

        uut : c74F169_8b port map(CLK, UD, Q);

    CLK <= not CLK after 10 ns;

    process
    begin
    UD <= '0';
    wait for 3000 ns;
    UD <= '1';
    wait for 3000 ns;
    end process;

end arch;