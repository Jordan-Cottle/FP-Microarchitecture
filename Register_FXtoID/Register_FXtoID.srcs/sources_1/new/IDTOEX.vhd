----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2019 11:12:21 AM
-- Design Name: 
-- Module Name: IDtoEX - Behavioral
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

entity IDtoEX is
    Port ( PC_In : in STD_LOGIC_VECTOR (9 downto 0);
           ReadData1_In : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData2_In : in STD_LOGIC_VECTOR (31 downto 0);
           Immidiate_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC_Out : out STD_LOGIC_VECTOR (9 downto 0);
           ReadData1_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ReadData2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Immidiate_Out : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC);
end IDtoEX;

architecture Behavioral of IDtoEX is

signal PC_Value : std_logic_vector(9 downto 0);
signal ReadData1_Value : std_logic_vector(31 downto 0);
signal ReadData2_Value : std_logic_vector(31 downto 0);
signal Immidiate_Value : std_logic_vector(31 downto 0);

begin

process(clk)
begin
        if rising_edge(clk) then
           PC_Value <= PC_In;
           ReadData1_Value <= ReadData1_In;
           ReadData2_Value <= ReadData2_In;
           Immidiate_Value <= Immidiate_In;
           
        elsif falling_edge(clk) then
           PC_Out <= PC_Value;
           ReadData1_Out <= ReadData1_Value;
           ReadData2_Out <= ReadData2_Value;
           Immidiate_Out <= Immidiate_Value;
        end if;
end process;


end Behavioral;
