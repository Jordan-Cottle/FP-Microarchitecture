----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 03/07/2019 06:20:05 PM
-- Design Name: Decoder 10-1024
-- Module Name: Decoder10to1024 - Behavioral
-- Project Name: FP-Microarchitecture Simulation
-- Description: Standard 10 to 1024 decoder
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity Decoder10to1024 is
    Port ( Input : in STD_LOGIC_VECTOR (9 downto 0);
           Control : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (1023 downto 0));
end Decoder10to1024;

architecture Behavioral of Decoder10to1024 is

begin

    process(Input, Control)
        variable num : integer;
        variable result: STD_LOGIC_VECTOR (1023 downto 0);
    begin
        num := to_integer(Unsigned(Input));
        result := (others => '0');

        if Control = '0' then
            result(num) := '1';
        end if;

        Output <= result;
    end process;

end Behavioral;
