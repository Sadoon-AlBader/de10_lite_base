library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	--gsensor? gravity?
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

architecture counter24bit of de10_lite_base is

	function seven_seg_lut(
		data : in std_logic_vector(3 downto 0)
		)	return std_logic_vector is
		
	variable ret   : std_logic_vector(7 downto 0);
	begin
		case (data) is
			when   x"0" => ret := "11000000";
			when   x"1" => ret := "11111001";
			when   x"2" => ret := "10100100";
			when   x"3" => ret := "10110000";
			when   x"4" => ret := "10011001";
			when   x"5" => ret := "10010010";
			when   x"6" => ret := "10000010";
			when   x"7" => ret := "11111000";
			when   x"8" => ret := "10000000";
			when   x"9" => ret := "10011000";
			when   x"a" => ret := "10001000";
			when   x"b" => ret := "10000011";
			when   x"c" => ret := "11000110";
			when   x"d" => ret := "10100001";
			when   x"e" => ret := "10000110";
			when   x"f" => ret := "10001110";
			when others => ret := "00000000";
		end case;
		return ret;
	end function;

	component rising_edge_detector is
	port (
		clk_in, rst_in, d_in	: in  std_logic;
		d_out									: out std_logic
		);
	end component;
	
	component counter_up is 
	generic (
		bits: integer := 8
	);

	port (
		clk_in, rst_in, en	: in  std_logic;
		data_out						: out std_logic_vector(bits-1 downto 0)
		);
	end component;

constant bits: integer := 24;
signal clk, rst, switch, button, en_counter, clk_slow	: 	std_logic;
signal counter_data												:	std_logic_vector(bits-1 downto 0);
signal clockticks: std_logic_vector(19 downto 0);
begin
	clock_div: process
	begin
		wait until clk'event and clk = '1';
		if clockticks < x"80000" THEN
			clk_slow <= '0';
		else
			clk_slow <= '1';
		end if;
	end process;



	rst <= KEY(0);
	clk <= MAX10_CLK1_50;
	button <= not KEY(1);
	
	--rising_edge_detector1: rising_edge_detector port map(clk,rst,not clk,en_counter);
	counter_up_inst:	counter_up generic map (bits) port map (clk_slow, rst, '1',counter_data);
	clk_div: 			counter_up generic map (20) port map (clk, rst, '1' , clockticks);

	--seven seg
	HEX0 <= seven_seg_lut(counter_data(3 downto 0));
	HEX1 <= seven_seg_lut(counter_data(7 downto 4));
	HEX2 <= seven_seg_lut(counter_data(11 downto 8));
	HEX3 <= seven_seg_lut(counter_data(15 downto 12));
	HEX4 <= seven_seg_lut(counter_data(19 downto 16));
	HEX5 <= seven_seg_lut(counter_data(23 downto 20));

	
	--unused below
	
	
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