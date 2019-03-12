----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 02:03:19 PM
-- Design Name: 
-- Module Name: Exercise6 - Behavioral
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

entity Exercise6 is
port ( X, clk : in std_logic;
       Z1, Z2 : out std_logic;
       Y : out std_logic_vector(1 downto 0));
end Exercise6;

architecture Behavioral of Exercise6 is
    type state_type is (ST0, ST1, ST2, ST3);
    signal PS, NS : state_type;

begin
sync_proc: process(X, clk)
begin
  if rising_edge(clk) then
    PS <= NS;
  end if;
end process sync_proc;

comb_proc: process(PS, X)
begin
  Z1 <= '0';
  case PS is
  
    when ST0 =>
      Z1 <= '1';
      if (X = '1') then
        NS <= ST0;
        Z2 <= '1';
      else
        NS <= ST2;
        Z2 <= '0';
      end if;
      
    when ST1 =>
      Z1 <= '0';     
      if (X = '1') then
        NS <= ST1;
        Z2 <= '0';
      else 
        NS <= ST3;
        Z2 <= '0';
      end if;
    
    when ST2 =>
      Z1 <= '1';
      if (X = '1') then
        NS <= ST0;
        Z2 <= '0';
      else
        NS <= ST1;
        Z2 <= '0';
      end if;
      
    when ST3 =>
      Z1 <= '0';
      if (X = '0') then
        NS <= ST0;
        Z2 <= '1';
      else 
        NS <= ST1;
        Z2 <= '0';
      end if;
      
    when others =>
      Z1 <= '0';
      Z2 <= '0';
      NS <= ST0;
    end case;
end process comb_proc;

with PS select
  Y <= "00" when ST0,
       "01" when ST1,
       "10" when ST2,
       "11" when ST3,
       "00" when others;


end Behavioral;
