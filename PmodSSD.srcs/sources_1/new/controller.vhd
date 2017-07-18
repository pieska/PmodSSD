----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2017 13:40:22
-- Design Name: 
-- Module Name: controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
	generic (
		-- clock in HZ, wird benutzt um disp_clk zu berehcnen
		CLK_RATE: positive := 100 * (10 ** 6);
		-- refreshrate display in HZ
		DISP_RATE: positive := 100
	);
	port (
		clk : in std_logic;
		en: in std_logic;
		number : in std_logic_vector(7 downto 0);
		segcode : out std_logic_vector(6 downto 0);
		an: out std_logic
	);
end controller;

architecture Behavioral of controller is

-- counter für disp_pulse
constant DISP_CNTR_VAL: integer := integer(ceil(real(CLK_RATE)/real(DISP_RATE)));

signal disp_cntr_reg: integer := DISP_CNTR_VAL;
signal disp_cntr_next: integer;

signal disp_pulse_reg: std_logic := '0';
signal disp_pulse_next: std_logic := '0';

signal an_reg: std_logic := '1'; -- first digit
signal an_next: std_logic := not an_reg;

signal segcode_reg: std_logic_vector(6 downto 0) := (others => '0');
signal segcode_next: std_logic_vector(6 downto 0) := (others => '0');

signal digit: std_logic_vector(3 downto 0);

alias number_msb is number(7 downto 4);
alias number_lsb is number(3 downto 0);

begin

	upd: process(clk)
	begin
		if rising_edge(clk) then
			-- pulse gen
			disp_cntr_reg <= disp_cntr_next;
			disp_pulse_reg <= disp_pulse_next;

			-- output gen
			if disp_pulse_reg = '1' then
				an_reg <= an_next;
				
				-- show if enabled else blank
				if en = '1' then
					segcode_reg <= segcode_next;
				else
					segcode_reg <= (others => '0');
				end if;
			end if;
			
		end if;
	end process upd;

	-- display counter and display pulse generation
	disp_cntr_next <= DISP_CNTR_VAL when disp_cntr_reg = 0 else disp_cntr_reg - 1;
	disp_pulse_next <= '1' when disp_cntr_reg = 0 else '0';

	-- multiplex zwischen lsb (an=1) und msb (an=0)
	digit <= number_lsb when an_reg = '1' else number_msb;

	-- segment encoding
	with digit
		select segcode_next <=
			"0111111" when x"0",
			"0000110" when x"1",
			"1011011" when x"2",
			"1001111" when x"3",
			"1100110" when x"4",
			"1101101" when x"5",
			"1111101" when x"6",
			"0000111" when x"7",
			"1111111" when x"8",
			"1100111" when x"9",
			"1110111" when x"a",
			"1111100" when x"b",
			"0111001" when x"c",
			"1011110" when x"d",
			"1111001" when x"e",
			"1110001" when x"f",
			"0000000" when others;
	
	-- switch an
	an_next <= not an_reg;

	-- outputs
	segcode <= segcode_reg;
	an <= an_reg;

end Behavioral;
