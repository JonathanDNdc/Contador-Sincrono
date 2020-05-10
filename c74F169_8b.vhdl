library ieee;
use ieee.std_logic_1164.all;

entity c74F169_8b is
    port(
        CLK : in  std_logic;
        UD  : in  std_logic;
        Q   : out std_logic_vector(7 downto 0)
    );
end c74F169_8b;

architecture arch of c74F169_8b is
    component c74F169 is
        port(
            D   : in  std_logic_vector(3 downto 0);
            CEP : in  std_logic;
            CET : in  std_logic;
            CP  : in  std_logic;
            PE  : in  std_logic;
            UD  : in  std_logic;
            Q   : out std_logic_vector(3 downto 0);
            TC  : out std_logic
        );
    end component;
    signal TC     : std_logic;
    signal LD     : std_logic := '0';
    signal temp   : std_logic_vector(7 downto 0);
    signal D1, D2 : std_logic_vector(3 downto 0);
begin
    D1 <= x"3" when (UD = '0') else x"0";
    D2 <= x"6" when (UD = '0') else x"0";
    LD <=
        '0' when (UD = '1' and temp = "01100011") or (UD = '0' and temp = "00000000") else '1';
    Q <= temp;
        c1 : c74F169 port map(D1, '0', '0', CLK, LD, UD, temp(3 downto 0), TC);
        c2 : c74F169 port map(D2, TC, '0', CLK, LD, UD, temp(7 downto 4), open);
end arch;