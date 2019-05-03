----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/03/2019 09:11:09 AM
-- Module Name: Constants
-- Description: Package to contain constant values for simulation
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package Constants is
    constant configurationPath: string := "C:\Users\Jordan\Documents\Projects\FP-Microarchitecture\OldSim\Simulation.configuration\";
    constant inputFolderPath: string := configurationPath & "InputFiles\";
    constant outputFolderPath: string := configurationPath & "OutputFiles\";
    constant maxValue: real := 3.4028235 * (10.0**38);
    constant minValue: real := maxValue * (-1.0);
    
    function one(length: integer) return std_logic_vector;
    function zero(length: integer) return std_logic_vector;
end Constants;

package body Constants is

function one(length: integer) return std_logic_vector is
    variable oneVector : std_logic_vector(length-1 downto 0) := (others => '0');
begin
    oneVector(oneVector'right) := '1';
    return oneVector;
end one;

function zero(length: integer) return std_logic_vector is
    variable zeroVector : std_logic_vector(length-1 downto 0) := (others => '0');
begin
    return zeroVector;
end zero;
    
end Constants;
