----------------------------------------------------------------------------------
-- Engineer: Jordan Cottle
-- 
-- Create Date: 04/03/2019 09:37:32 AM
-- Module Name: Components
-- Description: Contains declarations of components to use in project
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

package Components is
    component Decoder10to1024 is
        Port ( Input : in STD_LOGIC_VECTOR (9 downto 0);
               Control : in STD_LOGIC;
               Output : out STD_LOGIC_VECTOR (1023 downto 0));
    end component;

    component Mux2To1_32b is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           control : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component Mux2To1_1b is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               control : in STD_LOGIC;
               result : out STD_LOGIC);
    end component;
    
    component ALU is
        Port ( opCode : in STD_LOGIC_VECTOR (3 downto 0);
               a : in STD_LOGIC_VECTOR (31 downto 0);
               b : in STD_LOGIC_VECTOR (31 downto 0);
               result : out STD_LOGIC_VECTOR (31 downto 0);
               z : out STD_LOGIC; -- zero
               n : out STD_LOGIC; -- negative
               e : out std_logic); -- error
    end component;
    
    component Registers_Fmain is
        Port ( Read_reg1 : in STD_LOGIC_VECTOR (3 downto 0);
               Read_reg2 : in STD_LOGIC_VECTOR (3 downto 0);
               Write_reg : in STD_LOGIC_VECTOR (3 downto 0);
               Write_Data : in STD_LOGIC_VECTOR (31 downto 0);
               RegWrite : in STD_LOGIC;
               ReadOut_Data1 : out STD_LOGIC_VECTOR (31 downto 0);
               ReadOut_Data2 : out STD_LOGIC_VECTOR (31 downto 0);
               clk: in STD_Logic
               );
    end component;
    
    component Data_Memory is
        Port ( Address : in STD_LOGIC_VECTOR (31 downto 0);
               Data_In : in STD_LOGIC_VECTOR (31 downto 0);
               Data_Out : out STD_LOGIC_VECTOR (31 downto 0);
               Mem_Write : in STD_LOGIC;
               clk: in STD_Logic
               );
    end component;
    
    component Instruction_Mem is
        Port ( PC : in STD_LOGIC_VECTOR (9 downto 0);
               Load_Address : in STD_LOGIC_VECTOR (9 downto 0);
               Load_File : in STD_LOGIC_VECTOR (31 downto 0);
               Load_Enable : in STD_LOGIC;
               Output_Data : out STD_LOGIC_VECTOR (31 downto 0);
               Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
               clk : in STD_LOGIC
               );
    end component;
    
    component PC is
        Port ( PC : out STD_LOGIC_VECTOR (9 downto 0);
               UB : in STD_LOGIC;
               NB : in STD_LOGIC;
               ZB : in STD_LOGIC;
               N : in STD_LOGIC;
               Z : in STD_LOGIC;
               BDEST : in STD_LOGIC_VECTOR (9 downto 0);
               clk : in STD_LOGIC;
               start: in std_logic);
    end component;
    
    component ISA_Controller is
        port ( opcode: in std_logic_vector(4 downto 0);
               alu_op: out std_logic_vector (3 downto 0);
               u_branch, z_branch, n_branch, reg_write, mem_write, mem_to_reg, reg_dst, iva: out std_logic
         );
     end component;
     
     component EX_MEM is
         Port ( -- Input ports....
                ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
                ReadOut2_In : in STD_LOGIC_VECTOR (31 downto 0);
                Write_Address_In : in std_logic_vector ( 3 downto 0);
                MW_In : in STD_LOGIC;
                MTR_In : in STD_LOGIC;
                RW_In : in STD_LOGIC;
                RDS_in : in std_logic;
                IV_in: in std_logic_vector(31 downto 0);
                -- Output ports....
                ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
                ReadOut2_Out : out STD_LOGIC_VECTOR (31 downto 0);
                Write_Address_Out : out std_logic_vector (3 downto 0);
                MW_Out : out STD_LOGIC;
                MTR_Out : out STD_LOGIC;
                RW_Out : out STD_LOGIC;
                RDS_out : out std_logic;
                IV_out: out std_logic_vector(31 downto 0);
                -- clock....
                clk : in STD_LOGIC
                );
     end component;
     
     component ID_EX is
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
                IVA_in : in std_logic;
                RDS_in : in std_logic;
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
                IVA_out : out std_logic;
                RDS_out : out std_logic;
                IV_out: out std_logic_vector(31 downto 0);
                -- clock...
                clk : in STD_LOGIC);
     end component;
     
     component IF_ID is
         Port ( Instruction : in STD_LOGIC_VECTOR (31 downto 0);
                Immidiate_In : in STD_LOGIC_VECTOR (31 downto 0);
                BDest : out STD_LOGIC_VECTOR (9 downto 0);
                Opcode : out STD_LOGIC_VECTOR (4 downto 0);
                R1 : out std_logic_vector (3 downto 0);
                R2 : out std_logic_vector (3 downto 0);
                Rd : out std_logic_vector (3 downto 0);
                Immidiate_Out : out STD_LOGIC_VECTOR (31 downto 0);
                clk : in STD_LOGIC
                );
     end component;
     
     component MEM_WB is
         Port ( -- Input ports...
                MemDataOutput_IN : in STD_LOGIC_VECTOR (31 downto 0);
                ALUResult_In : in STD_LOGIC_VECTOR (31 downto 0);
                Write_Address_In: in STD_LOGIC_VECTOR (3 downto 0);
                MTR_In : in std_logic;
                RW_In : in std_logic;
                IV_in: in std_logic_vector(31 downto 0);
                RDS_in: in std_logic;
                
                
                --Output ports...
                ALUResult_Out : out STD_LOGIC_VECTOR (31 downto 0);
                MemDataOutput_Out : out STD_LOGIC_VECTOR (31 downto 0);
                Write_Address_Out : out STD_LOGIC_VECTOR (3 downto 0);
                MTR_Out : out std_logic;
                RW_Out : out std_logic;
                IV_out: out std_logic_vector(31 downto 0);
                RDS_out: out std_logic;
                --clock...
                clk : in STD_LOGIC
                );
     end component;
end Components;