----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.07.2017 14:57:08
-- Design Name: 
-- Module Name: top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	port (
		GCLK: in std_logic;
		BTNC: in std_logic;
		SW: in std_logic_vector(7 downto 0);
		LED: out std_logic_vector(7 downto 0);
		SEG: out std_logic_vector(6 downto 0);
		AN: out std_logic
	);
end top;

architecture Behavioral of top is

component controller is
	generic (
		CLK_RATE: positive := 100 * (10 ** 6);
		DISP_RATE: positive := 100
	);
	port (
		clk : in std_logic;
		en: in std_logic;
		number : in std_logic_vector(7 downto 0);
		segcode : out std_logic_vector(6 downto 0);
		an: out std_logic
	);
end component;

signal btn: std_logic;

begin

	controller0: controller
	port map (
		clk => GCLK,
		en => btn,
		number => SW,
		segcode => SEG,
		an => AN
	);

	btn <= not BTNC;
	LED <= SW;

end Behavioral;
