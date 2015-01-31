
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY muxs IS
  PORT(
  alu_out	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  i		: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  noe		: IN STD_LOGIC;
  oe		: OUT STD_LOGIC;
  ra		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  shift_l	: OUT STD_LOGIC;
  shift_r	: OUT STD_LOGIC;
  vdd		: IN STD_LOGIC;
  vss		: IN STD_LOGIC;
  y		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
   );

END muxs;

ARCHITECTURE archmuxs OF muxs IS
signal alu_tmp : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
  alu_tmp <= ra  when i="010" else alu_out;
  y <= alu_tmp   when noe='0' else "ZZZZ";

  oe <= not noe;

  shift_l <= '1' when i="110" or i="111" else '0';
  shift_r <= '1' when i="100" or i="101" else '0';
END archmuxs;
