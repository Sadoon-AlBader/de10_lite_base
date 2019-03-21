library ieee;
use ieee.std_logic_1164.all;

entity de10_lite_base is port (
	--clocks
	ADC_CLK_10 				: 	in 	std_logic;
	MAX10_CLK1_50			:	in		std_logic;
	MAX10_CLK2_50			:	in		std_logic;
	--DRAM
	DRAM_ADDR					: 	out	std_logic_vector(12	downto 0	);
	DRAM_BA						:	out	std_logic_vector(1 	downto 0	);
	DRAM_CAS_N					:	out	std_logic;
	DRAM_CKE						:	out	std_logic;
	DRAM_CLK						:	out	std_logic;
	DRAM_CS_N					:	out	std_logic;
	DRAM_DQ						:	inout	std_logic_vector(15 downto 0);
	DRAM_LDQM					:	out	std_logic;
	DRAM_UDQM					:	out	std_logic;
	DRAM_RAS_N					:	out	std_logic;
	DRAM_WE_N					:	out	std_logic;
	--seven seg
	HEX0, HEX1, HEX2,
	HEX3, HEX4, HEX5		:	out	std_logic_vector(7 downto 0);
	--general human interface
	KEY						:	in		std_logic_vector(1 downto 0);
	SW							:	in		std_logic_vector(9 downto 0);
	LEDR						:	out	std_logic_vector(9 downto 0);
	--VGA
	VGA_B, VGA_G, VGA_R	:	out	std_logic_vector(3 downto 0);
	VGA_HS, VGA_VS			:	out	std_logic;
	--gsensor
	GSENSOR_CS_N			:	out	std_logic;
	GSENSOR_INT				:	in		std_logic_vector(2 downto 1);
	GSENSOR_SCLK			:	out	std_logic;
	GSENSOR_SDI, 
	GSENSOR_SDO				:	inout	std_logic;
	--arduino
	ARDUINO_IO				:	inout std_logic_vector(15 downto 0);
	ARDUINO_RESET_N		:	inout	std_logic;
	--IDE/GPIO
	GPIO						:	inout	std_logic_vector(35 downto 0)
);
end entity;

architecture de10_lite of de10_lite_base is

begin

	--unused below
	HEX0 <= "00000000"; --can always use (others => '0') but
	HEX1 <= "00000000"; --used literals to make it reusable.
	HEX2 <= "00000000";
	HEX3 <= "00000000";
	HEX4 <= "00000000";
	HEX5 <= "00000000";
	
	--DRAM
	DRAM_ADDR		<= (others => '0');
	DRAM_BA			<= "11";
	DRAM_CAS_N		<= '1';
	DRAM_CKE			<= '1';
	DRAM_CLK			<= '1';
	DRAM_CS_N		<= '1';
	DRAM_DQ			<= (others => 'Z');
	DRAM_LDQM		<= '1';
	DRAM_RAS_N		<= '1';
	DRAM_UDQM		<= '1';
	DRAM_WE_N		<= '1';
	
	--LEDS
	LEDR <= "0000000000";
	
	--VGA
	VGA_B		<= x"0";
	VGA_R		<= x"0";
	VGA_G		<= x"0";
	VGA_HS 	<= '0';
	VGA_VS	<= '0';
	
	--GSENSOR
	GSENSOR_CS_N	<= '0';
	GSENSOR_SCLK	<= '0';
	GSENSOR_SDI		<= '0';
	GSENSOR_SDO		<= '0';
	
	--ARDUINO and IDE
	ARDUINO_IO			<= x"0000";
	ARDUINO_RESET_N	<= '1';
	GPIO					<= x"000000000";
	
end architecture;