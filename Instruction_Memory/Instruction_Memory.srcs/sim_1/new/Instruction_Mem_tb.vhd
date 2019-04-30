----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2019 11:57:47 PM
-- Design Name: 
-- Module Name: Instruction_Mem_tb - Behavioral
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

entity Instruction_Mem_tb is
--  Port ( );
end Instruction_Mem_tb;

architecture Behavioral of Instruction_Mem_tb is
    signal PC, Load_Address : std_logic_vector(9 downto 0) := "0000000000";
    signal Load_File,Output_Data,Immidiate : std_logic_vector(31 downto 0) := x"00000000";
    signal Load_Enable,clk : std_logic := '0';
begin
  uut : entity work.instruction_Mem
  port map(PC,Load_Address,Load_File,Load_Enable,Output_Data,Immidiate,clk);
  process
  begin
         clk <= '1';
         wait for 1 ns;
         clk <= '0';
         wait for 1 ns;
  end process;
  process(clk)
       variable count: integer := 0;
       variable data: integer := 0;
  begin
     Load_Enable <= '1';
     if(clk = '1')then
            -- pass
     else  
       Load_Address <= std_logic_vector(to_unsigned(count, 10));
       Load_File <= std_logic_vector(to_unsigned(data, 32));
       PC <= std_logic_vector(to_unsigned((count) mod 1024, 10));
     
       count := count +1;
       data := data +1;
       if count = 1024 then
          count := 0;
       end if;
     end if;
    end process;    
end Behavioral;



