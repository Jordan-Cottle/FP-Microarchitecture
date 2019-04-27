----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2019 07:49:31 PM
-- Design Name: 
-- Module Name: Data_Memory - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Memory is
    Port ( Address : in STD_LOGIC_VECTOR (9 downto 0);
           Data_In : in STD_LOGIC_VECTOR (31 downto 0);
           Data_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Mem_Write : in STD_LOGIC;
           clk: in STD_Logic
           );
end Data_Memory;

architecture Behavioral of Data_Memory is
    type Data_Memory is array( 0 to 1023) of std_logic_vector(31 downto 0);
    signal Mem_Data : Data_Memory;

begin
    Data_File : process (clk) is
   begin
      if rising_edge(clk) then
      
       Data_Out <= Mem_Data(to_integer(unsigned(Address)));
       
          if Mem_Write = '1' then
          Mem_Data(to_integer(unsigned(Address))) <= Data_In;
          end if;
      end if;
    end process;

end Behavioral;
