----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2019 12:19:49 PM
-- Design Name: 
-- Module Name: Register_File_tb - Behavioral
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

entity Register_File_tb is
--  Port ( );
end Register_File_tb;

architecture Behavioral of Register_File_tb is

   signal out1, out2, Write : std_logic_vector(31 downto 0) := x"00000000";
   signal Read_1, Read_2, Write_Val : std_logic_vector(4 downto 0) := "00000";
   signal Enable, clock : std_logic:= '0';
     
begin

   uut : entity work.Registers_Fmain 
   port map( Read_1,Read_2,Write,Write_Val,Enable,out1,out2,clock);
   process
   begin 
         clock <='1';
         wait for 1 ns;
         clock <='0';
         wait for 1 ns;
   end process;
   
   process(clock)
      variable count: integer := 0;
   begin
      enable <= '1';
      if(clock = '0') then
         -- pass
      elsif 
         write <= std_logic_vector(to_unsigned(count, 32));
         write_val <= std_logic_vector(to_unsigned(count, 32));
         read_1 <= std_logic_vector(to_unsigned(count, 32));
         read_2 <= std_logic_vector(to_unsigned(count, 32));
      end if;
   end process;
end Behavioral;
