----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 17:32:03
-- Design Name: 
-- Module Name: tri-state_buffer - Behavioral
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

entity tri-state_buffer is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           select : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end tri-state_buffer;

architecture Behavioral of tri-state_buffer is

begin


end Behavioral;
