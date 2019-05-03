----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2019 02:56:29 PM
-- Design Name: 
-- Module Name: PC_tb - Behavioral
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
use Sim.components.PC;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_tb is
--  Port ( );
end PC_tb;

architecture Behavioral of PC_tb is

    signal counter : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    signal UB : STD_LOGIC := '0';
    signal NB : STD_LOGIC := '0';
    signal ZB : STD_LOGIC := '0';
    signal RDS : STD_LOGIC := '0';
    signal IVA : STD_LOGIC := '0';
    signal N : STD_LOGIC := '0';
    signal Z : STD_LOGIC := '0';
    signal BDEST : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    signal clk : STD_LOGIC := '0';

begin
    UUT: PC Port Map ( 
        PC => counter,
        UB => UB,
        NB => NB,
        ZB => ZB,
        RDS => RDS,
        IVA => IVA,
        N => N,
        Z => Z,
        BDEST => BDEST,
        clk => clk
    );
    
    process
        variable branchTo : integer := 0;
    begin
        for i in 1 to 10 loop
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
        end loop;
        
        for i in 1 to 10 loop
            BDEST <= std_logic_vector(to_unsigned(branchTo, 10));
            UB <= not UB;
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
            branchTo := branchTo + 2;
        end loop;
        
        for i in 1 to 10 loop
            BDEST <= std_logic_vector(to_unsigned(branchTo, 10));
            NB <= not NB;
            if NB = '0' then
                N <= not N;
            end if;
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
            branchTo := branchTo - 1;
        end loop;
        N <= '0';
        
        for i in 1 to 10 loop
            BDEST <= std_logic_vector(to_unsigned(branchTo, 10));
            ZB <= not ZB;
            if ZB = '0' then
                Z <= not Z;
            end if;
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
            branchTo := branchTo + 6;
        end loop;
        z <= '0';
        
        for i in 1 to 10 loop
            BDEST <= std_logic_vector(to_unsigned(branchTo, 10));
            RDS <= not RDS;
            if RDS = '0' then
                IVA <= not IVA;
            end if;
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
            branchTo := branchTo - 1;
        end loop;
        IVA <= '0';
        
        for i in 1 to 10 loop
            clk <= not clk;
            wait for 20ns;
            clk <= not clk;
            wait for 20ns;
        end loop;
        
             
        wait;
    end process;
end Behavioral;
