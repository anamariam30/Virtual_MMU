----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 20:46:24
-- Design Name: 
-- Module Name: TestBench - Behavioral
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

entity TestBench is
--  Port ( );
end TestBench;

architecture Behavioral of TestBench is
component unit is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           read : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (29 downto 0);
           address_out : out STD_LOGIC_VECTOR (19 downto 0));
end component;

signal clk: std_logic := '0';
signal address_in : std_logic_vector(29 downto 0);
signal read: std_logic:='0';
signal en:std_logic:='0';
signal address_out :std_logic_vector(19 downto 0);

begin

clk_process: process
begin
clk<='0';
wait for 10 ns;
clk<='1';
wait for 10 ns;
end process;

event_process: process
begin
wait for 20 ns;
en<='1';
--read<='1';
--address_in<=B"000000000000000001_000100000001";
--wait for 20 ns;
--read<='0';
--wait for 120 ns;
--read<='1';
--address_in<=B"000000000000000010_001100000010";
--wait for 20 ns;
--read<='0';
--wait for 120 ns;
--read<='1';
--address_in<=B"000000000000000001_000100000011";
--wait for 20 ns;
--read<='0';
--wait for 80 ns;
read<='1';
address_in<=B"000000000000000011_000100001111";
wait for 20 ns;
read<='0';
wait for 300 ns;
read<='1';
address_in<=B"000000000000000100_000101101111";
wait for 20 ns;
read<='0';
wait for 300 ns;

en<='0';



end process;


uut: unit port map (clk,en, read,address_in,address_out);

end Behavioral;
