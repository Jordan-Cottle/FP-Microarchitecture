----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/10/2019 06:21:14 PM
-- Design Name: Mux2To1_1b_tb
-- Module Name: Mux2To1_1b_tb - Behavioral
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.components.Mux2To1_1b;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2To1_1b_tb is
--  Port ( );
end Mux2To1_1b_tb;

architecture Behavioral of Mux2To1_1b_tb is
    signal a: std_logic;
    signal b: std_logic;
    signal control: std_logic;
    signal result: std_logic;
begin
UUT: Mux2To1_1b Port Map(a=>a, b=>b, control=>control, result=>result);
process
    variable count: integer := 0;
    variable vector: std_logic_vector(1 downto 0);
begin
    while(not (vector = "11")) loop
        vector := std_logic_vector(to_unsigned(count, 2));
        a <= vector(1);
        b <= vector(0);

        control <= '0';
        wait for 20ns;
        control <= '1';
        wait for 20ns;

        count := count + 1;
    end loop;
    
    wait;
end process;

end Behavioral;
