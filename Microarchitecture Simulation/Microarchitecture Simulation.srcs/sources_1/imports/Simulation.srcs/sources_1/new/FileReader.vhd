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
    signal clock: std_logic := '0'; -- main clock
    signal clk : STD_LOGIC := '0'; -- inner clock
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
    signal MemDataOut : STD_LOGIC_VECTOR (31 downto 0);
    
    --ALU signals
    signal AluInB: std_logic_vector(31 downto 0);
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
        Address => AluResult,
        Data_In => RValueB,
        Data_Out => MemDataOut,
        Mem_Write => MW,
        clk => clk
    );
    
    -- ALU wasn't being recognized without being explicit
    ALU: Components.ALU Port Map (
        opCode => AluOpCode,
        a => RValueA,
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
            clk => clock,
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
        -- assign constant, fixed locations
        opCode <= instruction(31 downto 27);
        Rd <= instruction(26 downto 23);
        R1 <= instruction(22 downto 19);
        R2 <= instruction(18 downto 15);
        BDEST <= instruction(9 downto 0);
    end process;
    
    -- count up big clock only once every 5 mini clock cycles
    process(clk)
        variable count: integer:= 0;
    begin
        if count = 5 then
            clock <= not clock;
            count := 0;
        end if;
        
        count := count + 1;
    end process;

    -- Main process, controls clock
    process
        variable lineIn: line;
        variable vectorString: string(32 downto 1);
        variable loadTo: unsigned(9 downto 0) := "0000000000";
    begin
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
        
        file_open(output, outputFolderPath & "SimTest1.txt", write_mode);
        while start = '1' and not(opCode = "10101") loop
            clk <= not(clk);
            wait for 20 ns;
        end loop;
        
        file_close(output);
        wait;
    end process;
    
    
    process(clock) -- write output values on falling edge of slow clock
        variable lineOut: line;
        variable registerIndex: integer;
        variable str: string;
        variable instruction: string;
    begin
        if falling_edge(clock) and start = '1' then
            instruction := opCodeToString(opCode);
            str := "OpCode: " & instruction;
            write(lineOut, str);
            
            if (MW or MTR) = '1' then -- write info for memory access operation
                if instruction = "STORE" then
                    str:= "  " & registerIndexToString(R1) & ": " & vectorToString(RValueA);
                    str:= "  " & registerIndexToString(R2) & ": " & vectorToString(RValueB);
                    
                end if;
            elsif (UB or NB or ZB) = '1' then -- write info for branching
            
            else -- write info for R type instructions
            
            end if;
        end if;
    end process;
end Behavioral;
