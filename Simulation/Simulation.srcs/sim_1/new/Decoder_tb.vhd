----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 03/07/2019 06:57:19 PM
-- Design Name: 
-- Module Name: Decoder_tb - Test
-- Project Name: FP-Microarchitecture Simulation
-- Description: TestBench for 10-1024 Decoder
-- Dependencies: Decoder10to1024.vhd
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

entity Decoder_tb is
--  Port ( );
end Decoder_tb;

architecture Test of Decoder_tb is

    component Decoder10to1024 is
        Port ( Input : in STD_LOGIC_VECTOR (9 downto 0);
               Control : in STD_LOGIC;
               Output : out STD_LOGIC_VECTOR (1023 downto 0));
    end component;

    signal input: STD_LOGIC_VECTOR (9 downto 0);
    signal control: STD_LOGIC;
    signal output: STD_LOGIC_VECTOR (1023 downto 0);
begin
UUT : Decoder10to1024 PORT MAP (Input => input, Control => control, Output => output);
process
    variable count: integer := 0;
    variable cont: STD_LOGIC := '0';
begin
    control <= cont;
    cont := cont xor '1';

    input <= std_logic_vector(to_unsigned(count, 10));

    if cont = '0' then
        count := count + 1;
    end if;

    wait for 20ns;

    if count = 1024 then
        wait;
    end if;
end process;


end Test;
