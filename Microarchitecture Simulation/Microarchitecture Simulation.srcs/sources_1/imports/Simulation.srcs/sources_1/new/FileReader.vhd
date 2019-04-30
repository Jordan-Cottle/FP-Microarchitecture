----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 03/07/2019 05:59:48 PM
-- Design Name: File Reader
-- Module Name: FileReader - Behavioral
-- Project Name: FP-Microarchitecture Simulation
-- Description: Reads and parses a file containing instructions to drive the simulation
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library Sim;

use Sim.Constants.all;
use Sim.conversions.all;
use Sim.components;
use Sim.components.all;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FileReader is
--  Port ( );
end FileReader;

architecture Behavioral of FileReader is

    file instructions: text;
    file output: text;
    
    -- simulation signals
    signal clk : STD_LOGIC := '0';
    signal start: std_logic := '0';
    
    -- instruction memory/PC signals
    signal ProgramCounter : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    signal Load_Address : STD_LOGIC_VECTOR (9 downto 0);
    signal InstructionIn : STD_LOGIC_VECTOR (31 downto 0);
    signal Instruction : STD_LOGIC_VECTOR (31 downto 0);
    signal ImmediateValue : STD_LOGIC_VECTOR (31 downto 0);
    
    signal opCode : std_logic_vector(4 downto 0);
    
    -- Register Signals
    signal R1: std_logic_vector(3 downto 0);
    signal RValueA: std_logic_vector(31 downto 0);
    signal R2: std_logic_vector(3 downto 0);
    signal RValueB: std_logic_vector(31 downto 0);
    signal Rd: std_logic_vector(3 downto 0);
    signal RegWriteData: std_logic_vector(31 downto 0);
    
    -- Data Memory signals
    signal MemAddress : STD_LOGIC_VECTOR (9 downto 0);
    signal MemDataIn : STD_LOGIC_VECTOR (31 downto 0);
    signal MemDataOut : STD_LOGIC_VECTOR (31 downto 0);
    
    --ALU signals
    signal AluInA : STD_LOGIC_VECTOR (31 downto 0);
    signal AluInB : STD_LOGIC_VECTOR (31 downto 0);
    signal AluResult : STD_LOGIC_VECTOR (31 downto 0);
    signal z : STD_LOGIC; -- zero
    signal n : STD_LOGIC; -- negative
    signal e : std_logic; -- error
    
    -- Control signals
    signal UB: STD_LOGIC;
    signal NB, ZB, RW, MW, MTR, RDS, IVA: std_logic;
    signal AluOpCode : STD_LOGIC_VECTOR (3 downto 0);
    signal BDEST : std_logic_vector(9 downto 0);
    
    signal DataToReg: std_logic_vector(31 downto 0);
    
begin
    I_MEM: Instruction_Mem Port Map (
        PC => ProgramCounter,
        Load_Address => Load_Address,
        Load_File => InstructionIn,
        Load_Enable => start,
        Output_Data => Instruction,
        Immidiate => ImmediateValue,
        clk => clk
    );
        
    REGISTERS: Registers_Fmain Port Map(
        Read_reg1 => R1,
        Read_reg2 => R2,
        Write_reg => Rd,
        Write_Data => RegWriteData,
        RegWrite => RW,
        ReadOut_Data1 => RValueA,
        ReadOut_Data2 => RValueB,
        clk => clk
    );
    D_MEM: Data_Memory Port Map (
        Address => MemAddress,
        Data_In => MemDataIn,
        Data_Out => MemDataOut,
        Mem_Write => MW,
        clk => clk
    );
    
    -- ALU wasn't being recognized without being explicit
    ALU: Components.ALU Port Map (
        opCode => AluOpCode,
        a => AluInA,
        b => AluInB,
        result => AluResult,
        z => z,
        n => n,
        e => e
    );
    
    PC : components.PC Port Map (
            PC => ProgramCounter,
            UB => UB,
            NB => NB,
            ZB => ZB,
            RDS => RDS,
            IVA => IVA,
            N => N,
            Z => Z,
            BDEST => BDEST,
            clk => clk,
            start => start
        );
    
    CONTROL: ISA_Controller Port Map(
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
    
    -- Muxes
    RdsMux: Mux2To1_32b Port Map ( 
            a => DataToReg,
            b => ImmediateValue,
            control => RDS,
            result => RegWriteData
    );
    
    MtrMux: Mux2To1_32b Port Map ( 
                a => AluResult,
                b => MemDataOut,
                control => MTR,
                result => DataToReg
    );
            
    IvaMux: Mux2To1_32b Port Map( 
            a => RValueB,
            b => ImmediateValue,
            control => IVA,
            result => AluInB
    );
    
    -- decode instruction
    process(Instruction)
    
    begin
        if start = '1' then
            -- assign constant, fixed locations
            opCode <= instruction(31 downto 27);
            Rd <= instruction(26 downto 23);
            R1 <= instruction(22 downto 19);
            R2 <= instruction(18 downto 15);
            BDEST <= instruction(9 downto 0);
        end if;
    end process;

    -- Main process, controls clock
    process
        variable lineIn: line;
        variable vectorString: string(32 downto 1);
        variable loadTo: unsigned(9 downto 0) := "0000000000";
    begin
        wait for 20 ns;
        file_open(instructions, inputFolderPath & "program1.txt", read_mode);
        while not endfile(instructions) loop
            -- load instructions onto signal
            readline(instructions, lineIn);
            read(lineIn, vectorString); -- get operation
            Load_Address <= std_logic_vector(loadTo);
            InstructionIn <= stringToVector(vectorString);
            clk <= not(clk);
            wait for 20 ns;
            loadTo := loadTo + "0000000001";
            clk <= not(clk);
            wait for 20 ns;
        end loop;
        
        file_close(instructions);
        
        start <= '1';
        clk <= not(clk);
        wait for 20ns;
        
        
        while start = '1' loop
            clk <= not(clk);
            wait for 20 ns;
        end loop;
        wait;
    end process;
end Behavioral;
