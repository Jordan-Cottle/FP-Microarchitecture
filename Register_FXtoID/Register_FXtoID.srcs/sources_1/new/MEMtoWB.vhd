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

entity MEM_WB is
    Port ( -- Input ports...
           MemDataOutput_IN : in STD_LOGIC_VECTOR (31 downto 0);
           ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_In: in STD_LOGIC_VECTOR (3 downto 0);
           MTR_In : in std_logic;
           RW_In : in std_logic;
           
           --Output ports...
           ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           MemDataOutput_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_Out : out STD_LOGIC_VECTOR (3 downto 0);
           MTR_Out : out std_logic;
           RW_Out : out std_logic;
           --clock...
           clk : in STD_LOGIC
           );
end MEM_WB;

architecture Behavioral of MEM_WB is

signal MemDataOutput_Value : std_logic_vector(31 downto 0);
signal ALUResult_Value : std_logic_vector(31 downto 0);
signal Write_Address_Value: std_logic_vector(3 downto 0);
signal MTR_Value : std_logic;
signal RW_Value : std_logic;

begin
    
process(clk)
begin
        if rising_edge(clk) then
           -- Loading the values...
           ALUResult_Value <= ALUResult_In;
           MemDataOutput_Value <= MemDataOutput_In;
           Write_Address_Value <= Write_Address_In;
           MTR_Value <= MTR_In;
           RW_Value <= RW_In;
           
        else
           -- Omitting out the values...
           AlUResult_Out <= ALUResult_Value;
           MemDataOutput_Out <= MemDataOutput_Value;
           Write_Address_Out <= Write_Address_Value;
           MTR_Out <= MTR_Value;
           RW_Out <= RW_Value;
           
        end if;
        
end process;

end Behavioral;
