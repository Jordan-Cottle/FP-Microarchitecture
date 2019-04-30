----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2019 10:47:25 AM
-- Design Name: 
-- Module Name: Registers_Fmain - Behavioral
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

entity Registers_Fmain is
    Port ( Read_reg1 : in STD_LOGIC_VECTOR (3 downto 0);
           Read_reg2 : in STD_LOGIC_VECTOR (3 downto 0);
           Write_reg : in STD_LOGIC_VECTOR (3 downto 0);
           Write_Data : in STD_LOGIC_VECTOR (31 downto 0);
           RegWrite : in STD_LOGIC;
           ReadOut_Data1 : out STD_LOGIC_VECTOR (31 downto 0);
           ReadOut_Data2 : out STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_Logic
           );
end Registers_Fmain;

architecture Behavioral of Registers_Fmain is
    type Registers_Fmain is array( 0 to 15) of std_logic_vector(31 downto 0);
    signal reg_Data : Registers_Fmain;
    
begin
   Register_File : process (clk) is
   begin
      if rising_edge(clk) then
      
       ReadOut_Data1 <= reg_Data(to_integer(unsigned(Read_reg1)));
       ReadOut_Data2 <= reg_Data(to_integer(unsigned(Read_reg2)));
       
          if RegWrite = '1' then
          reg_Data(to_integer(unsigned(Write_reg))) <= Write_Data;
          end if;
      end if;
    end process;

end Behavioral;
