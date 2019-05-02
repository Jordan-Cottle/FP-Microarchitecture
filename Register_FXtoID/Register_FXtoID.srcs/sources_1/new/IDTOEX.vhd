----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2019 11:12:21 AM
-- Design Name: 
-- Module Name: IDtoEX - Behavioral
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

entity ID_EX is
    Port ( -- Input ports....
           BDest_In : in STD_LOGIC_VECTOR (9 downto 0);
           ReadData1_In : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData2_In : in STD_LOGIC_VECTOR (31 downto 0);
           MuxOut_In : in std_logic_vector (31 downto 0);
           Write_Address_In : in STD_LOGIC_VECTOR (3 downto 0);
           MTR_In : in STD_LOGIC;
           UB_In : in STD_LOGIC;
           ZB_In : in STD_LOGIC;
           NB_In : in STD_LOGIC;
           ALUC_In : in STD_LOGIC_vector(3 downto 0);
           RW_In : in STD_LOGIC;
           MW_In : in STD_LOGIC;
           IVA_in: in std_logic;
           RDS_in: in std_logic;
           IV_in: in std_logic_vector(31 downto 0);
           -- Output ports...
           BDest_Out : out STD_Logic_vector(9 downto 0);
           ReadData1_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ReadData2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           MuxOut_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Write_Address_Out : out STD_LOGIC_VECTOR (3 downto 0);
           MTR_Out : out STD_LOGIC;
           UB_Out : out STD_LOGIC;
           ZB_Out : out STD_LOGIC;
           NB_Out : out STD_LOGIC;
           ALUC_Out : out STD_LOGIC_vector(3 downto 0);
           RW_Out : out STD_LOGIC;
           MW_Out : out STD_LOGIC;
           IVA_out: out std_logic;
           RDS_out: out std_logic;
           IV_out: out std_logic_vector(31 downto 0);
           -- clock...
           clk : in STD_LOGIC);
end ID_EX;

architecture Behavioral of ID_EX is

--Declaring the signals....

signal BDest_Value : std_logic_vector(9 downto 0);
signal ReadData1_Value : std_logic_vector(31 downto 0);
signal ReadData2_Value : std_logic_vector(31 downto 0);
signal MuxOut_Value : std_logic_vector(31 downto 0);
signal Write_Address_Value : std_logic_vector(3 downto 0);
signal MTR_Value : STD_LOGIC;
signal UB_Value : STD_LOGIC;
signal ZB_Value : STD_LOGIC;
signal NB_Value : STD_LOGIC;
signal ALUC_Value : STD_LOGIC_vector(3 downto 0);
signal RW_Value :  STD_LOGIC;
signal MW_Value :  STD_LOGIC;
signal IVA_Value: std_logic;
signal RDS_Value: std_logic;

begin

process(clk)
begin
        if rising_edge(clk) then             --- Loading the values...
           BDest_Value <= BDest_In;
           ReadData1_Value <= ReadData1_In;
           ReadData2_Value <= ReadData2_In;
           MuxOut_Value <= MuxOut_In;
           Write_Address_Value <= Write_Address_In;
           MTR_Value <= MTR_In;
           UB_Value <= UB_In;
           ZB_Value <= ZB_In;
           NB_Value <= NB_In;
           ALUC_Value <= ALUC_In;
           RW_Value   <= RW_In;
           MW_Value <= MW_In;
           IVA_value <= IVA_in;
           RDS_value <= RDS_in;

        else                               -- Omitting the values out...
           BDest_Out <= BDest_Value;
           ReadData1_Out <= ReadData1_Value;
           ReadData2_Out <= ReadData2_Value;
           MuxOut_Out <= MuxOut_Value;
           Write_Address_Out <= Write_Address_Value;
           MTR_Out <= MTR_Value;
           UB_Out <= UB_Value;
           ZB_Out <= ZB_Value;
           NB_Out <= NB_Value;
           ALUC_Out <= ALUC_Value;
           RW_Out   <= RW_Value;
           MW_Out <= MW_Value;
           IVA_out <= IVA_value;
           RDS_out <= RDS_value;
           
        end if;
end process;


end Behavioral;
