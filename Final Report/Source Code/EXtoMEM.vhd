----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2019 10:12:16 AM
-- Design Name: 
-- Module Name: EXtoMEM - Behavioral
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

entity EX_MEM is
    Port ( -- Input ports....
           ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
           ReadOut2_In : in STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_In : in std_logic_vector ( 3 downto 0);
           MW_In : in STD_LOGIC;
           MTR_In : in STD_LOGIC;
           RW_In : in STD_LOGIC;
           RDS_in: in std_logic;
           IV_in: in std_logic_vector(31 downto 0);
           -- Output ports....
           ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ReadOut2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_Out : out std_logic_vector (3 downto 0);
           MW_Out : out STD_LOGIC;
           MTR_Out : out STD_LOGIC;
           RW_Out : out STD_LOGIC;
           RDS_out : out std_logic;
           IV_out: out std_logic_vector(31 downto 0);
           -- clock....
           clk : in STD_LOGIC
           );
end EX_MEM;

architecture Behavioral of EX_MEM is



begin

process(clk)
--Declaring the variables....
variable ALUResult_Value : std_logic_vector(31 downto 0);
variable ReadOut2_Value : std_logic_vector(31 downto 0);
variable Write_Address_Value : std_logic_vector(3 downto 0);
variable MW_Value : std_logic;
variable MTR_Value : std_logic;
variable RW_Value : std_logic;
variable RDS_value: std_logic;
variable IV_value: std_logic_vector(31 downto 0);

begin
        if rising_edge(clk) then
           -- Loading the values...
           ALUResult_Value := ALUResult_In;
           ReadOut2_Value := ReadOut2_In;
           Write_Address_Value := Write_Address_In;
           MW_Value := MW_In;
           MTR_Value := MTR_In;
           RW_Value := RW_In;
           RdS_value := RDs_in;
           IV_value := IV_in;
        end if;
        -- Omitting the Value out...
           Write_address_out <= Write_Address_Value;
           ALUResult_Out <= ALUResult_Value;
           ReadOut2_Out <= ReadOut2_Value;
           MW_Out <= MW_Value;
           MTR_Out <= MTR_Value;
           RW_Out <= RW_Value;
           RDS_out <= RDS_value;
           IV_out <= IV_value;
end process;

end Behavioral;
