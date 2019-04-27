----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2019 08:51:39 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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
use Sim.components.ALU;
use Sim.math.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is
    signal a,b, result: std_logic_vector(31 downto 0);
    signal op: std_logic_vector(3 downto 0);
    signal clk, z, n, e: std_logic;

begin
    UUT: ALU Port Map (opcode => op, 
        a => a, 
        b => b,
        clock => clk,
        result => result,
        z => z,
        n => n,
        e => e);

    process
        variable opCount: integer:= 0;
        variable i: integer:= 0;
    begin
        for 

    end process;
        
         

end Behavioral;
