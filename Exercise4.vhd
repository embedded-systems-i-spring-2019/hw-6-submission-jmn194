----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 01:37:25 PM
-- Design Name: 
-- Module Name: Exercise4 - Behavioral
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

entity Exercise4 is
port ( X1, X2, clk : in std_logic;
       Z1, Z2 : out std_logic);
end Exercise4;

architecture Behavioral of Exercise4 is
    type state_type is (ST0, ST1, ST2);
    signal PS, NS : state_type;

begin
sync_proc: process(X1, X2, clk)
begin

if rising_edge(clk) then
    PS <= NS;
end if;
end process sync_proc;

comb_proc: process(PS, X1, X2)
begin
  z1 <= '0';
  z2 <= '0';
  case PS is
    when ST0 =>
      Z1 <= '0';
      if (X1 = '1') then
        NS <= ST1;
        Z2 <= '1';
      else
        NS <= ST2;
        Z2 <= '0';
      end if;
  
    when ST1 =>
      Z1 <= '1';
      if (X2 = '0') then
        NS <= ST2;
        Z2 <= '1';
      else
        NS <= ST0;
        Z2 <= '0';
      end if;
  
    when ST2 =>      
      Z1 <= '1';
      if (X1 = '0') then
        NS <= ST0;
        Z2 <= '1';
      else 
        NS <= ST1;
        Z2 <= '1';
      end if;
  
    when others =>
      Z1 <= '0';
      Z2 <= '0';
      NS <= ST0;
  end case;
end process comb_proc;
end Behavioral;
