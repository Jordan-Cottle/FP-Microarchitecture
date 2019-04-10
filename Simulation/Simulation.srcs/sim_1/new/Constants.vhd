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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package Constants is
    constant configurationPath: string := "C:\Users\jorda\Documents\Projects\FP-Microarchitecture\Simulation\Simulation.configuration\";
    constant inputFolderPath: string := configurationPath & "InputFiles\";
    constant outputFolderPath: string := configurationPath & "OutputFiles\";
end Constants;

package body Constants is
    
end Constants;
