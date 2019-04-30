----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2019 05:22:17 AM
-- Design Name: 
-- Module Name: FXTOID_tb - Behavioral
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
---------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FX_ID_tb is
end;

architecture bench of FX_ID_tb is

  component FX_ID
      Port ( PC_In : in STD_LOGIC_VECTOR (9 downto 0);
             Instruction_In : in STD_LOGIC_VECTOR (31 downto 0);
             Immidiate_In : in STD_LOGIC_VECTOR (31 downto 0);
             PC_Out : out STD_LOGIC_VECTOR (9 downto 0);
             Instruction_Out : out STD_LOGIC_VECTOR (31 downto 0);
             Immidiate_Out : out STD_LOGIC_VECTOR (31 downto 0);
             clk : in STD_LOGIC
             );
  end component;

  signal PC_In: STD_LOGIC_VECTOR (9 downto 0);
  signal Instruction_In: STD_LOGIC_VECTOR (31 downto 0);
  signal Immidiate_In: STD_LOGIC_VECTOR (31 downto 0);
  signal PC_Out: STD_LOGIC_VECTOR (9 downto 0);
  signal Instruction_Out: STD_LOGIC_VECTOR (31 downto 0);
  signal Immidiate_Out: STD_LOGIC_VECTOR (31 downto 0);
  signal clk: STD_LOGIC ;

begin

  uut: FX_ID port map ( PC_In           => PC_In,
                        Instruction_In  => Instruction_In,
                        Immidiate_In    => Immidiate_In,
                        PC_Out          => PC_Out,
                        Instruction_Out => Instruction_Out,
                        Immidiate_Out   => Immidiate_Out,
                        clk             => clk );

process
begin
   clk <='1';
   wait for 1 ns;
   clk <='0';
   wait for 1 ns;
end process;

process(clk)
begin
  if (clk = '1') then
    PC_In <= "1111100000";
    Instruction_In <= x"10AFFA00";
    Immidiate_In <= x"FCBACBEF";
  
  end if;
end process;

end; 