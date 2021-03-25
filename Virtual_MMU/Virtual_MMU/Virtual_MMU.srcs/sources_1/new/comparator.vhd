----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 17:24:24
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    Port ( data_1 : in STD_LOGIC_VECTOR (17 downto 0);
           data_2 : in STD_LOGIC_VECTOR (17 downto 0);
           equal : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin
process(data_1,data_2)
begin
 if (data_1=data_2) then
     equal<='1';
 else
     equal<='0';
 end if;
end process;

end Behavioral;
