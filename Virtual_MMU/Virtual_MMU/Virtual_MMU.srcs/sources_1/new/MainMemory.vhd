----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2020 18:04:02
-- Design Name: 
-- Module Name: MainMemory - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MainMemory is
 Port (clk:in std_logic;
       write:in std_logic;
       writing_address:out std_logic_vector(7 downto 0);
       page_in: in std_logic_vector(39 downto 0);
       page_out:out std_logic_vector(39 downto 0); -- pagina pe care o scriu pe disk
       full:out std_logic;
       main_modified: out std_logic
       --load_to_disk:out std_logic;-- daca memoria e plina si trebuie sa o inlocuiesc
       --modified: in std_logic
        );
end MainMemory;

architecture Behavioral of MainMemory is



type main_memory is array(0 to 19) of std_logic_vector(39 downto 0);
--4096 bits=pagina
signal memory:main_memory:= (
    x"0000000001",
    x"0000000010",
    x"0000000011",
    x"0000000100",
    x"0000000101",
    x"0000000110",
    x"0000000111",
    x"0000001000",
    x"0000001001",
    x"0000001010",
    x"0000001011",
    x"0000001100",
    x"0000001101",
    x"0000001110",
    x"0000001111",
    x"0000010000",
    x"0000010001",
    x"0000010010",
    x"0000010011",
    x"0000010100"  
);
signal count: std_logic_vector(7 downto 0):="00000110"; --- unde am liber in memorie
signal count1: std_logic_vector(7 downto 0):="00000110";
--signal ppn:std_logic_vector(7 downto 0);
--signal load:std_logic;
--signal new_ppn: std_logic_vector(7 downto 0);
signal f:std_logic:='0';
begin
                 
process(clk)
begin

if rising_edge(clk) then
if write='1' then
memory(conv_integer(count))<=page_in; 

end if;
count<=count1;

end if;
page_out<=memory(conv_integer(count));
writing_address<=count;
end process;
                             
process(write)
begin
if write='1' then
   if count="00000110" then --memoria e plina=256
    count1<="00000000";
    f<='1';
   else
    count1<=count1+'1';
 end if;

end if;
end process;

process(clk)
begin
full<=f;

if f ='1' and write='1' then 
main_modified<='1';
else
main_modified<='0';
end if;
end process;


end Behavioral;
