library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c74F169 is
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
end c74F169;

architecture arch of c74F169 is
    signal temp : std_logic_vector(3 downto 0) := x"0";
begin
    process (CP)
    begin
        if rising_edge(CP) then
            if (PE = '0') then
                temp <= D;
                TC <= '1';
            elsif (CEP = '1') or (CET = '1') then
                TC <= '1';
            elsif (UD = '1') then
                temp <= std_logic_vector(unsigned(temp) + 1);
                if (CET = '0') and (temp = "1110") then TC <= '0'; else TC <= '1'; end if;
            elsif (UD = '0') then
                temp <= std_logic_vector(unsigned(temp) - 1);
                if (CET = '0') and (temp = "0001") then TC <= '0'; else TC <= '1'; end if;
            else
                null;
            end if;
        end if;
    end process;
    Q <= temp;
end arch;