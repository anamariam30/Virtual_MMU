----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 17:35:38
-- Design Name: 
-- Module Name: mux - Behavioral
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

library ieee; 
use ieee.std_logic_1164.all; 
package array_pkg is 
    type array_of_bytes is array(natural range <>) of std_logic_vector(7 downto 0); 
 end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.array_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port ( data_in : in  array_of_bytes (7 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end mux;

architecture Behavioral of mux is

begin

process(data_in,sel)
begin
case sel is
   when "00000001" => data_out<=data_in(7);
   when "00000010" => data_out<=data_in(6);
   when "00000100" => data_out<=data_in(5);
   when "00001000" => data_out<=data_in(4);
   when "00010000" => data_out<=data_in(3);
   when "00100000" => data_out<=data_in(2);
   when "01000000" => data_out<=data_in(1);
   when "10000000" => data_out<=data_in(0);
   when others =>data_out<="ZZZZZZZZ";
   
   
end case;
end process;


end Behavioral;
