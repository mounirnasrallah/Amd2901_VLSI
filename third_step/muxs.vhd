--
-- Generated by VASY
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY muxs IS
PORT(
  alu_out	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  i	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  noe	: IN STD_LOGIC;
  oe	: OUT STD_LOGIC;
  ra	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  shift_l	: OUT STD_LOGIC;
  shift_r	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC;
  y	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END muxs;

ARCHITECTURE RTL OF muxs IS
  SIGNAL not_i	: STD_LOGIC_VECTOR(2 DOWNTO 2);
  SIGNAL not_noe	: STD_LOGIC;
  SIGNAL not_aux1	: STD_LOGIC;
  SIGNAL nao2o22_x1_sig	: STD_LOGIC;
  SIGNAL nao2o22_x1_3_sig	: STD_LOGIC;
  SIGNAL nao2o22_x1_2_sig	: STD_LOGIC;
  SIGNAL nao22_x1_sig	: STD_LOGIC;
  SIGNAL na4_x1_sig	: STD_LOGIC;
  SIGNAL inv_x2_sig	: STD_LOGIC;
  SIGNAL inv_x2_7_sig	: STD_LOGIC;
  SIGNAL inv_x2_6_sig	: STD_LOGIC;
  SIGNAL inv_x2_5_sig	: STD_LOGIC;
  SIGNAL inv_x2_4_sig	: STD_LOGIC;
  SIGNAL inv_x2_3_sig	: STD_LOGIC;
  SIGNAL inv_x2_2_sig	: STD_LOGIC;

  COMPONENT nts_x1
  PORT(
  cmd	: IN STD_LOGIC;
  i	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT nao22_x1
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  i2	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT inv_x2
  PORT(
  i	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT na4_x1
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  i2	: IN STD_LOGIC;
  i3	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT nao2o22_x1
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  i2	: IN STD_LOGIC;
  i3	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT buf_x2
  PORT(
  i	: IN STD_LOGIC;
  q	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT a2_x2
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  q	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT no2_x1
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  nq	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT o3_x2
  PORT(
  i0	: IN STD_LOGIC;
  i1	: IN STD_LOGIC;
  i2	: IN STD_LOGIC;
  q	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

BEGIN
  y_3_ins : nts_x1
  PORT MAP (
    cmd => not_noe,
    i => nao22_x1_sig,
    nq => y(3),
    vdd => vdd,
    vss => vss
  );
  nao22_x1_ins : nao22_x1
  PORT MAP (
    i0 => inv_x2_7_sig,
    i1 => alu_out(3),
    i2 => na4_x1_sig,
    nq => nao22_x1_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_7_ins : inv_x2
  PORT MAP (
    i => not_aux1,
    nq => inv_x2_7_sig,
    vdd => vdd,
    vss => vss
  );
  na4_x1_ins : na4_x1
  PORT MAP (
    i0 => i(1),
    i1 => not_i(2),
    i2 => inv_x2_6_sig,
    i3 => inv_x2_5_sig,
    nq => na4_x1_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_6_ins : inv_x2
  PORT MAP (
    i => i(0),
    nq => inv_x2_6_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_5_ins : inv_x2
  PORT MAP (
    i => ra(3),
    nq => inv_x2_5_sig,
    vdd => vdd,
    vss => vss
  );
  y_2_ins : nts_x1
  PORT MAP (
    cmd => not_noe,
    i => nao2o22_x1_3_sig,
    nq => y(2),
    vdd => vdd,
    vss => vss
  );
  nao2o22_x1_3_ins : nao2o22_x1
  PORT MAP (
    i0 => alu_out(2),
    i1 => inv_x2_4_sig,
    i2 => not_aux1,
    i3 => ra(2),
    nq => nao2o22_x1_3_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_4_ins : inv_x2
  PORT MAP (
    i => not_aux1,
    nq => inv_x2_4_sig,
    vdd => vdd,
    vss => vss
  );
  y_1_ins : nts_x1
  PORT MAP (
    cmd => not_noe,
    i => nao2o22_x1_2_sig,
    nq => y(1),
    vdd => vdd,
    vss => vss
  );
  nao2o22_x1_2_ins : nao2o22_x1
  PORT MAP (
    i0 => alu_out(1),
    i1 => inv_x2_3_sig,
    i2 => not_aux1,
    i3 => ra(1),
    nq => nao2o22_x1_2_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_3_ins : inv_x2
  PORT MAP (
    i => not_aux1,
    nq => inv_x2_3_sig,
    vdd => vdd,
    vss => vss
  );
  y_0_ins : nts_x1
  PORT MAP (
    cmd => not_noe,
    i => nao2o22_x1_sig,
    nq => y(0),
    vdd => vdd,
    vss => vss
  );
  nao2o22_x1_ins : nao2o22_x1
  PORT MAP (
    i0 => alu_out(0),
    i1 => inv_x2_2_sig,
    i2 => not_aux1,
    i3 => ra(0),
    nq => nao2o22_x1_sig,
    vdd => vdd,
    vss => vss
  );
  inv_x2_2_ins : inv_x2
  PORT MAP (
    i => not_aux1,
    nq => inv_x2_2_sig,
    vdd => vdd,
    vss => vss
  );
  oe_ins : buf_x2
  PORT MAP (
    i => not_noe,
    q => oe,
    vdd => vdd,
    vss => vss
  );
  shift_l_ins : a2_x2
  PORT MAP (
    i0 => i(2),
    i1 => i(1),
    q => shift_l,
    vdd => vdd,
    vss => vss
  );
  shift_r_ins : no2_x1
  PORT MAP (
    i0 => i(1),
    i1 => not_i(2),
    nq => shift_r,
    vdd => vdd,
    vss => vss
  );
  not_noe_ins : inv_x2
  PORT MAP (
    i => noe,
    nq => not_noe,
    vdd => vdd,
    vss => vss
  );
  not_i_2_ins : inv_x2
  PORT MAP (
    i => i(2),
    nq => not_i(2),
    vdd => vdd,
    vss => vss
  );
  not_aux1_ins : o3_x2
  PORT MAP (
    i0 => i(0),
    i1 => i(2),
    i2 => inv_x2_sig,
    q => not_aux1,
    vdd => vdd,
    vss => vss
  );
  inv_x2_ins : inv_x2
  PORT MAP (
    i => i(1),
    nq => inv_x2_sig,
    vdd => vdd,
    vss => vss
  );
END RTL;
