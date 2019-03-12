----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 12:30:52 PM
-- Design Name: 
-- Module Name: Exercise2 - Behavioral
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

entity Exercise2 is
port ( X1, X2, clk : in std_logic;
       Z : out std_logic;
       Y : out std_logic_vector(1 downto 0));
end Exercise2;

architecture Behavioral of Exercise2 is
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
  z <= '0';
  case PS is
  
    when ST0 =>
      if (X1 = '1') then
        NS <= ST2;
        Z <= '0';
      else
        NS <= ST0;
        Z <= '0';
      end if;
      
    when ST1 =>
      if (X2 = '0') then
        NS <= ST0;
        Z <= '1';
      else
        NS <= ST1;
        Z <= '0';
      end if;
      
    when ST2 =>
      if (X2 = '1') then
        NS <= ST1;
        Z <= '0';
      else 
        NS <= ST0;
        Z <= '1';
      end if;
      
    when others =>
    Z <= '0';
    NS <= ST0;
    end case;
end process comb_proc;

with PS select
  Y <= "10" when ST0,
       "11" when ST1,
       "01" when ST2,
       "10" when others;


end Behavioral;
