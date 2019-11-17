library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CRC2_tb is
end CRC2_tb;

architecture Behavioral of CRC2_tb is
	constant clockPeriod : time := 100ns;
	constant inputSize : integer := 8;
	constant crcBits : integer := 8;
	
	component CRC2 is
		generic( 	crcBits: integer := crcBits;
                    inputSize: integer := inputSize );
    
        port(   clk:		in  std_logic;
        		rst:		in  std_logic;
				g:			in  std_logic_vector( crcBits downto 0 );
			
				-- Use this for brevity
				message:	in  std_logic_vector( inputSize - 1	downto 0 );
				crcOut:		out std_logic_vector( crcBits - 1 downto 0 )
			
				-- Use this for an accurate schematic
--				message:	in  std_logic_vector( inputSize + crcBits - 1 downto 0 );
--				crc0:		inout std_logic;
--				crc1:		inout std_logic;
--				crcbit2:	inout std_logic;
--				crc3:		inout std_logic 
			);
    end component CRC2;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal g : std_logic_vector( crcBits downto 0 ) := "110100111";
	
	-- Used for brevity
	signal message : std_logic_vector( inputSize - 1 downto 0 ) := "11000011";
	signal crcOut : std_logic_vector( crcBits - 1 downto 0 );
	
	-- Used for an accurate schematic
--	signal message : std_logic_vector( inputSize + crcBits - 1 downto 0 ) := "110011010000";
--	signal crc0 : std_logic;
--	signal crc1 : std_logic;
--	signal crcbit2 : std_logic;
--	signal crc3 : std_logic;
	

begin
	-- Set Flip-Flops initially to 0
	rst <= '0' after clockPeriod;
	
	-- Create pulsing clock signal with 50% duty cycle (DC doesn't matter, just pulse it)
    clk <= not( clk ) after ( clockPeriod / 2 );

	DUT: CRC2
		port map( 	clk 	=> clk,
					rst 	=> rst,
					g 		=> g,
					message => message,
					
					-- Used for brevity
					crcOut 	=> crcOut
					
					-- Used for an accurate schematic
--					crc0 => crc0,
--					crc1 => crc1,
--					crcbit2 => crcbit2,
--					crc3 => crc3
				);
end Behavioral;
