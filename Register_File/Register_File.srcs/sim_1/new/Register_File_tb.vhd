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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_File_tb is
--  Port ( );
end Register_File_tb;

architecture Behavioral of Register_File_tb is

   signal out1, out2, Write : std_logic_vector(31 downto 0) := x"0000";
   signal Read_1, Read_2, Write_Val : std_logic_vector(4 downto 0) := "00000";
   signal Enable, clock : std_logic:= '0';
     
begin

   uut : entity work.Registers_Fmain 
   port map( Read_1,Read_2,Write,Write_Val,Enable,out1,out2,clock);
   clkgen: process
   begin 
         clock <='1';
         wait for 1 ns;
         clock <='0';
         wait for 1 ns;
   end process;
   
   insig: process
   begin
        Write_Val <= x"AAAA";
        Write <= "00001";
        Enable <= '1';
        wait for 2 ns;
        Enable <= '0';
        wait for 1 ns;
        Write_Val <= x"EEEE";
        Write <= "00011";
        Enable <= '1';
        wait for 2 ns;
        Enable <= '0'; 
        Write_Val <= x"0000";
        Write <= "00000";
        wait for 2 ns;
        Read_1 <= "00001";
        Read_2 <= "00011";
        wait for 10 ns;
        Write_Val <= x"BBBB";
        Write <= "00011";
        Enable <= '1';
        wait for 2 ns;
        Enable <= '0';
        wait for 10 ns;
             
end process; 
end Behavioral;
