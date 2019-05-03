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
           IV_in: in std_logic_vector(31 downto 0);
           RDS_in: in std_logic;
           
           --Output ports...
           ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           MemDataOutput_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_Out : out STD_LOGIC_VECTOR (3 downto 0);
           MTR_Out : out std_logic;
           RW_Out : out std_logic;
           IV_out: out std_logic_vector(31 downto 0);
           RDS_out : out std_logic;
           --clock...
           clk : in STD_LOGIC
           );
end MEM_WB;

architecture Behavioral of MEM_WB is

begin
    
process(clk)
--Declaring the Variable....
variable MemDataOutput_Value : std_logic_vector(31 downto 0);
variable ALUResult_Value : std_logic_vector(31 downto 0);
variable Write_Address_Value: std_logic_vector(3 downto 0);
variable MTR_Value : std_logic;
variable RW_Value : std_logic;
variable RDS_value: std_logic;
variable IV_value: std_logic_vector(31 downto 0);

begin
        if rising_edge(clk) then
           -- Loading the values...
           ALUResult_Value := ALUResult_In;
           MemDataOutput_Value := MemDataOutput_In;
           Write_Address_Value := Write_Address_In;
           MTR_Value := MTR_In;
           RW_Value := RW_In;
           RDS_value := RDS_in;
           IV_value:= IV_in;
           -- Omitting out the values...
        end if;
           AlUResult_Out <= ALUResult_Value;
           MemDataOutput_Out <= MemDataOutput_Value;
           Write_Address_Out <= Write_Address_Value;
           MTR_Out <= MTR_Value;
           RW_Out <= RW_Value;
           RDS_out <= RDS_value;
           IV_out <= IV_value;
end process;

end Behavioral;
