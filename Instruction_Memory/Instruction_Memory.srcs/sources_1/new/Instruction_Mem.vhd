----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2019 10:31:03 PM
-- Design Name: 
-- Module Name: Instruction_Mem - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Mem is
    Port ( PC : in STD_LOGIC_VECTOR (9 downto 0);
           Load_Address : in STD_LOGIC_VECTOR (9 downto 0);
           Load_File : in STD_LOGIC_VECTOR (31 downto 0);
           Load_Enable : in STD_LOGIC;
           Output_Data : out STD_LOGIC_VECTOR (31 downto 0);
           Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC
           );
end Instruction_Mem;

architecture Behavioral of Instruction_Mem is
  type instruction_Array is array(0 to 1023) of std_logic_vector(31 downto 0);
  signal instruction_Data : instruction_Array;

begin
   Instruction : process(clk) is
     begin
         if rising_edge(clk) then
         
         Output_Data <= instruction_Data(to_integer(unsigned(PC)));          -- Regular Output Data...
         Immidiate   <= instruction_Data(to_integer(unsigned(PC + 1)));      -- Immidiate value Output...
         
         
             if Load_Enable = '1' then             -- laoding the instruction file...
             
             instruction_Data(to_integer(unsigned(Load_Address))) <= Load_File;
             
             end if;
         end if;
     end process;
end Behavioral;
