library IEEE; 
use IEEE.std_logic_1164.all;
-- use work.busArray.array32;

--package busArray is
--
--type array32 is array(31 downto 0) of std_logic_vector(31 downto 0);
--
--end package busArray;
--
--library IEEE;
--use IEEE.std_logic_1164.all;

entity IF_ID is

 port(
      iUpdatedPCInstr	: in std_logic_vector(31 downto 0);
      iPCAddSrc		: in std_logic_vector(31 downto 0);
      iSignExtend	: in std_logic_vector(31 downto 0);
      iBranchControl	: in std_logic;
      iJumpControl      : in std_logic;
      iJALControl	: in std_logic;
      iJALAddr		: out std_logic_vector(31 downto 0);
      overflowPCAdd	: out std_logic;
      overflowBranchAdd : out std_logic;
      oUpdatedPCAdd     : out std_logic_vector(31 downto 0)
	
      );
end IF_ID;

architecture structural of IF_ID is


 component mux2t1_N

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

 end component;


 component ripplecarryadd_N 

  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(
      i_Ain          : in std_logic_vector(N-1 downto 0);
      i_Bin          : in std_logic_vector(N-1 downto 0);
      i_Cin          : in std_logic;
      o_Cout         : out std_logic;
      o_R            : out std_logic_vector(N-1 downto 0));

 end component;
 
 component shiftleft2

  port(in32        		: in std_logic_vector(31 downto 0);  
       out32shifted         : out std_logic_vector(31 downto 0)); 

 end component;


  component shiftleft226bit is 
	  port(in26        : in std_logic_vector(25 downto 0);  
               out28shifted         : out std_logic_vector(27 downto 0)
);  
 end component;




--signal s_dataOut	: std_logic_vector(31 downto 0);

signal s_PCout		: std_logic_vector(31 downto 0);
signal s_PCAdderOut	: std_logic_vector(31 downto 0);
signal s_BranchPCMuxout	: std_logic_vector(31 downto 0);

signal s_BranchPC	: std_logic_vector(31 downto 0);
signal s_shiftedL2Out	: std_logic_vector(31 downto 0);


--signal s_ExtdrResult	: std_logic_vector(31 downto 0);
--signal s_RegDstOut	: std_logic_vector(4 downto 0);
--signal s_ReadData1	: std_logic_vector(31 downto 0);
--signal s_ReadData2	: std_logic_vector(31 downto 0);


signal s_jumpAdd        : std_logic_vector(27 downto 0);
signal s_finalPC        : std_logic_vector(31 downto 0);
signal s_AdderBinSrc	: std_logic_vector(31 downto 0);
signal s_JALAddOut	: std_logic_vector(31 downto 0);
signal s_JumpJALMuxOut	: std_logic_vector(31 downto 0);
signal s_FinalJumpAdd : std_logic_vector(31 downto 0);

begin
  s_FinalJumpAdd <= s_PCAdderOut(31 downto 28) & s_jumpAdd;
  iJALAddr <= s_PCAdderOut;
  g_PCADDER: ripplecarryadd_N		--fulladder_n
    port MAP(
	i_Ain		=> iPCAddSrc,
	i_Bin      	=> x"00000004",	--s_AdderBinSrc
	i_Cin		=> '0',
	o_Cout		=> overflowPCAdd,
        o_R            	=> s_PCAdderOut);


--  g_MUX2T1PCAdderSrc: mux2t1_N
--    port MAP(
--	i_S		=> iJALControl,
--	i_D0      	=> x"00000004",
--	i_D1		=> x"00000004",
--        o_O            	=> s_AdderBinSrc);

  g_SHIFTL2: shiftleft2
    port MAP(
	in32		=> iSignExtend,
	out32shifted	=> s_shiftedL2Out);

  g_BRANCHADDER: ripplecarryadd_N		--fulladder_n
    port MAP(
	i_Ain		=> s_PCAdderOut,
	i_Bin      	=> s_shiftedL2Out,
	i_Cin		=> '0',
	o_Cout		=> overflowBranchAdd,
        o_R            	=> s_BranchPC);

  g_MUX2T1PCSrc: mux2t1_N
    port MAP(
	i_S		=> iBranchControl,
	i_D0      	=> s_PCAdderOut,
	i_D1		=> s_BranchPC,
        o_O            	=> s_BranchPCMuxout);


  muxJump : mux2t1_N
	port map(i_S    => iJumpControl,
		 i_D0   => s_BranchPCMuxout,
		 i_D1   => s_FinalJumpAdd,
		 o_O    => oUpdatedPCAdd
	);



   shiftL26bit : shiftleft226bit
	port map(in26 => iUpdatedPCInstr(25 downto 0),
		 out28shifted => s_jumpAdd);








--  IMem: mem
--    generic map(ADDR_WIDTH => 10,
--                DATA_WIDTH => 32)
--    port map(clk  => iCLK,
--             addr => s_PCout(11 downto 2),
--             data => InstExt,
--             we   => InstLd,
--             q    => s_dataOut);


--  g_MUX2T1RegDst: mux2t1_5
--    port MAP(
--	i_S		=> iRegDst,
--	i_D0      	=> s_dataOut(20 downto 16),
--	i_D1		=> s_dataOut(15 downto 11),
--        o_O            	=> s_RegDstOut);

--  g_EXTDR: extender
--    port MAP(
--	in16		=> s_dataOut(15 downto 0),
--	sel		=> iExtdrSel,
--	out32		=> s_ExtdrResult);





--  g_REGFILE: registerfile
--    port Map(
--	rst		=> iRST,
--        i_CLK		=> iCLK,
--        r_add1          => s_dataOut(25 downto 21),
--        r_add2          => s_dataOut(20 downto 16),
--	w_add           => s_RegDstOut,
--        w_Data          => iWriteData,
--        w_En		=> iRegWrite,
--        rs_out          => oReadData1,
--        rt_out		=> oReadData2);


end structural;
