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

entity FX_ID is
    Port ( PC_In : in STD_LOGIC_VECTOR (9 downto 0);
           Instruction_In : in STD_LOGIC_VECTOR (31 downto 0);
           Immidiate_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC_Out : out STD_LOGIC_VECTOR (9 downto 0);
           Instruction_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Immidiate_Out : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC
           );
end FX_ID;

architecture Behavioral of FX_ID is

signal PC_value : std_logic_vector(9 downto 0);
signal Instruction_value : std_logic_vector(31 downto 0);
signal Immidiate_value : std_logic_vector(31 downto 0);

begin

process(clk)
begin
        if rising_edge(clk) then
           PC_value <= PC_In;
           Instruction_value <= Instruction_In;
           Immidiate_value <= Immidiate_In;
           
        elsif falling_edge(clk) then
           PC_Out <= PC_value;
           Instruction_Out <= Instruction_value;
           Immidiate_Out <= Immidiate_value;
        end if;
end process;
  
end Behavioral;
