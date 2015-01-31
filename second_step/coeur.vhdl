--
-- Generated by VASY
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY coeur IS
PORT(
  a_from_pads	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  b_from_pads	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  cin_from_pads	: IN STD_LOGIC;
  ck	: IN STD_LOGIC;
  cout_to_pads	: OUT STD_LOGIC;
  d_from_pads	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  i_from_pads	: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
  ng_to_pads	: OUT STD_LOGIC;
  noe_from_pads	: IN STD_LOGIC;
  np_to_pads	: OUT STD_LOGIC;
  ovr_to_pads	: OUT STD_LOGIC;
  q0_from_pads	: IN STD_LOGIC;
  q0_to_pads	: OUT STD_LOGIC;
  q3_from_pads	: IN STD_LOGIC;
  q3_to_pads	: OUT STD_LOGIC;
  r0_from_pads	: IN STD_LOGIC;
  r0_to_pads	: OUT STD_LOGIC;
  r3_from_pads	: IN STD_LOGIC;
  r3_to_pads	: OUT STD_LOGIC;
  shift_l	: OUT STD_LOGIC;
  shift_r	: OUT STD_LOGIC;
  f3_to_pads	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC;
  y_oe	: OUT STD_LOGIC;
  y_to_pads	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  zero_to_pads	: OUT STD_LOGIC
);
END coeur;

ARCHITECTURE RTL OF coeur IS
  SIGNAL alu_out	: STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL r	: STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL ra	: STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL rb	: STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL s	: STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL saccu	: STD_LOGIC_VECTOR(3 DOWNTO 0);

  COMPONENT muxe
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
  END COMPONENT;

  COMPONENT ram
  PORT(
  a	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  alu_out	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  b	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  cke	: IN STD_LOGIC;
  i	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  r0_from	: IN STD_LOGIC;
  r0_to	: OUT STD_LOGIC;
  r3_from	: IN STD_LOGIC;
  r3_to	: OUT STD_LOGIC;
  ra	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  rb	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT accu
  PORT(
  accu	: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  alu_out	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  cke	: IN STD_LOGIC;
  i	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  q0_from	: IN STD_LOGIC;
  q0_to	: OUT STD_LOGIC;
  q3_from	: IN STD_LOGIC;
  q3_to	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC
   );
  END COMPONENT;

  COMPONENT alu
  PORT(
  alu_out	: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  cin	: IN STD_LOGIC;
  cout	: OUT STD_LOGIC;
  i	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  ng	: OUT STD_LOGIC;
  np	: OUT STD_LOGIC;
  ovr	: OUT STD_LOGIC;
  r	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  s	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  f3	: OUT STD_LOGIC;
  vdd	: IN STD_LOGIC;
  vss	: IN STD_LOGIC;
  zero	: OUT STD_LOGIC
   );
  END COMPONENT;

  COMPONENT muxs
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
  END COMPONENT;

BEGIN
  imuxe : muxe
  PORT MAP (
    accu(3 downto 0) => saccu,
    d(3 downto 0) => d_from_pads,
    i(2 downto 0) => i_from_pads(2 downto 0),
    r => r,
    ra => ra,
    rb => rb,
    s => s,
    vdd => vdd,
    vss => vss
  );
  imuxs : muxs
  PORT MAP (
    alu_out => alu_out,
    i(2 downto 0) => i_from_pads(8 downto 6),
    noe => noe_from_pads,
    oe => y_oe,
    ra => ra,
    shift_l => shift_l,
    shift_r => shift_r,
    vdd => vdd,
    vss => vss,
    y(3 downto 0) => y_to_pads
  );
  ialu : alu
  PORT MAP (
    alu_out => alu_out,
    cin => cin_from_pads,
    cout => cout_to_pads,
    i(2 downto 0) => i_from_pads(5 downto 3),
    ng => ng_to_pads,
    np => np_to_pads,
    ovr => ovr_to_pads,
    r => r,
    s => s,
    f3 => f3_to_pads,
    vdd => vdd,
    vss => vss,
    zero => zero_to_pads
  );
  iaccu : accu
  PORT MAP (
    accu(3 downto 0) => saccu,
    alu_out => alu_out,
    cke => ck,
    i(2 downto 0) => i_from_pads(8 downto 6),
    q0_from => q0_from_pads,
    q0_to => q0_to_pads,
    q3_from => q3_from_pads,
    q3_to => q3_to_pads,
    vdd => vdd,
    vss => vss
  );
  iram : ram
  PORT MAP (
    a(3 downto 0) => a_from_pads,
    alu_out => alu_out,
    b(3 downto 0) => b_from_pads,
    cke => ck,
    i(2 downto 0) => i_from_pads(8 downto 6),
    r0_from => r0_from_pads,
    r0_to => r0_to_pads,
    r3_from => r3_from_pads,
    r3_to => r3_to_pads,
    ra => ra,
    rb => rb,
    vdd => vdd,
    vss => vss
  );
END RTL;