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

    component Mux2To1_32b is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component Mux2To1_1b is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               control : in STD_LOGIC;
               result : out STD_LOGIC);
    end component;
    
    component ALU is
        Port ( opCode : in STD_LOGIC_VECTOR (3 downto 0);
               a : in STD_LOGIC_VECTOR (31 downto 0);
               b : in STD_LOGIC_VECTOR (31 downto 0);
               result : out STD_LOGIC_VECTOR (31 downto 0);
               z : out STD_LOGIC; -- zero
               n : out STD_LOGIC; -- negative
               e : out std_logic); -- error
    end component;
end Components;