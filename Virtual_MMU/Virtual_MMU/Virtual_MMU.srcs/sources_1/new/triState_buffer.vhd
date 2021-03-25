----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 17:33:09
-- Design Name: 
-- Module Name: triState_buffer - Behavioral
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

entity triState_buffer is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end triState_buffer;

architecture Behavioral of triState_buffer is

begin
data_out<=data_in when sel='1'
                  else
          "ZZZZZZZZ";


end Behavioral;
