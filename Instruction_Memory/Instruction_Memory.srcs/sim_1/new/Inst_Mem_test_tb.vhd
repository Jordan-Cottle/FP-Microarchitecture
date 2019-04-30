----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2019 10:51:51 PM
-- Design Name: 
-- Module Name: Inst_Mem_test_tb - Behavioral
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

--entity Inst_Mem_test_tb is
--  Port ( );
--end Inst_Mem_test_tb;

--architecture Behavioral of Inst_Mem_test_tb is

--begin


--end Behavioral;

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Instruction_Mem_tb is
end;

architecture bench of Instruction_Mem_tb is

  component Instruction_Mem
      Port ( PC : in STD_LOGIC_VECTOR (9 downto 0);
             Load_Address : in STD_LOGIC_VECTOR (9 downto 0);
             Load_File : in STD_LOGIC_VECTOR (31 downto 0);
             Load_Enable : in STD_LOGIC;
             Output_Data : out STD_LOGIC_VECTOR (31 downto 0);
             Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
             clk : in STD_LOGIC
             );
  end component;

  signal PC: STD_LOGIC_VECTOR (9 downto 0);
  signal Load_Address: STD_LOGIC_VECTOR (9 downto 0);
  signal Load_File: STD_LOGIC_VECTOR (31 downto 0);
  signal Load_Enable: STD_LOGIC;
  signal Output_Data: STD_LOGIC_VECTOR (31 downto 0);
  signal Immidiate: STD_LOGIC_VECTOR (31 downto 0);
  signal clk: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Instruction_Mem port map ( PC           => PC,
                                  Load_Address => Load_Address,
                                  Load_File    => Load_File,
                                  Load_Enable  => Load_Enable,
                                  Output_Data  => Output_Data,
                                  Immidiate    => Immidiate,
                                  clk          => clk );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
