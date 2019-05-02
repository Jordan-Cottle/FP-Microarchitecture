----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2019 12:17:30 PM
-- Design Name: 
-- Module Name: FX_ID - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
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

entity IF_ID is
    Port ( Instruction : in STD_LOGIC_VECTOR (31 downto 0);
           Immidiate_In : in STD_LOGIC_VECTOR (31 downto 0);
           BDest : out STD_LOGIC_VECTOR (9 downto 0);
           Opcode : out STD_LOGIC_VECTOR (4 downto 0);
           R1 : out std_logic_vector (3 downto 0);
           R2 : out std_logic_vector (3 downto 0);
           Rd : out std_logic_vector (3 downto 0);
           Immidiate_Out : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC
           );
end IF_ID;
architecture Behavioral of IF_ID is

begin
process(clk)
--Defing the signals...
variable Instruction_value : std_logic_vector(31 downto 0);
variable Immidiate_value : std_logic_vector(31 downto 0);
begin
        if rising_edge(clk) then            -- loading the input values...                               -- Omitting out the values... 
           BDest <= Instruction_value(9 downto 0);
           Opcode <= Instruction_value (31 downto 27);
           R1 <= Instruction_value (22 downto 19);
           R2 <= Instruction_value (18 downto 15);
           Rd <= Instruction_value (26 downto 23);
           Immidiate_Out <= Immidiate_value;
           
           Instruction_value := Instruction;
           Immidiate_value := Immidiate_In; 
        end if;
end process;
  
end Behavioral;
