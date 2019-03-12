----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 02:16:06 PM
-- Design Name: 
-- Module Name: Exercise13 - Behavioral
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

entity Exercise13 is
port ( X1, X2, clk : in std_logic;
       CS, RD : out std_logic;
       Y : out std_logic_vector(2 downto 0));
end Exercise13;

architecture Behavioral of Exercise13 is
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
  CS <= '0';
  RD <= '0';
  case PS is
  
    when ST0 =>
      --Z1 <= '1';
      if (X1 = '0') then
        NS <= ST1;
        CS <= '0';
        RD <= '1';
      else
        NS <= ST2;
        CS <= '1';
        RD <= '0';
      end if;
      
    when ST1 =>
      --Z1 <= '0';     
        NS <= ST2;
        CS <= '1';
        RD <= '1';
        
    when ST2 =>
      --Z1 <= '1';
      if (X2 = '0') then
        NS <= ST0;
        CS <= '0';
        RD <= '0';
      else
        NS <= ST2;
        CS <= '0';
        RD <= '0';
      end if;
      
      
    when others =>
      CS <= '0';
      RD <= '0';
      NS <= ST0;
    end case;
end process comb_proc;

with PS select
  Y <= "001" when ST0,
       "010" when ST1,
       "100" when ST2,
       "001" when others;


end Behavioral;
