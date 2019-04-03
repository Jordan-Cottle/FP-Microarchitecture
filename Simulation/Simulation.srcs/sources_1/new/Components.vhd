----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/03/2019 09:37:32 AM
-- Module Name: Components
-- Description: Contains declarations of components to use in project
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

package Components is
    component Decoder10to1024 is
        Port ( Input : in STD_LOGIC_VECTOR (9 downto 0);
               Control : in STD_LOGIC;
               Output : out STD_LOGIC_VECTOR (1023 downto 0));
    end component;
end Components;