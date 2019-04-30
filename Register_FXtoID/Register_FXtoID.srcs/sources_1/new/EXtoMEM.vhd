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

entity EXtoMEM is
    Port ( AdderResult_In : in STD_LOGIC_VECTOR (31 downto 0);
           ZeroFlag_In : in STD_LOGIC;
           ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
           ReadOut2_In : in STD_LOGIC_VECTOR (31 downto 0);
           AdderResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ZeroFlag_Out : out STD_LOGIC;
           ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ReadOut2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC
           );
end EXtoMEM;

architecture Behavioral of EXtoMEM is

signal AdderResult_Value : std_logic_vector(31 downto 0);
signal ZeroFlag_Value : std_logic;
signal ALUResult_Value : std_logic_vector(31 downto 0);
signal ReadOut2_Value : std_logic_vector(31 downto 0);

begin

process(clk)
begin
        if rising_edge(clk) then
           AdderResult_Value <= AdderResult_In;
           ZeroFlag_Value <= ZeroFlag_In;
           ALUResult_Value <= ALUResult_In;
           ReadOut2_Value <= ReadOut2_In;
           
        elsif falling_edge(clk) then
           AdderResult_Out <= AdderResult_Value;
           ZeroFlag_Out <= ZeroFlag_Value;
           ALUResult_Out <= ALUResult_Value;
           ReadOut2_Out <= ReadOut2_Value;
        end if;
end process;


end Behavioral;
