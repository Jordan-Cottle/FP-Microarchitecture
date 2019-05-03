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
use Sim.math.fpToDec;
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

entity SingleCycleDesign is
--  Port ( );
end SingleCycleDesign;

architecture Behavioral of SingleCycleDesign is

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
        variable programNum: string(1 to 1):= "2";
        variable lineIn: line;
        variable vectorString: string(32 downto 1);
        variable loadTo: unsigned(9 downto 0) := "0000000000";
    begin
        file_open(instructions, inputFolderPath & "program" & programNum & ".txt", read_mode);
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
        
        file_open(output, outputFolderPath & "SimTest" & programNum & ".txt", write_mode);
        while start = '1' and not(opCode = "10101") loop
            clk <= not(clk);
            wait for 20 ns;
        end loop;
        for i in 1 to 5 loop
            clk <= not(clk);
            wait for 20 ns;
        end loop;
        
        file_close(output);
        wait;
    end process;
    
    
    process(clock) -- write output values on falling edge of slow clock
        variable lineOut: line;
        variable registerIndex: integer;
    begin
        if falling_edge(clock) and start = '1' then
            write(lineOut, string'("PC: ") & integer'image(to_integer(unsigned(ProgramCounter))));
            write(lineOut, " (" & vectorToString(ProgramCounter) & ")");
            writeLine(output, lineOut);
            write(lineOut, string'("   OpCode: "));
            write(lineOut, opCodeToString(opCode));
            write(lineOut, string'(" ("));
            write(lineOut, vectorToString(opCode));
            write(lineOut, string'(")"));
            writeLine(output, lineOut);
            
            write(lineOut, "   R1 Address: " & vectorToString(R1));
            writeLine(output, lineOut);
            write(lineOut, "   R1 Value: " & vectorToString(RValueA));
            write(lineOut, " (" & real'image(fpToDec(RValueA)) & ")");
            writeLine(output, lineOut);
            
            write(lineOut, "   R2 Address: " & vectorToString(R2));
            writeLine(output, lineOut);
            write(lineOut, "   R2 Value: " & vectorToString(RValueB));
            write(lineOut, " (" & real'image(fpToDec(RValueB)) & ")");
            writeLine(output, lineOut);
            
            write(lineOut, "   Rd Address: " & vectorToString(Rd));
            writeLine(output, lineOut);
            write(lineOut, "   Rd Write Value: " & vectorToString(RegWriteData));
            write(lineOut, " (" & real'image(fpToDec(RegWriteData)) & ")");
            writeLine(output, lineOut);
            
            
            if (MW or MTR) = '1' then -- write info for memory access operation
                write(lineOut, "   MemIn: " & vectorToString(RValueB));
                writeLine(output, lineOut);
                write(lineOut, "   MemOut: " & vectorToString(MemDataOut));
                writeLine(output, lineOut);
            elsif (NB or ZB) = '1' then -- write info for branching
                write(lineOut, "   N: " & std_logic'image(N));
                writeLine(output, lineOut);
                write(lineOut, "   Z: " & std_logic'image(Z));
                writeLine(output, lineOut);
                write(lineOut, "   BDEST: " & integer'image(to_integer(unsigned(BDEST))) & " (" &vectorToString(BDEST) & ")");
                writeLine(output, lineOut);
            elsif UB = '1' then
                write(lineOut, "   BDEST: " & integer'image(to_integer(unsigned(BDEST))) & " (" &vectorToString(BDEST) & ")");
                writeLine(output, lineOut);
            end if;
            
            -- control signals
            write(lineOut, string'("  Control Signals:"));
            writeLine(output, lineOut);
            write(lineOut, "   ALU Control: " & vectorToString(AluOpCode));
            writeLine(output, lineOut);
            write(lineOut, "   UB: " & std_logic'image(UB));
            writeLine(output, lineOut);            
            write(lineOut, "   ZB: " & std_logic'image(ZB));
            writeLine(output, lineOut);  
            write(lineOut, "   NB: " & std_logic'image(NB));
            writeLine(output, lineOut);  
            write(lineOut, "   RW: " & std_logic'image(RW));
            writeLine(output, lineOut);  
            write(lineOut, "   MW: " & std_logic'image(MW));
            writeLine(output, lineOut);  
            write(lineOut, "   MTR: " & std_logic'image(MTR));
            writeLine(output, lineOut);  
            write(lineOut, "   RDS: " & std_logic'image(RDS));
            writeLine(output, lineOut);
            write(lineOut, "   IVA: " & std_logic'image(IVA));
            writeLine(output, lineOut);  
        end if;
    end process;
end behavioral;
