library IEEE; 
use IEEE.std_logic_1164.all;

entity ControlHazardDetection is

 port(				
	iBranchNotEqual		: in std_logic;				--1 for Branch Not Equal, 0 for Branch Equal
	iBranchCtrl 		: in std_logic;				
	iALUOp			: in std_logic_vector(3 downto 0);	--BEQ or BNE
	iIFIDRS			: in std_logic_vector(4 downto 0);	--Branch Comparator A
	iIFIDRT			: in std_logic_vector(4 downto 0);	--Branch Comparator B
	iIDEXRD			: in std_logic_vector(4 downto 0);	--Used to check ALU data hazard
	iIDEXRT			: in std_logic_vector(4 downto 0);	--Used to check LW data hazard
	iIDEXRegWrEn		: in std_logic;				--Used to check ALU data hazard
	iIDEXMemToReg		: in std_logic;				--Used to check ALU data hazard
	iEXMEMRegWrEn		: in std_logic;				--Used to check LW data hazard
	iEXMEMRT		: in std_logic_vector(4 downto 0);	--Used to check LW data hazard
	iEXMEMMemToReg		: in std_logic;				--Used to check LW data hazard
	iJumpCtrl		: in std_logic;
	IF_Flush 		: out std_logic; 			--Flush if branch is taken
	iStall			: out std_logic				--Stall is high for ALU and LW data hazards
      );
end ControlHazardDetection;

architecture behavior of ControlHazardDetection is

begin
	process(iJumpCtrl, iBranchNotEqual, iBranchCtrl, iALUOP,	--Control Signals 
		iIFIDRS, iIFIDRT, 					--IF/ID Stage
		iIDEXRD, iIDEXRT, iIDEXRegWrEn, iIDEXMemToReg, 		--ID/EX Stage
		iEXMEMRegWrEn, iEXMEMRT, iEXMEMMemToReg)		--EX/MEM Stage
	begin

	if iJumpCtrl = '1' then	--Jump instruction
		IF_Flush 	<= '1';
		iStall		<= '0';

	elsif iBranchCtrl = '1' then --Branch Instruction

		if iIDEXMemToReg = '0' AND iIDEXRegWrEn = '1' AND (iIFIDRS = iIDEXRD OR iIFIDRT = iIDEXRD) then	--If there is a ALU operation right before branch instruction. Need one stall
				
			iStall	<= '1';	--ALU Operation Hazard, Need value from EXMEM Register
							--One Stall Needed

		elsif iIDEXMemToReg = '1' AND iIDEXRegWrEn = '1' AND (iIFIDRS = iIDEXRT OR iIFIDRT = iIDEXRT) then	--If there is a LW instruction right before branch instruction. Need two stalls
				
			iStall	<= '1';	--LW Operation Hazard, Need value from MEMWB Stage
							--Two Stalls Need. One stall now, another stall next cycle
							--If this elsif is executed, then the elsif right below should execute aswell. They work together

		elsif iEXMEMMemToReg = '1' AND iEXMEMRegWrEn = '1' AND (iIFIDRS = iEXMEMRT OR iIFIDRT = iEXMEMRT) then
	
			iStall <= '1';	--LW Operation Hazard, Need value from MEMWB Stage	
							--One stall needed to avoid LW data hazard. Two stalls in total needed
							--One stall already executed from prev elsif. Another stall executed here

		elsif (iALUOp = "1100" AND iBranchNotEqual = '0') OR (iALUOp = "1101" AND iBranchNotEqual = '1') then	--Check if the branch is true

			iStall 		<= '0'; 
			IF_Flush 	<= '1';	
					

		else		--If there are no data hazards.
				
			iStall		<= '0';	--No stalls needed
			IF_Flush 	<= '0'; --Branch not taken so no flush needed.
				
		end if;

	else	-- If not a branch or jump, no control hazard detection needed
		IF_FLush 	<= '0';
		iStall		<= '0';
	end if;
	end process;
	

end behavior;
