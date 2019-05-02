----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2019 01:10:54 PM
-- Design Name: 
-- Module Name: ISA_Controller_tb - Behavioral
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

entity ISA_Controller_tb is
    
end ISA_Controller_tb;

architecture Behavioral of ISA_Controller_tb is
    component ISA_Controller
    Port (
          opcode: in std_logic_vector (4 downto 0);
          count: out std_logic_vector (4 downto 0)
          );
    end component;
    signal opcode: std_logic_vector (4 downto 0)
begin


end Behavioral;
