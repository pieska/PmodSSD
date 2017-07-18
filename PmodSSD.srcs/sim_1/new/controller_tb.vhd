----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.07.2017 21:19:14
-- Design Name: 
-- Module Name: controller_tb - Behavioral
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

entity controller_tb is
--  Port ( );
end controller_tb;

architecture Behavioral of controller_tb is

component controller is
	generic (
		CLK_RATE: positive := 10;
		DISP_RATE: positive := 1
	);
	port (
		clk : in std_logic;
		en: in std_logic;
		number : in std_logic_vector(7 downto 0);
		segcode : out std_logic_vector(6 downto 0);
		an: out std_logic
	);
end component;

signal clk_sim: std_logic;
signal en_sim: std_logic;
signal number_sim: std_logic_vector(7 downto 0);
signal segcode_sim: std_logic_vector(6 downto 0);
signal an_sim: std_logic;

constant clkp:time := 1ns;

begin

	dut: controller
	port map (
		clk => clk_sim,
		en => en_sim,
		number => number_sim,
		segcode => segcode_sim,
		an => an_sim
	);

	clk_gen: process
	begin
		clk_sim <= '0';
		wait for clkp/2;
		clk_sim <= '1';
		wait for clkp/2;		
	end process clk_gen;
	
	sim: process
	begin
		en_sim <= '1';
		wait for clkp;
		number_sim <= X"42";
		wait;
	end process sim;
	
end Behavioral;
