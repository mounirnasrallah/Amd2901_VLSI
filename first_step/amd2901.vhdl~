 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.numeric_std.all;
-- use IEEE.std_logic_arith.all;
--use IEEE.all;
entity amd2901 is
  Port (
    i    : in std_logic_vector(8 downto 0);
    d    : in std_logic_vector(3 downto 0);
    a    : in std_logic_vector(3 downto 0);
    b    : in std_logic_vector(3 downto 0);
    y    : out std_logic_vector(3 downto 0);
    noe  : in std_logic;
    clk  : in  std_logic;
    cin  : in  std_logic;
    ng   : out  std_logic;
    np   : out  std_logic;
    cout : out  std_logic;
    ovr  : out  std_logic;
    zero : out std_logic;
    f3 : out std_logic;
    q0   : inout  std_logic;
    q3   : inout  std_logic;
    r0   : inout  std_logic;
    r3   : inout  std_logic;
    vdde	: IN STD_LOGIC;
    vddi	: IN STD_LOGIC;
    vsse	: IN STD_LOGIC;
    vssi	: IN STD_LOGIC
    );
  end entity amd2901;

architecture beh of amd2901 is

-- declaration des signaux

-------------BEGIN: SIGNAUX ---------------
  signal ad : std_logic_vector(3 downto 0);
  signal bd : std_logic_vector(3 downto 0);
  signal q  : std_logic_vector(3 downto 0);
  signal r  : std_logic_vector(3 downto 0);
  signal s  : std_logic_vector(3 downto 0);
  signal y_tmp: std_logic_vector(3 downto 0);
  signal f  : std_logic_vector(3 downto 0);
  signal q_en:std_logic:='0';
  signal d_qreg:std_logic_vector(3 downto 0);
  signal ram_en:std_logic;
  signal data:std_logic_vector(3 downto 0);
  type ram_array is array (15 downto 0) of std_logic_vector(3 downto 0);
  signal ab_data:ram_array;
  signal accu_reg:std_logic_vector(3 downto 0);

  signal P    : STD_LOGIC_VECTOR (3 downto 0);
  signal G    : STD_LOGIC_VECTOR (3 downto 0);
  signal C3   : STD_LOGIC;
  signal C4   : STD_LOGIC;
  signal c    : STD_LOGIC_VECTOR (4 downto 0);
  signal k    : STD_LOGIC_VECTOR (4 DOWNTO 0);
  signal sig1 : STD_LOGIC_VECTOR (3 downto 0);
  signal sig2 : STD_LOGIC_VECTOR (3 downto 0);
  signal sig3 : STD_LOGIC_VECTOR (3 downto 0);
-------------END: SIGNAUX ----------------

