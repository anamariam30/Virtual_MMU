----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 19:11:13
-- Design Name: 
-- Module Name: Page_Table - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Page_Table is
    Port ( clk:in std_logic;
           virtual_address : in STD_LOGIC_VECTOR (17 downto 0);
           physical_address: out STD_LOGIC_VECTOR (7 downto 0);
           memory_adress:in std_logic_vector(7 downto 0);
           load: in std_logic;
           count: out std_logic_vector(17 downto 0);
           --new_physical_address: out std_lo
           --load_address: in std_logic_vector(7 downto 0);
           interrupt: out std_logic;
           modified:out std_logic;
           main_modified: in std_logic
           );
end Page_Table;

architecture Behavioral of Page_Table is
type page_tb is array(0 to 19) of std_logic_vector(9 downto 0);
--9 bit => valid bit & 8 bit -dirty bit 
signal pageTB: page_tb := (
    "1100000001",
    "1000000010",
    "1000000011",
    "0000000100",
    "0100000101",
    "1001001111",
    "1000000111",
    "1000001000",
    "1000001001",
    "1000001010",
    "1000001011",
    "1000001100",
    "1000001101",
    "1000001110",
    "1000001111",
    "1000010000",
    "1000010001",
    "1000010010",
    "1000010011",
    "1000010100"   
);

signal en:std_logic:='0';
signal modif:std_logic:='0';
signal aux_count: std_logic_vector(17 downto 0):="000000000000000000";
begin

process(virtual_address,load,clk)
begin
 if pageTB(conv_integer(virtual_address))(9)='1' then -- e in memorie
  physical_address<=pageTB(conv_integer(virtual_address))(7 downto 0);
  interrupt<='0';
 else
  interrupt<='1';

  end if;
end process;

--verific daca pentru pagina pe care o inlocuiesc din memorie am dirty bit = '1'
process(clk)
begin
for i in 0 to 19 loop
 if pageTB(i)(7 downto 0)=memory_adress then 
   if (pageTB(i)(8)='1') then 
    modif<='1';
   -- aux_count<= std_logic_vector(to_unsigned(i, 17));
   else
    modif<='0';
   end if;
   count<=aux_count;
 end if;
end loop;
modified<=modif;
end process;


process(clk)
begin
  if load='1' then
  if rising_edge(clk) then
   pageTB(conv_integer(virtual_address))(9)<='1';
   pageTB(conv_integer(virtual_address))(8)<='0';
   pageTB(conv_integer(virtual_address))(7 downto 0)<=memory_adress;-- cand am facut replace
  end if;
  end if;
end process;
--process(clk)
--begin
--if rising_edge(clk) then 
-- if main_modified='1' then
--   pageTB(conv_integer(aux_count))(9)<='0';
--   end if;
--end if;

--end process;


end Behavioral;
