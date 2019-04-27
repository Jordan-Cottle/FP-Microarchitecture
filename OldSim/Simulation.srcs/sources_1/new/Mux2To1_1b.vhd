----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/10/2019 06:23:12 PM
-- Design Name: Mux2To1_1b
-- Module Name: Mux2To1_1b - Behavioral
-- Description: Muxes two 1 bit values
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

entity Mux2To1_1b is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           control : in STD_LOGIC;
           result : out STD_LOGIC);
end Mux2To1_1b;

architecture Behavioral of Mux2To1_1b is

begin
    result <= a when control = '0' else
              b;
end Behavioral;
