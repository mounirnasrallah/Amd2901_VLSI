
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY alu IS
PORT(
  alu_out	: INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  cin		: IN STD_LOGIC;
  cout		: OUT STD_LOGIC;
  i		: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  ng		: OUT STD_LOGIC;
  np		: OUT STD_LOGIC;
  ovr		: OUT STD_LOGIC;
  r		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  s		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  f3		: OUT STD_LOGIC;
  vdd		: IN STD_LOGIC;
  vss		: IN STD_LOGIC;
  zero		: OUT STD_LOGIC
   );
END alu;

ARCHITECTURE archalu OF alu IS

  signal P    : STD_LOGIC_VECTOR (3 downto 0);
  signal G    : STD_LOGIC_VECTOR (3 downto 0);
  signal C3   : STD_LOGIC;
  signal C4   : STD_LOGIC;
  signal c    : STD_LOGIC_VECTOR (4 downto 0);
  signal k    : STD_LOGIC_VECTOR (4 DOWNTO 0);
  signal sig1 : STD_LOGIC_VECTOR (3 downto 0);
  signal sig2 : STD_LOGIC_VECTOR (3 downto 0);
  signal sig3 : STD_LOGIC_VECTOR (3 downto 0);

Begin

  with i select
    P <=  r or s          when "000"|"011"|"100"|"111",
			    (not(r)) or s   when "001"|"101"|"110",
			    r or (not (s))  when others;

  with i select
    G <=  r and s         when "000"|"011"|"100"|"111",
          (not(r)) and s  when "001"|"101"|"110",
          r and (not(s))  when others;

  C4 <= G(3) or (P(3) and G(2))or(P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and cin);
  C3 <= G(2) or (P(2) and G(1)) or  (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and cin);


  with i select
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
    alu_out(j)<= (sig3(j) xnor (k(4) nor c(j)));
                    
  end generate ALOUT;
  
  with i select
    cout<= c(4) when "000" | "001" | "010",
           (not(P(0) and P(1) and P(2) and P(3)) or cin) when "011",
           (G(0) or G(1) or G(2) or G(3) or cin) when "100"|"101",
           ((P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0) and (G(0) or not cin))) when others;
  with i select           
    ovr<= (c(4) xor c(3))  when "000"|"001"|"010",
          (not(P(0) and P(1) and P(2) and P(3)) or cin) when "011",
          (not(G(0) or G(1) or G(2) or G(3)) or not cin) when "100"|"101",
          not((P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0) and (G(0) or not cin))) when others;  
  
  with i select
    ng<=  not(G(3) or(P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(1) and P(2) and P(3) and G(0))) when "000"|"001"|"010",
          P(0) and P(1) and P(2) and P(3)  when "011",
          not(G(0) or G(1) or G(2) or G(3))  when "100"|"101",
          (P(3) and G(3)) or (P(3) and P(2) and G(2)) or (P(3) and P(2) and P(1) and G(1)) or (P(3) and P(2) and P(1) and P(0))  when others; 
        
  with i select 
    np <= not(P(0) and P(1) and P(2) and P(3) ) when "000"|"001"|"010",
          (G(0) or G(1) or G(2) or G(3)) when "111"|"110",
          '0' when others; 
       
  
  f3<= alu_out(3);
  zero<='1' when alu_out="0000" else '0';
END archalu;
