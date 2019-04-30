----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2019 10:40:27 AM
-- Design Name: 
-- Module Name: MEMtoWB - Behavioral
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

entity MEMtoWB is
    Port ( MemDataOutput_IN : in STD_LOGIC_VECTOR (31 downto 0);
           ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
           MemDataOutput_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC
           );
end MEMtoWB;

architecture Behavioral of MEMtoWB is

signal MemDataOutput_Value : std_logic_vector(31 downto 0);
signal ALUResult_Value : std_logic_vector(31 downto 0);

begin
    
process(clk)
begin
        if rising_edge(clk) then
           MemDataOutput_Value <= MemDataOutput_In;
           ALUResult_Value <= ALUResult_In;
           
        elsif falling_edge(clk) then
           MemDataOutput_Out <= MemDataOutput_Value;
           AlUResult_Out <= ALUResult_Value;
        end if;
        
end process;

end Behavioral;
