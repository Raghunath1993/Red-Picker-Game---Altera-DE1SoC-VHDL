library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity VGA IS
Port(CLOCK_24:IN STD_LOGIC;
VGA_SYNC_N,VGA_BLANK_N: OUT STD_LOGIC;
VGA_CLK: OUT STD_LOGIC;
VGA_HS,VGA_VS:OUT STD_LOGIC;
VGA_R,VGA_G,VGA_B:OUT STD_LOGIC_VECTOR(7 downto 0);
SWITCH: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
LED0: OUT STD_LOGIC
);
END VGA;

ARCHITECTURE MAIN OF VGA IS
SIGNAL VGA_CLK2,RESET: STD_LOGIC:='0';
---------------------------------------------------------------------------------------------------
    component main_pll is
        port (
            clk_in_clk  : in  std_logic := 'X'; -- clk
            reset_reset : in  std_logic := 'X'; -- reset
            clk_out_clk : out std_logic         -- clk
        );
    end component main_pll;


COMPONENT SYNC IS
PORT
(
CLK:IN STD_LOGIC;
HSYNC,VSYNC:OUT STD_LOGIC;
R,G,B:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
SWITCH: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
LED0: OUT STD_LOGIC
);
END COMPONENT SYNC;

BEGIN

C1 : SYNC PORT MAP (VGA_CLK2,VGA_HS,VGA_VS,VGA_R,VGA_G,VGA_B,SWITCH,LED0);
C2 : main_pll PORT MAP(CLOCK_24,RESET,VGA_CLK2);
VGA_SYNC_N <='1';
VGA_BLANK_N <='1';
VGA_CLK<=vga_CLK2;

END MAIN;

 
