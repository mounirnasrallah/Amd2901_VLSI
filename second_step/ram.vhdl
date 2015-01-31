LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY ram IS
PORT(
  a	       : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  alu_out  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  b	       : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  cke	   : IN STD_LOGIC;
  i	       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  r0_from  : IN STD_LOGIC;
  r0_to	   : OUT STD_LOGIC;
  r3_from  : IN STD_LOGIC;
  r3_to	   : OUT STD_LOGIC;
  ra	   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  rb	   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  vdd	   : IN STD_LOGIC;
  vss	   : IN STD_LOGIC
  );
end ram;

architecture archram of ram is
  signal data:std_logic_vector(3 downto 0);
  type ram_array is array (15 downto 0) of std_logic_vector(3 downto 0);
  signal ab_data:ram_array;
  signal ram_en:std_logic;
Begin

  with i select
    ram_en<='0' when "000"|"001",
            '1' when others;

  with i select
      data<=    r3_from & alu_out(3 downto 1) when "100" | "101",--shift right
                alu_out(2 downto 0)& r0_from  when "110" | "111",--shift left
                alu_out when others;

  reg: process(cke)
  begin
    if (rising_edge(cke) and (ram_en='1')) then
      ab_data(to_integer(unsigned(b)))<=data ;
    end if;
  end process;

  ra<= ab_data(to_integer(unsigned(a)));
  rb<= ab_data(to_integer(unsigned(b)));

  r3_to<=alu_out(3) when (i="110" or i="111") else 'Z';
  r0_to<=alu_out(0) when (i="100" or i="101") else 'Z';
end archram;
