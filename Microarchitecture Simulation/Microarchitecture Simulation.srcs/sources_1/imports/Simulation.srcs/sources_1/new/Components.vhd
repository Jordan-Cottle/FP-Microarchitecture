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
    
    component Registers_Fmain is
        Port ( Read_reg1 : in STD_LOGIC_VECTOR (4 downto 0);
               Read_reg2 : in STD_LOGIC_VECTOR (4 downto 0);
               Write_reg : in STD_LOGIC_VECTOR (4 downto 0);
               Write_Data : in STD_LOGIC_VECTOR (31 downto 0);
               RegWrite : in STD_LOGIC;
               ReadOut_Data1 : out STD_LOGIC_VECTOR (31 downto 0);
               ReadOut_Data2 : out STD_LOGIC_VECTOR (31 downto 0);
               clk: in STD_Logic
               );
    end component;
    
    component Data_Memory is
        Port ( Address : in STD_LOGIC_VECTOR (9 downto 0);
               Data_In : in STD_LOGIC_VECTOR (31 downto 0);
               Data_Out : out STD_LOGIC_VECTOR (31 downto 0);
               Mem_Write : in STD_LOGIC;
               clk: in STD_Logic
               );
    end component;
    
    component Instruction_Mem is
        Port ( PC : in STD_LOGIC_VECTOR (9 downto 0);
               Load_Address : in STD_LOGIC_VECTOR (9 downto 0);
               Load_File : in STD_LOGIC_VECTOR (31 downto 0);
               Load_Enable : in STD_LOGIC;
               Output_Data : out STD_LOGIC_VECTOR (31 downto 0);
               Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
               clk : in STD_LOGIC
               );
    end component;
    
    component PC is
        Port ( PC : out STD_LOGIC_VECTOR (9 downto 0);
               UB : in STD_LOGIC;
               NB : in STD_LOGIC;
               ZB : in STD_LOGIC;
               RDS : in STD_LOGIC;
               IVA : in STD_LOGIC;
               N : in STD_LOGIC;
               Z : in STD_LOGIC;
               BDEST : in STD_LOGIC_VECTOR (9 downto 0);
               clk : in STD_LOGIC);
    end component;
end Components;