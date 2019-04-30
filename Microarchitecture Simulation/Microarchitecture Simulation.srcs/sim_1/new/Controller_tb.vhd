----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/29/2019 10:13:52 PM
-- Module Name: Controller_tb - Behavioral
-- Description: tests controller output signals
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library Sim;
use Sim.components.ISA_Controller;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller_tb is
--  Port ( );
end Controller_tb;

architecture Behavioral of Controller_tb is
signal UB, NB, ZB, RW, MW, MTR, RDS, IVA: std_logic;
signal AluOpCode : STD_LOGIC_VECTOR (3 downto 0);
signal opCode: std_logic_vector(4 downto 0);

begin

UUT: ISA_Controller Port Map(
            opcode => opCode,
            alu_op => AluOpCode,
            u_branch => UB,
            z_branch => ZB,
            n_branch => NB,
            reg_write => RW,
            mem_write => MW,
            mem_to_reg => MTR,
            reg_dst => RDS,
            iva => IVA                
);

process
    variable counter: integer := 0;
begin

    while counter < 2**5 loop
        opCode <= std_logic_vector(to_unsigned(counter,5));
        counter := counter + 1;
        wait for 20ns;
    end loop;
    
    wait;

end process;



end Behavioral;
