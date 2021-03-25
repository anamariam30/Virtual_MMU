----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2020 22:31:20
-- Design Name: 
-- Module Name: unit - Behavioral
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

entity unit is
 Port ( clk : in STD_LOGIC;
           read: in STD_LOGIC;
           en : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (29 downto 0);
           address_out : out STD_LOGIC_VECTOR (19 downto 0)
           );
end unit;

architecture Behavioral of unit is

component disk is
  Port (clk:in std_logic;
        address: in std_logic_vector(17 downto 0);
        load_memory: in std_logic; -- page table  interrupt
        address_i: in std_logic_vector(17 downto 0);-- echivalent cu count.
        page: out std_logic_vector(39 downto 0);
        update:in std_logic; -- load_disk
        modified_page: in std_logic_vector(39 downto 0)
        
   );
end component;

component Page_Table is
    Port ( clk:in std_logic;
           virtual_address : in STD_LOGIC_VECTOR (17 downto 0);
           physical_address: out STD_LOGIC_VECTOR (7 downto 0);
           memory_adress:in std_logic_vector(7 downto 0);
           load: in std_logic;
           count: out std_logic_vector(17 downto 0);
           --load_address: in std_logic_vector(7 downto 0);
           interrupt: out std_logic;
           modified:out std_logic;
           main_modified: in std_logic
           );
end component;


component MainMemory is
 Port (clk:in std_logic;
       write:in std_logic;
       writing_address:out std_logic_vector(7 downto 0);
       page_in: in std_logic_vector(39 downto 0);
       page_out:out std_logic_vector(39 downto 0); -- pagina pe care o scriu pe disk
       full: out std_logic;
       main_modified: out std_logic
        );
end component;

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

signal vpn:std_logic_vector(17 downto 0);
signal ppn:std_logic_vector(7 downto 0);

signal writeMemory: std_logic:='0';
signal writing_address: std_logic_vector(7 downto 0);
signal page_in:std_logic_vector(39 downto 0);
signal page_out:std_logic_vector(39 downto 0); -- pagina pe care o scriu pe disk

signal load_to_disk:std_logic:='0';
signal load_from_disk:std_logic:='0';
signal update_pageTable:std_logic:='0';
signal interrupt:std_logic:='0';
signal modified:std_logic:='0';
signal full:std_logic:='0';
signal main_modified: std_logic:='0';
type state_type is (s0,s1,s2,s3,s31,s32,s33,s34,s35,s36,s4,s5);
signal state :state_type;
signal count: std_logic_vector(17 downto 0); -- adresa virtuala a pagini fizice
begin
tlb_portMap: TLB port map(clk,read_tlb,write_tlb,vpn_tlb,ppnIn_tlb,ppnOut_tlb,hit_tlb);
pageTable: Page_Table port map(clk,vpn,ppn,writing_address,update_pageTable,count,interrupt,modified,main_modified);
MM: MainMemory port map(clk,writeMemory,writing_address,page_in,page_out,full,main_modified);
D: disk port map (clk,vpn,load_from_disk,count,page_in,load_to_disk,page_out);
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
   
  when s1 => -- citeste tlb
   vpn_tlb<=address_in(29 downto 12);
   write_tlb<='0';
   read_tlb<='1';
   state<=s2;
   
  when s2 => -- verifica daca e in tlb
   read_tlb<='0';
   if hit_tlb='1' then 
    state<=s4;
   else
    state<=s3;
   end if;   
  when s3 => -- nu am hit 
     vpn<=address_in(29 downto 12);
     state<=s31;
     
  when s31 => -- verific daca ein memoria princip
    if interrupt='1' then
       state<=s32;
     else  
       state<=s5;
     end if;  
     
  when s32 =>  
     update_pageTable<='1';
     load_from_disk<='1';
     writeMemory<='1';  
     if full='0' then
     state<=s35; 
     else 
     state<=s33;
     end if;  
     
  when s33 =>--  e full
     update_pageTable<='0';
     load_from_disk<='0';
     writeMemory<='0';
     state<=s34;
     
  
  when s34 =>
  load_from_disk<='0';   
  if modified='1' then
     load_to_disk<='1';
  end if; 
  state<=s36;
  
  when s36 =>
  state<=s3;
  when s35 => -- e full 
   update_pageTable<='0';
   load_from_disk<='0';
   writeMemory<='0';  
   state<=s3;
  
  when s4 => -- am hit in tlb
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
