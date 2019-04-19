----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/18/2019 12:45:37 AM
-- Module Name: add_tb - Behavioral
-- Description: testing of fpAdd function
-- 
-- Dependencies: Math.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.math.fpadd;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add_tb is
--  Port ( );
end add_tb;

architecture Behavioral of add_tb is
    signal a: std_logic_vector(31 downto 0);
    signal b: std_logic_vector(31 downto 0);
    signal c: std_logic_vector(31 downto 0);
begin
    process
        variable aVec: std_logic_vector(31 downto 0);
        variable bVec: std_logic_vector(31 downto 0);
        variable cVec: std_logic_vector(31 downto 0);
    begin
        aVec := "00111111100000000000000000000000";
        a <= aVec;
        bVec := "00111111100000000000000000000000";
        b <= bVec;
        cVec := fpAdd(aVec,bVec);
        c <= cVec;
        wait;
    end process;
end Behavioral;
