----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2020 00:10:21
-- Design Name: 
-- Module Name: tlb_sim - Behavioral
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

entity tlb_sim is
--  Port ( );
end tlb_sim;

architecture Behavioral of tlb_sim is
component TLB is
 Port ( clk:in std_logic;
        read:in std_logic;
        write:in std_logic;
        vpn:in std_logic_vector(17 downto 0);
        ppn_in:in std_logic_vector(7 downto 0);
        ppn_out:out std_logic_vector(7 downto 0);
        hit: out std_logic);
end component;
signal clk:std_logic:='0';
signal read:std_logic:='0';
signal write:std_logic:='0';
signal vpn:std_logic_vector(17 downto 0);
signal ppn_in:std_logic_vector(7 downto 0);
signal ppn_out:std_logic_vector(7 downto 0);
signal hit:std_logic:='0';

begin
clk_process: process
begin
clk<='0';
wait for 10 ns;
clk<='1';
wait for 10 ns;
end process;

stim_process: process
begin
wait for 20 ns;
write<='1';
vpn<="000000000000000000";
ppn_in<="00000000";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000001";
ppn_in<="00000001";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000010";
ppn_in<="00000010";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000011";
ppn_in<="00000011";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000100";
ppn_in<="00000100";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000101";
ppn_in<="00000101";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000110";
ppn_in<="00000110";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000000111";
ppn_in<="00000111";
wait for 20 ns;
write<='0';

wait for 20 ns;
write<='1';
vpn<="000000000000001000";
ppn_in<="00001000";
wait for 20 ns;
write<='0';

wait for 20 ns;
read<='1';
vpn<="000000000000000011";
wait for 20 ns;
read<='0';

end process;
uut: TLB port map(clk,read,write,vpn,ppn_in,ppn_out,hit);

end Behavioral;