Begin

  -----------------------------------------------------------------------------
  -- ----------------BEGIN: MUX2IN_IN_ALU en entrée de R et S de ALU---------------------
  --ad: A data; bd:B data; q: Accumulateur data; d:Direct data input; i:Ctl bit
  -- pilotage des entrées de l'ALU
  -----------------------------------------------------------------------------

  with i(2 downto 0) select
     r<= ad      WHEN "000",
         ad      WHEN "001",
         "0000"  WHEN "010",
         "0000"  WHEN "011",
         "0000"  WHEN "100",
         d       WHEN "101",
         d       WHEN "110",
         d       WHEN "111",
         "XXXX"  WHEN others;
  with i(2 downto 0) select
     s<= q       WHEN "000",
         bd      WHEN "001",
         q       WHEN "010",
         bd      WHEN "011",
         ad      WHEN "100",
         ad      WHEN "101",
         q       WHEN "110",
         "0000"  WHEN "111",
         "XXXX"  WHEN others;

  -----------------------------------------------------------------------------
  -- ----------------END: MUX en entrée de R et S de ALU-----------------------
  -----------------------------------------------------------------------------

  ---------------------------------------------------------------------------
  -- ----------------BEGIN: MUX2IN_OUT_ALU-----------------------------
  ---------------------------------------------------------------------------

  y_tmp<=ad when i(8 downto 6)="010" else f;
  y<=y_tmp  when noe='0' else "ZZZZ";

  -------------------------------------------------------------------------------
  -- ----------------END: MUX2IN_OUT_ALU-------------------------------------
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- -----------------Begin: ALU------------------------------------------------
  ------------------------------------------------------------------------------

  with i(5 downto 3) select
    P <=  r or s          when "000"|"011"|"100"|"111",
			    (not(r)) or s   when "001"|"101"|"110",
			    r or (not (s))  when others;

  with i(5 downto 3) select
    G <=  r and s         when "000"|"011"|"100"|"111",
          (not(r)) and s  when "001"|"101"|"110",
          r and (not(s))  when others;

  C4 <= G(3) or (P(3) and G(2))or(P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and cin);
  C3 <= G(2) or (P(2) and G(1)) or  (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and cin);


  with i(5 downto 3) select
  k <=  "00000" when "000",
        "00001" when "001",
        "00010" when "010",
        "11011" when "011",
        "10111" when "100",
        "10110" when "101",
        "10001" when "110",
        "10000" when others;

  c(0)<=cin;
  ALOUT: for j in 0 to 3 generate
  
    sig1(j)<= ((r(j) xor k(0)) nand (s(j) xor k(1)));
    sig2(j)<= ((r(j) xor k(0)) nor (s(j) xor k(1)));
    c(j+1)<= (sig1(j) nand ( (not sig2(j)) nand c(j)));
    sig3(j)<= (k(2) nor sig1(j)) xor (k(3) nor sig2(j));
    f(j)<= (sig3(j) xnor (k(4) nor c(j)));
                    
  end generate ALOUT;
  
  with i(5 downto 3) select
    cout<= c(4) when "000" | "001" | "010",
           (not(P(0) and P(1) and P(2) and P(3)) or cin) when "011",
           (G(0) or G(1) or G(2) or G(3) or cin) when "100"|"101",
           ((P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0) and (G(0) or not cin))) when others;
  with i(5 downto 3) select           
    ovr<= (c(4) xor c(3))  when "000"|"001"|"010",
          (not(P(0) and P(1) and P(2) and P(3)) or cin) when "011",
          (not(G(0) or G(1) or G(2) or G(3)) or not cin) when "100"|"101",
          not((P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0) and (G(0) or not cin))) when others;  
  
  with i(5 downto 3) select
    ng<=  not(G(3) or(P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(1) and P(2) and P(3) and G(0))) when "000"|"001"|"010",
          P(0) and P(1) and P(2) and P(3)  when "011",
          not(G(0) or G(1) or G(2) or G(3))  when "100"|"101",
          (P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0))  when others; 
        
  with i(5 downto 3) select 
    np <= not(P(0) and P(1) and P(2) and P(3) ) when "000"|"001"|"010",
          (G(0) or G(1) or G(2) or G(3)) when "111"|"110",
          '0' when others; 
       
  
  f3<= f(3);
  zero<='1' when f="0000" else '0';
-------------------------------------------------------------------------------
-- -----------------END: ALU---------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- ----------------BEGIN: Q_REG------------------------------------------------
-------------------------------------------------------------------------------

--definir q_en
  with i(8 downto 6) select
    q_en<='1' when "000"|"100"|"110",
          '0' when others;
          
            with i(8 downto 6) select
    d_qreg<= accu_reg(2 downto 0) & q0 when "110",--shift left
             q3 & accu_reg(3 downto 1) when "100",--shift right
             f when others; 
                       
  q3<=accu_reg(3)when(i(8 downto 6)="111" or i(8 downto 6)="110")else 'Z';
  q0<=accu_reg(0)when(i(8 downto 6)="101" or i(8 downto 6)="100")else 'Z';

  process(clk)
  begin
    if rising_edge(clk) and q_en='1' then
      accu_reg<=d_qreg;   
    end if;
  end process;

  q<=accu_reg;
-------------------------------------------------------------------------------
-- ----------------END: Q_REG--------------------------------------------------
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- ----------------Begin: RAM--------------------------------------------------
-------------------------------------------------------------------------------  
  with i(8 downto 6) select
    ram_en<='0' when "000"|"001",
            '1' when others;

  with i(8 downto 6) select
      data<=    r3 & f(3 downto 1) when "100" | "101",--shift right
                f(2 downto 0)& r0 when "110" | "111",--shift left
                f when others;

  reg: process(clk)
  begin
    if (rising_edge(clk) and (ram_en='1')) then
      ab_data(to_integer(unsigned(b)))<=data ;
    end if;
  end process;

  ad<= ab_data(to_integer(unsigned(a)));
  bd<= ab_data(to_integer(unsigned(b)));

  r3<=f(3) when (i(8 downto 6)="110" or i(8 downto 6)="111") else 'Z';
  r0<=f(0) when (i(8 downto 6)="100" or i(8 downto 6)="101") else 'Z';
end architecture beh;
-------------------------------------------------------------------------------
-- ----------------END: RAM--------------------------------------------------
-------------------------------------------------------------------------------




