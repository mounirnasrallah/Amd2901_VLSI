LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY accu IS
PORT(
  accu		: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  alu_out	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  cke		: IN STD_LOGIC;
  i		: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  q0_from	: IN STD_LOGIC;
  q0_to		: OUT STD_LOGIC;
  q3_from	: IN STD_LOGIC;
  q3_to		: OUT STD_LOGIC;
  vdd		: IN STD_LOGIC;
  vss		: IN STD_LOGIC
  );
END accu;

ARCHITECTURE archaccu OF accu IS

signal q_en:std_logic;
signal sh_qreg:std_logic_vector(3 downto 0);
signal accu_reg:std_logic_vector(3 downto 0);

Begin

  with i select
    q_en<='1' when "000"|"100"|"110",
          '0' when others;

  with i select
    sh_qreg<= accu_reg(2 downto 0) & q0_from when "110",--shift left
             q3_from & accu_reg(3 downto 1) when "100",--shift right
             alu_out when others; 
                       
  q3_to<=accu_reg(3)when(i="111" or i="110")else 'Z';
  q0_to<=accu_reg(0)when(i="101" or i="100")else 'Z';

  process(cke)
  begin
    if rising_edge(cke) and q_en='1' then
      accu_reg<=sh_qreg;   
    end if;
  end process;

  accu<= accu_reg;

END archaccu;
