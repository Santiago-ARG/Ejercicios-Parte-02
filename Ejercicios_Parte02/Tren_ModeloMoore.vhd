----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:55 01/02/2022 
-- Design Name: 
-- Module Name:    Tren_ModeloMoore - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

entity Tren_ModeloMoore is
	port (tiempo, sensor, clk, Sp: in std_logic;
		PA, PC, PARO, AVANCE: out std_logic;
		Q1, Q0: inout std_logic;
end Tren_ModeloMoore;

architecture Behavioral of Tren_ModeloMoore is
	type estados is (A, B, C, D);
	signal edo_pres, edo_fut: estados;
begin
	p_estados: process (edo_pres, tiempo, sensor)
begin
	case edo_pres is
	when A => PA <= '1' : PC <= '0'; PARO <= '0'; AVANCE <= '0'; Q1 <= '0'; Q0 <= '0';
		if TIEMPO = '1' then
			edo_fut <= B;
		else
			edo_fut <= A;
		end if;
	
	when B => PA <= '0' : PC <= '1'; PARO <= '0'; AVANCE <= '0'; Q1 <= '0'; Q0 <= '1';
		if SP = '1' then
			edo_fut <= C;
		else
			edo_fut <= B;
		end if;
	
	when C => PA <= '0' : PC <= '0'; PARO <= '0'; AVANCE <= '1'; Q1 <= '1'; Q0 <= '0';
		if SENSOR = '1' then
			edo_fut <= D;
		else
			edo_fut <= C;
		end if;
		
	when D => PA <= '0' : PC <= '0'; PARO <= '1'; AVANCE <= '0'; Q1 <= '1'; Q0 <= '1';
		edo_fut <= A;
	end case;
	end process p_estados;
	
	--Inicia Segundo Proceso
	p_relog: process (clk) begin
		if (clk' event and clk = '1') then
			edo_pres <= edo_fut;
		end if;
		end process p_reloj;

end Behavioral;

