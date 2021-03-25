----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2020 19:14:51
-- Design Name: 
-- Module Name: disk - Behavioral
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

entity disk is
  Port (clk:in std_logic;
        address: in std_logic_vector(17 downto 0);-- adresa virtuala ca input, pe care o dau eu -- doar citesc cu ea
        load_memory: in std_logic; -- page table  interrupt
        address_i: in std_logic_vector(17 downto 0);-- echivalent cu count.
        page: out std_logic_vector(39 downto 0);
        update:in std_logic; -- load_disk
        modified_page: in std_logic_vector(39 downto 0)
        
   );
end disk;

architecture Behavioral of disk is
type disk is array(0 to 19) of std_logic_vector(39 downto 0);
--4096 bits=pagina
signal data:disk:= (
    x"1111100001",
    x"1111100010",
    x"1111100011",
    x"1111100100",
    x"1111100101",
    x"1111100110",
    x"1111100111",
    x"1111101000",
    x"1111101001",
    x"1111101010",
    x"1111101011",
    x"1111101100",
    x"1111101101",
    x"1111101110",
    x"1111101111",
    x"1111110000",
    x"1111110001",
    x"1111110010",
    x"1111110011",
    x"1111110100"  
);
begin

process(load_memory,update,clk)
begin
if load_memory='1' then
--if rising_edge(clk) then 
  
  page<= data(conv_integer(address));
 --end if;
 end if;
 if update='1' then 
   data(conv_integer(address_i))<=modified_page;
 


end if;

end process;


end Behavioral;
