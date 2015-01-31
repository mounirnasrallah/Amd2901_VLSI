
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY muxe IS
  PORT(
  accu	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  d	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  i	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  r	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  ra	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  rb	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  s	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
END muxe;

ARCHITECTURE archmuxe OF muxe IS
Begin

  with i select
     r<= ra      WHEN "000",
         ra      WHEN "001",
         "0000"  WHEN "010",
         "0000"  WHEN "011",
         "0000"  WHEN "100",
         d       WHEN "101",
         d       WHEN "110",
         d       WHEN "111",
         "XXXX"  WHEN others;
  with i select
     s<= accu    WHEN "000",
         rb      WHEN "001",
         accu    WHEN "010",
         rb      WHEN "011",
         ra      WHEN "100",
         ra      WHEN "101",
         accu    WHEN "110",
         "0000"  WHEN "111",
         "XXXX"  WHEN others;

END archmuxe;
