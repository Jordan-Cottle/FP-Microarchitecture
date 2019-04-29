----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2019 08:41:50 PM
-- Design Name: 
-- Module Name: ISA_Controller - Behavioral
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




entity ISA_Controller is
port (
  opcode: in std_logic_vector(4 downto 0);
  
  alu_op: out std_logic_vector (3 downto 0);
  u_branch, z_branch, n_branch, reg_write, mem_write, mem_to_reg, reg_dst, iva: out std_logic
 );

end ISA_Controller;


architecture Behavioral of ISA_Controller is

begin
    process(opcode)
    begin
        
       
            case opcode is
                when "00000" => -- add
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "0000";
                    
                when "00001" => --sub
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "0001";
                    
                when "00010" => --neg
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "0010";
                    
                when "00011" => --mul
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "0011";
                    
                when "00100" => --div
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "0100";
                    
                when "00101" => --floor
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "0101";
                    
                when "00110" => --ceil
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "0110";
                    
                when "00111" => --round
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "0111";
                    
                when "01000" => --abs
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "1000";
                    
                when "01001" => --min
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "1001";
                    
                when "01010" => --max
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "1010";
                    
                when "01011" => --pow
                    u_branch <= '1';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '1';
                    alu_op <= "1011";
                    
                when "01100" => --exp
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "1100";
                    
                when "01101" => --sqrt
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '0';
                    alu_op <= "1101";
                    
                when "10000" => --set
                    u_branch <= '1';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '1';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "10001" => --load
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '1';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "10010" => --store
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '0';
                    mem_write <= '1';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111"; 
                      
                when "10011" => --move
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '0';
                    reg_dst <= '0';
                    iva <= '-';
                    alu_op <= "1111";  
                           
                when "11010" => --u_branch
                    u_branch <= '1';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '0';
                    mem_write <= '0';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "11000" => --z_branch
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '1';
                    reg_write <= '0';
                    mem_write <= '0';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "11001" => --n_branch
                    u_branch <= '0';
                    z_branch <= '1';
                    n_branch <= '0';
                    reg_write <= '0';
                    mem_write <= '0';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "11111" => --nop
                    u_branch <= '0';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '0';
                    mem_write <= '0';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111";
                    
                when "10101" => --halt
                    u_branch <= '1';
                    z_branch <= '0';
                    n_branch <= '0';
                    reg_write <= '1';
                    mem_write <= '0';
                    mem_to_reg <= '-';
                    reg_dst <= '-';
                    iva <= '-';
                    alu_op <= "1111";
                                                            
            end case;
        
    end process;
          
        
end Behavioral;
