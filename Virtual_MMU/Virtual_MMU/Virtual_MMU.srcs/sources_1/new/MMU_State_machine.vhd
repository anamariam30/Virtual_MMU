----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2020 19:29:35
-- Design Name: 
-- Module Name: MMU_State_machine - Behavioral
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

entity MMU_State_machine is
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
end MMU_State_machine;

architecture Behavioral of MMU_State_machine is
component TLB is
 Port ( clk:in std_logic;
        read:in std_logic;
        write:in std_logic;
        vpn:in std_logic_vector(17 downto 0);
        ppn_in:in std_logic_vector(7 downto 0);
        ppn_out:out std_logic_vector(7 downto 0);
        hit: out std_logic);
end component;
signal vpn_tlb:std_logic_vector(17 downto 0);
signal ppnIn_tlb:std_logic_vector(7 downto 0);
signal ppnOut_tlb: std_logic_vector(7 downto 0);
signal read_tlb:std_logic:='0';
signal write_tlb: std_logic:='0';
signal hit_tlb:std_logic:='0';

type state_type is (s0,s1,s2,s3,s31,s32,s33,s4,s5);
signal state :state_type;
begin
tlb_portMap: TLB port map(clk,read_tlb,write_tlb,vpn_tlb,ppnIn_tlb,ppnOut_tlb,hit_tlb);

process(clk)
begin
if en='0' then 
    state<=s0;
    read_tlb<='0';
    write_tlb<='0';
    else 
if falling_edge(clk) then 
  
   
 case state is
  when s0 =>
   write_tlb<='0';
   read_tlb<='0';
   if read='1' then
     state<=s1;
   end if;
   
  when s1 =>
   vpn_tlb<=address_in(29 downto 12);
   write_tlb<='0';
   read_tlb<='1';
   state<=s2;
   
  when s2 =>
   read_tlb<='0';
   if hit_tlb='1' then 
    state<=s4;
   else
    state<=s3;
   end if;   
  when s3 =>
     vpn<=address_in(29 downto 12);
     state<=s31;
     
  when s31 =>
    if interrupt='1' then
       state<=s32;
     else  
       state<=s5;
     end if;  
     
  when s32 =>   
     load<='1';
     state<=s33;   
     
  when s33 =>
     load<='0';
     state<=s3;
     
  when s4 =>
     address_out<= ppnOut_tlb & address_in(11 downto 0);
     state<=s0;    
     
  when s5 =>
     ppnIn_tlb<=ppn;
     address_out<= ppn & address_in(11 downto 0);     
     write_tlb<='1';
     state<=s0; 
     
  when others =>
     state<= s0; 
 end case;
 end if;
 end if;
 
end process;


end Behavioral;
