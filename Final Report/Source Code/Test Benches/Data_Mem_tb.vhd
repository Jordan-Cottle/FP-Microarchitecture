----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2019 08:18:09 PM
-- Design Name: 
-- Module Name: Data_Mem_tb - Behavioral
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

library Sim;
use Sim.components;
use Sim.math.decToFp;
use Sim.constants.zero;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Mem_tb is
--  Port ( );
end Data_Mem_tb;

architecture Behavioral of Data_Mem_tb is

   signal Address: std_logic_vector(31 downto 0) := zero(32);
   signal Data_In,Data_Out: std_logic_vector(31 downto 0) := zero(32);
   signal Mem_Write, clk : std_logic:= '0';

begin



        uut : components.Data_Memory 
        port map(
         Address,
         Data_In,
         Data_Out,
         Mem_Write,
         clk);
        process
          begin 
             clk <='1';
             wait for 1 ns;
             clk <='0';
             wait for 1 ns;
          end process;
        
          process(clk)
              variable count: real := 0.0;
              variable data: integer:= 0;
              variable writeCount: integer:= 0;
           begin
              if(clk = '1') then
                 mem_write <= '0';
              else
                 Mem_Write <= '1';
                 Address <= std_logic_vector(decToFp(count));
                 Data_In <= std_logic_vector(to_unsigned(data, 32));
                 
                 if writeCount = 1 then
                     count := count+1.0;
                     data := data + 1;
                     writeCount := 0;
                 else
                     writeCount := 1;
                 end if;
                 if count = 16.0 then
                    count := 0.0;
                 end if;
              end if;
           end process;
end Behavioral;
