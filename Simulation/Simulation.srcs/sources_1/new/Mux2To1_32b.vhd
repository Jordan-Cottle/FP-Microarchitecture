----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/09/2019 09:59:52 PM
-- Design Name: Mux2To1
-- Module Name: Mux2To1 - Behavioral
-- Description: Muxes two 32 bit values
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2To1_32b is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
end Mux2To1_32b;

architecture Behavioral of Mux2To1_32b is
    
begin
    result <= a when control = '0' else
              b;
end Behavioral;
