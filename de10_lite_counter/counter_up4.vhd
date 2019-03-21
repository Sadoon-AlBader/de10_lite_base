library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_up is 
generic (
	bits: integer := 8
);

port (
	clk_in, rst_in, en	: in  std_logic;
	data_out					: out std_logic_vector(bits-1 downto 0)
	);
end entity;

architecture rtl of counter_up is
signal r_counter                             : unsigned(bits-1 downto 0);

begin
data_out          <= std_logic_vector(r_counter);

process(clk_in,rst_in)
begin
	if(rst_in='0') then
		r_counter          <= (others=>'0');
	elsif(rising_edge(clk_in)) then
		if(en='1') then
			r_counter          <= r_counter + 1;
		end if;
	end if;
end process;

end rtl;

-- ******************************************************************** 
-- ******************************************************************** 
-- 
-- Coding style summary:
--
--	i_   Input signal 
--	o_   Output signal 
--	b_   Bi-directional signal 
--	r_   Register signal 
--	w_   Wire signal (no registered logic) 
--	t_   User-Defined Type 
--	p_   pipe
--  pad_ PAD used in the top level
--	G_   Generic (UPPER CASE)
--	C_   Constant (UPPER CASE)
--  ST_  FSM state definition (UPPER CASE)
--
-- ******************************************************************** 
--
-- Copyright ©2015 SURF-VHDL
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- ******************************************************************** 
--
-- Fle Name: counter_up4.vhd
-- 
-- scope: 4-bit counter with async reset active low and counter enable active high
--
-- rev 1.00
-- 
-- ******************************************************************** 
-- ******************************************************************** 
