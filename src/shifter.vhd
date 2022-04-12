library IEEE;
use IEEE.std_logic_1164.all;

entity shifter is
  port(i_X : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       i_type : in std_logic; -- 0 for logical, 1 for arithmetic
       i_dir : in std_logic; -- 0 for right, 1 for left
       o_Y : out std_logic_vector(31 downto 0));
end shifter;

architecture structural of shifter is

  component mux2t1
    port(i_S: in std_logic;
         i_D0: in std_logic;
         i_D1: in std_logic;
         o_O: out std_logic);
  end component;

signal s_in : std_logic_vector(31 downto 0);		
signal s_in_rev : std_logic_vector(31 downto 0);	
signal s_out_rev : std_logic_vector(31 downto 0);	
signal s_shift_1 : std_logic_vector(31 downto 0);	
signal s_shift_2 : std_logic_vector(31 downto 0);
signal s_shift_4 : std_logic_vector(31 downto 0);
signal s_shift_8 : std_logic_vector(31 downto 0);
signal s_shift_16 : std_logic_vector(31 downto 0);
signal s_fill : std_logic;

begin

-- reverse input for left shifts

  reverse_in: for i in 0 to 31 generate
    s_in_rev(31 - i) <= i_X(i);
  end generate reverse_in;

  input_select: for i in 0 to 31 generate shifter:
    mux2t1 port map(i_S => i_dir,
                    i_D0 => i_X(i),
                    i_D1 => s_in_rev(i),
                    o_O => s_in(i));
  end generate input_select;

-- select shift type

  fillbit:
    mux2t1 port map(i_S => i_type,
                    i_D0 => '0',
                    i_D1 => s_in(31), -- sign bit
                    o_O => s_fill);

-- 1 bit shift

  shift1zero:
    mux2t1 port map(i_S => i_shamt(0),
                    i_D0 => s_in(31),
                    i_D1 => s_fill,
                    o_O => s_shift_1(31));

  shift1: for i in 0 to 30 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(0),
                    i_D0 => s_in(i),
                    i_D1 => s_in(i+1),
                    o_O => s_shift_1(i));
  end generate shift1;

-- 2 bit shift

  shift2zeros: for i in 30 to 31 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(1),
                    i_D0 => s_shift_1(i),
                    i_D1 => s_fill,
                    o_O => s_shift_2(i));
  end generate shift2zeros;

  shift2: for i in 0 to 29 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(1),
                    i_D0 => s_shift_1(i),
                    i_D1 => s_shift_1(i+2),
                    o_O => s_shift_2(i));
  end generate shift2;

-- 4 bit shift

  shift4zeros: for i in 28 to 31 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(2),
                    i_D0 => s_shift_2(i),
                    i_D1 => s_fill,
                    o_O => s_shift_4(i));
  end generate shift4zeros;

  shift4: for i in 0 to 27 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(2),
                    i_D0 => s_shift_2(i),
                    i_D1 => s_shift_2(i+4),
                    o_O => s_shift_4(i));
  end generate shift4;

-- 8 bit shift

  shift8zeros: for i in 24 to 31 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(3),
                    i_D0 => s_shift_4(i),
                    i_D1 => s_fill,
                    o_O => s_shift_8(i));
  end generate shift8zeros;

  shift8: for i in 0 to 23 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(3),
                    i_D0 => s_shift_4(i),
                    i_D1 => s_shift_4(i+8),
                    o_O => s_shift_8(i));
  end generate shift8;

-- 16 bit shift

  shift16zeros: for i in 16 to 31 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(4),
                    i_D0 => s_shift_8(i),
                    i_D1 => s_fill,
                    o_O => s_shift_16(i));
  end generate shift16zeros;

  shift16: for i in 0 to 15 generate barrelShifter:
    mux2t1 port map(i_S => i_shamt(4),
                    i_D0 => s_shift_8(i),
                    i_D1 => s_shift_8(i+16),
                    o_O => s_shift_16(i));
  end generate shift16;

-- reverse output for left shifts

  reverse_out: for i in 0 to 31 generate
    s_out_rev(31 - i) <= s_shift_16(i);
  end generate reverse_out;

  output_select: for i in 0 to 31 generate shifter:
    mux2t1 port map(i_S => i_dir,
                    i_D0 => s_shift_16(i),
                    i_D1 => s_out_rev(i),
                    o_O => o_Y(i));
  end generate output_select;
  
end structural;
