----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 05/02/2019 09:30:48 PM
-- Design Name: PipelinedDesign
-- Module Name: PipelinedDesign - Behavioral
-- Project Name: FP-Microarchitecture Simulation
-- Description: Fp coprocessor with piepelined execution
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

entity PipelinedDesign is
--  Port ( );
end PipelinedDesign;

architecture Behavioral of PipelinedDesign is

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
    signal UB, NB, ZB, RW, MW, MTR, RDS, IVA: std_logic;
    signal AluOpCode : STD_LOGIC_VECTOR (3 downto 0);
    signal BDEST : std_logic_vector(9 downto 0);
    
    signal DataToReg: std_logic_vector(31 downto 0);
    
    -- pipeline signals
    signal IVDecode: std_logic_vector(31 downto 0);
    signal UBX, NBX, ZBX, RWX, MWX, MTRX, RDSX, IVAX, MWM, RWM, MTRM, RDSM, RWW, RDSW, MTRW: std_logic;
    signal BDESTX: std_logic_vector(9 downto 0);
    signal AluOpX: std_logic_vector(3 downto 0);
    signal AluInBX: std_logic_vector(31 downto 0);
    signal RVAX, RVBX, RVBM: std_logic_vector(31 downto 0);
    signal RDX, RDM, RDW: std_logic_vector(3 downto 0);
    signal ALURM, ALURW, MEMDW, IVX, IVM, IVW: std_logic_vector(31 downto 0);
    
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
        RegWrite => RWW,
        ReadOut_Data1 => RValueA,
        ReadOut_Data2 => RValueB,
        clk => clk
    );
    D_MEM: Data_Memory Port Map (
        Address => ALURM,
        Data_In => RVBM,
        Data_Out => MemDataOut,
        Mem_Write => MWM,
        clk => clk
    );
    
    -- ALU wasn't being recognized without being explicit
    ALU: Components.ALU Port Map (
        opCode => AluOpX,
        a => RVAX,
        b => ALuInBx,
        result => AluResult,
        z => z,
        n => n,
        e => e
    );
    
    PC : components.PC Port Map (
            PC => ProgramCounter,
            UB => UBX,
            NB => NBX,
            ZB => ZBX,
            RDS => RDSX,
            IVA => IVAX,
            N => N,
            Z => Z,
            BDEST => BDESTX,
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
            b => IVW,
            control => RDSW,
            result => RegWriteData
    );
    
    MtrMux: Mux2To1_32b Port Map ( 
                a => ALURW,
                b => MEMDW,
                control => MTRW,
                result => DataToReg
    );
            
    IvaMux: Mux2To1_32b Port Map( 
            a => RValueB,
            b => ImmediateValue,
            control => IVA,
            result => AluInB
    );
    
    -- F/D Register
    FD: IF_ID Port Map (
        Instruction => Instruction,
        Immidiate_In => ImmediateValue,
        BDest => BDEST,
        Opcode => opCode,
        R1 => R1,
        R2 => R2,
        Rd => Rd,
        Immidiate_Out => IVDecode,
        clk => clock
    );
    
    -- D/X
    DX : ID_EX Port Map ( -- Input ports....
                    BDest_In => BDEST,
                    ReadData1_In => RValueA,
                    ReadData2_In => RValueB,
                    MuxOut_In => AluInB,
                    Write_Address_In => Rd,
                    MTR_In => MTR,
                    UB_In => UB,
                    ZB_In => ZB,
                    NB_In => NB,
                    ALUC_In => AluOpCode,
                    RW_In => RW,
                    MW_In => MW,
                    IVA_in => IVA,
                    RDS_in => RDS,
                    IV_in => IVDecode,
                    -- Output ports...
                    BDest_Out => BDESTX,
                    ReadData1_Out => RVAX,
                    ReadData2_Out => RVBX,
                    MuxOut_Out => ALuInBx,
                    Write_Address_Out => RDX,
                    MTR_Out => MTRX,
                    UB_Out => UBX,
                    ZB_Out => ZBX,
                    NB_Out => NBX,
                    ALUC_Out => AluOpX,
                    RW_Out => RWX,
                    MW_Out => MWX,
                    IVA_out => IVAX,
                    RDS_out => RDSX,
                    IV_out => IVX,
                    -- clock...
                    clk => clock
            );
    
    -- X/M
    XM: EX_MEM Port Map ( -- Input ports....
                    ALUResult_In => AluResult,
                    ReadOut2_In => RVBX,
                    Write_Address_In => RDX,
                    MW_In => MWX,
                    MTR_In => MTRX,
                    RW_In => RWX,
                    RDS_in => RDSX,
                    IV_in => IVX,
                    -- Output ports....
                    ALUResult_Out => ALURM,
                    ReadOut2_Out => RVBM,
                    Write_Address_Out => RDM,
                    MW_Out => MWM,
                    MTR_Out => MTRM,
                    RW_Out => RWM,
                    RDS_out => RDSM,
                    IV_out => IVM,
                    -- clock....
                    clk => clock
                    );
    -- M/W
    MWPR: MEM_WB Port Map ( -- Input ports...
                    MemDataOutput_IN => MemDataOut,
                    ALUResult_In => ALURM,
                    Write_Address_In => RDM,
                    MTR_In => MTRM,
                    RW_In => RWM,
                    RDS_in => RDSM,
                    IV_in => IVM,
                    
                    --Output ports...
                    ALUResult_Out => ALURW,
                    MemDataOutput_Out => MEMDW,
                    Write_Address_Out => RDW,
                    MTR_Out => MTRW,
                    RW_Out => RWW,
                    IV_out => IVW,
                    RDS_out => RDSW,
                    --clock...
                    clk => clock
                    );
    
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
        
        file_open(output, outputFolderPath & "PipeTest" & programNum & ".txt", write_mode);
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
    begin
        if falling_edge(clock) and start = '1' then
            write(lineOut, string'("PC: ") & integer'image(to_integer(unsigned(ProgramCounter))));
            write(lineOut, " (" & vectorToString(ProgramCounter) & ")");
            writeLine(output, lineOut);
            -- F/D
            write(lineout, string'("  F->D Register:"));
            writeLine(output, lineOut);
            write(lineout, "    Instruction in: " & vectorToString(Instruction));
            writeLine(output, lineOut);
            write(lineOut, "    Immediate Value in: " & vectorToString(immediateValue));
            writeLine(output, lineOut);
            
            
            
            write(lineOut, string'("    OpCode out: "));
            write(lineOut, opCodeToString(opCode));
            write(lineOut, string'(" ("));
            write(lineOut, vectorToString(opCode));
            write(lineOut, string'(")"));
            writeLine(output, lineOut);
            
            write(lineOut, "    Rd address out: " & vectorToString(Rd));
            writeLine(output, lineOut);
            
            write(lineOut, "    R1 addess out: " & vectorToString(R1));
            writeLine(output, lineOut);
            
            write(lineOut, "    R2 address out: " & vectorToString(R2));
            writeLine(output, lineOut);
            
            write(lineOut, "    BDEST out: " & vectorToString(BDEST));
            writeLine(output, lineOut);
                        
            write(lineOut, "    Immediate Value out: " & vectorToString(IVDecode));
            writeLine(output, lineOut);
            -- D/X
            
            -- X/M
            
            -- M/W
        end if;
    end process;
end Behavioral;
