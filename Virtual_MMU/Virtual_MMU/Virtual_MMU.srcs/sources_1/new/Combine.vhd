----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 20:29:55
-- Design Name: 
-- Module Name: Combine - Behavioral
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

entity Combine is
    Port ( 
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           read : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (29 downto 0);
           address_out : out STD_LOGIC_VECTOR (19 downto 0));
end Combine;

architecture Behavioral of Combine is
component Page_Table is
    Port ( clk:in std_logic;
           address : in STD_LOGIC_VECTOR (17 downto 0);
           data : out STD_LOGIC_VECTOR (7 downto 0);
           load: in std_logic;
           interrupt: out std_logic);
end component;

component MMU_State_machine is
    Port ( clk : in STD_LOGIC;
           read: in STD_LOGIC;
           en : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (29 downto 0);
           address_out : out STD_LOGIC_VECTOR (19 downto 0);
           vpn : out STD_LOGIC_VECTOR (17 downto 0);
           ppn: in STD_LOGIC_VECTOR (7 downto 0);
           interrupt: in std_logic;
           load:out std_logic
           );
end component;

signal pageTb_address:std_logic_vector(17 downto 0);
signal pageTb_data:std_logic_vector(7 downto 0);
signal interrupt :std_logic;
signal load:std_logic;

begin
state_machine: MMU_State_Machine port map (clk,read,en,address_in,address_out,pageTb_address,pageTb_data,interrupt,load);
--page_tb: Page_Table port map (clk,pageTb_address,pageTb_data,load,interrupt);

end Behavioral;
