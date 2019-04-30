---------------------------------------------------------------------------------- 
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/29/2019 02:30:11 PM
-- Design Name: PC (Program Counter)
-- Module Name: PC - Behavioral
-- Description: Outputs the value to be read from the instruction memory. Receives all the control signals it needs to compute the next value
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

entity PC is
    Port ( PC : out STD_LOGIC_VECTOR (9 downto 0);
           UB : in STD_LOGIC;
           NB : in STD_LOGIC;
           ZB : in STD_LOGIC;
           RDS : in STD_LOGIC;
           IVA : in STD_LOGIC;
           N : in STD_LOGIC;
           Z : in STD_LOGIC;
           BDEST : in STD_LOGIC_VECTOR (9 downto 0);
           clk : in STD_LOGIC;
           start: in std_logic);
end PC;

architecture Behavioral of PC is

begin

process (clk)
    variable counter: integer:= 0;
begin
    if rising_edge(clk) and start = '1' then
        PC <= std_logic_vector(to_unsigned(counter, 10));
   
        if UB = '1' then -- branch
            counter := to_integer(unsigned(BDEST)); 
        elsif ((NB and N) = '1') or ((ZB and Z) = '1') then -- conditional branch condition was met
            counter := to_integer(unsigned(BDEST));
        elsif (RDS or IVA) = '1' then -- immediate value was used
            counter := counter + 2;
        else
            counter := counter + 1;
        end if;
    elsif start = '0' then
        PC <= "0000000000";
    end if;
end process;


end Behavioral;
