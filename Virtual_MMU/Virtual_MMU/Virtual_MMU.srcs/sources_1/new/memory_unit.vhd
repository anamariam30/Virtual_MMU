----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2020 20:03:56
-- Design Name: 
-- Module Name: memory_unit - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity memory_unit is
--  Port ( clk:in std_logic ;
--  virtual_address: in std_logic_vector(29 downto 0); ---asta e adresa virtuala
--  physical_address: out std_logic_vector(19 downto 0)
--  );
--end memory_unit;

--architecture Behavioral of memory_unit is
--component MainMemory is
-- Port (clk:in std_logic;
--       load_from_disk: out std_logic;
--       virtual_address :in STD_LOGIC_VECTOR (29 downto 0); -- vpn
--       page_in: in std_logic_vector(39 downto 0);
--       page_out:out std_logic_vector(39 downto 0); -- pagina pe care o scriu pe disk
--       load_to_disk:out std_logic;-- daca memoria e plina si trebuie sa o inlocuiesc
--       physical_address:out std_logic_vector(19 downto 0)
--        );
--end component;

--component disk is
--  Port (clk:in std_logic;
--        virtual_address: in std_logic_vector(17 downto 0);
--        load_memory: in std_logic; -- page table  interrupt
--        page: out std_logic_vector(39 downto 0);
--        update:in std_logic; -- main memory
--        modified_page: in std_logic_vector(39 downto 0)
        
--   );
--end component;

--signal load_from_disk: std_logic;
--signal page_in: std_logic_vector(39 downto 0);
--signal page_out: std_logic_vector(39 downto 0); -- pagina pe care o scriu pe disk
--signal load_to_disk: std_logic;-- daca memoria e plina si trebuie sa o inlocuiesc


--begin

--main_memory: MainMemory port map(clk,load_from_disk,virtual_address,page_in,page_out,load_to_disk,physical_address);
--disk_map: disk port map(clk,virtual_address(29 downto 12),load_from_disk,page_in,load_to_disk,page_out);


--end Behavioral;
