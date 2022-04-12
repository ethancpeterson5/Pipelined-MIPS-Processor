library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALUcontrol is 
	port(ALUOP : in std_logic_vector(3 downto 0);
	functionF : in std_logic_vector(10 downto 0);
	shAmt : out std_logic_vector(4 downto 0);
	branchSelect : out std_logic;
	ALUcontrolOut : out std_logic_vector(3 downto 0);
	ImmType : in std_logic;
	i_CLK : in std_logic
);
end ALUcontrol;

architecture behavior of ALUcontrol is
begin
	process(ALUOP,functionF,ImmType,i_CLK)
	begin
	if ALUOP = "0010" and ImmType ='0' AND functionF(10 downto 6) = "00000" then --instructions: add, addu, sub, subu, and, nor, xor, or, slt
--		if ImmType = '1' then -- addi, addiu, sw
--			ALUcontrolOut <= "0000";
 		if functionF(5 downto 0) = "100010" or functionF(5 downto 0) = "100011" then --  sub, subu
			ALUcontrolOut <= "0001";
		elsif functionF (5 downto 0) = "100000" or functionF(5 downto 0) = "100001" then --add, addu
			ALUcontrolOut <= "0000";
		elsif functionF (5 downto 0) = "100100" then --and
			ALUcontrolOut <= "0010";
		elsif functionF (5 downto 0) = "100111" then --nor
			ALUcontrolOut <= "0110";
		elsif functionF (5 downto 0) = "100110" then --xor
			ALUcontrolOut <= "0101";
		elsif functionF (5 downto 0) = "000000" then --or
			ALUcontrolOut <= "0100";
		elsif functionF (5 downto 0) = "101010" then --slt
			ALUcontrolOut <= "0011";
--		elsif ImmType = '1' then -- addi, addiu, sw
--			ALUcontrolOut <= "0000";
		end if;
        elsif ALUOP = "0010" and ImmType = '1' then 
		ALUcontrolOut <= "0000";
	elsif ALUOP = "0100" then --lw
		ALUcontrolOut <= "0000";
	elsif ALUOP = "1000" then --andi
		ALUcontrolOut <= "0010";
	elsif ALUOP = "1001" then --xori
		ALUcontrolOut <= "0101";
	elsif ALUOP = "1010" then --ori
		ALUcontrolOut <= "0100";
	elsif ALUOP = "1011" then --slti
		ALUcontrolOut <= "0011";
	elsif ALUOP = "0010"  and  functionF(10 downto 6) /= "00000" then --sll, srl, sra
		if functionF(5 downto 0) = "000000" then --sll
			ALUcontrolOut <= "1010";
			shAmt <= functionF(10 downto 6);
		elsif functionF(5 downto 0) = "000010" then -- srl
			ALUcontrolOut <= "1000";
			shAmt <= functionF(10 downto 6);
		elsif functionF(5 downto 0) = "000011" then --sra
			ALUcontrolOut <= "1001";
			shAmt <= functionF(10 downto 6);
		end if;
	elsif ALUOP = "1100" then --beq
		branchSelect <= '1';
		ALUcontrolOut <= "0001";
	elsif ALUOP = "1101" then --bne
		branchSelect <= '0';
		ALUcontrolOut <= "0001";
	end if;
	end process;
end behavior;