----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 18:00:46
-- Design Name: 
-- Module Name: TLB - Behavioral
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
library work;
use work.array_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TLB is
 Port ( clk:in std_logic;
        read:in std_logic;
        write:in std_logic;
        vpn:in std_logic_vector(17 downto 0);
        ppn_in:in std_logic_vector(7 downto 0);
        ppn_out:out std_logic_vector(7 downto 0);
        hit: out std_logic);
end TLB;

architecture Behavioral of TLB is

--tri-state buffer component
component triState_buffer is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--comparator component
component comparator is
    Port ( data_1 : in STD_LOGIC_VECTOR (17 downto 0);
           data_2 : in STD_LOGIC_VECTOR (17 downto 0);
           equal : out STD_LOGIC);
end component;

--mux component
component mux is
    Port ( data_in : in  array_of_bytes (7 downto 0);
           sel : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

type tlb_t is array(0 to 7) of std_logic_vector(25 downto 0);
signal tlb: tlb_t;
signal eq: std_logic_vector(7 downto 0);
signal counter: integer range 0 to 7;
signal frame_no_temp:std_logic_vector(7 downto 0);
signal mux_in: array_of_bytes(0 to 7);

begin

--initialize the 8 comparators and tri-state buffers
initialize:for i in 0 to 7 generate
   comp:comparator port map (tlb(i)(25 downto 8),vpn,eq(i));
   triS:triState_buffer port map (tlb(i)(7 downto 0),eq(i),mux_in(i));
end generate initialize;   

mux_sel:mux port map (mux_in,eq,frame_no_temp);

read_process:process(read,clk)
  begin
    if rising_edge(clk) and read='1' then 
     if eq(0)='1' or 
        eq(1)='1' or
        eq(2)='1' or
        eq(3)='1' or
        eq(4)='1' or
        eq(5)='1' or
        eq(6)='1' or
        eq(7)='1' then 
        hit<='1';
        ppn_out<=frame_no_temp;
     else
      hit<='0';
      ppn_out<="ZZZZZZZZ";
      end if;       
     end if;
    end process;
    
write_process:process(write,clk)
    begin
    if rising_edge(clk) and write='1' then 
       tlb(counter)<=vpn & ppn_in;
       if counter<7 then 
          counter<=counter+1;
       else
          counter<=0;
       end if;
       
     end if;
     end process;        



end Behavioral;
