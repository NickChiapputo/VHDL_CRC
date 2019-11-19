library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CRC_tb is
end CRC_tb;

architecture Behavioral of CRC_tb is
	constant inputSize : integer := 8;
	constant crcBits : integer := 8;
	
	-- Takes input size + crcBits time periods to calculate CRC and one extra period for the reset
	-- Total simulation time is set at xxx ns, minimum clock period (assuming maximum 64-bit message and 64-bit CRC) is 10 ns
	constant clockPeriod : time := ( 1290 ns ) / ( inputSize + crcBits + 2 );
	
	component CRC is
		generic( 	crcBits: integer := crcBits;
                    inputSize: integer := inputSize );
    
        port(   clk:		in  std_logic;
        		rst:		in  std_logic;
        		init:		in  std_logic_vector( crcBits - 1 downto 0 );
				finalXOR:	in  std_logic_vector( crcBits - 1 downto 0 );
				g:			in  std_logic_vector( crcBits - 1 downto 0 );
			
				-- Use this for brevity
				message:	in  std_logic_vector( inputSize - 1	downto 0 );
				q:			inout std_logic_vector( crcBits - 1 downto 0 );
				crcOut:		out std_logic_vector( crcBits - 1 downto 0 )
			
				-- Use this for an accurate schematic
--				message:	in  std_logic_vector( inputSize + crcBits - 1 downto 0 );
--			crc0:		inout std_logic;
--			crc1:		inout std_logic;
--			crc2:		inout std_logic;
--			crc3:		inout std_logic;
--			crc4:		inout std_logic;
--			crc5:		inout std_logic;
--			crc6:		inout std_logic;
--			crc7:		inout std_logic;
--			crc8:		inout std_logic;
--			crc9:		inout std_logic;
--			crc10:		inout std_logic;
--			crc11:		inout std_logic;
--			crc12:		inout std_logic;
--			crc13:		inout std_logic;
--			crc14:		inout std_logic;
--			crc15:		inout std_logic;
--			crc16:		inout std_logic;
--			crc17:		inout std_logic;
--			crc18:		inout std_logic;
--			crc19:		inout std_logic;
--			crc20:		inout std_logic;
--			crc21:		inout std_logic;
--			crc22:		inout std_logic;
--			crc23:		inout std_logic;
--			crc24:		inout std_logic;
--			crc25:		inout std_logic;
--			crc26:		inout std_logic;
--			crc27:		inout std_logic;
--			crc28:		inout std_logic;
--			crc29:		inout std_logic;
--			crc30:		inout std_logic;
--			crc31:		inout std_logic;
--			crc32:		inout std_logic;
--			crc33:		inout std_logic;
--			crc34:		inout std_logic;
--			crc35:		inout std_logic;
--			crc36:		inout std_logic;
--			crc37:		inout std_logic;
--			crc38:		inout std_logic;
--			crc39:		inout std_logic;
--			crc40:		inout std_logic;
--			crc41:		inout std_logic;
--			crc42:		inout std_logic;
--			crc43:		inout std_logic;
--			crc44:		inout std_logic;
--			crc45:		inout std_logic;
--			crc46:		inout std_logic;
--			crc47:		inout std_logic;
--			crc48:		inout std_logic;
--			crc49:		inout std_logic;
--			crc50:		inout std_logic;
--			crc51:		inout std_logic;
--			crc52:		inout std_logic;
--			crc53:		inout std_logic;
--			crc54:		inout std_logic;
--			crc55:		inout std_logic;
--			crc56:		inout std_logic;
--			crc57:		inout std_logic;
--			crc58:		inout std_logic;
--			crc59:		inout std_logic;
--			crc60:		inout std_logic;
--			crc61:		inout std_logic;
--			crc62:		inout std_logic;
--			crc63:		inout std_logic
			);
    end component CRC;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal q : std_logic_vector( crcBits - 1 downto 0 ) := ( others => '1' );

----------------------------------------------------------------------------------
------------------------------- Initial Remainder --------------------------------
	signal init : std_logic_vector( crcBits - 1 downto 0 ) := ( others =>
	
		-- Initialize to 0x0...0
--	'0'
	
		-- Initialize to 0xF...F
	'1'
);

	-- Custom initialization
--	signal init : std_logic_vector( crcBits - 1 downto 0 ) := "1111111111111111";

----------------------------------------------------------------------------------
----------------------------------- Final XOR ------------------------------------
	signal finalXOR : std_logic_vector( crcBits - 1 downto 0 ) := ( others =>
	
		-- XOR final output with 0x0...0
	'0'
	
		-- XOR final output with 0xF...F
--	'1'
);

	-- Custom XOR
--	signal finalXOR : std_logic_vector( crcBits - 1 downto 0 ) := "0000000000000001";

----------------------------------------------------------------------------------
------------------------------- Default Generators -------------------------------
	-- Definition of signal
	signal g : std_logic_vector( crcBits - 1 downto 0 ) :=

	-- Possible CRC generator functions	
	-- CRC-1 Parity Bit; Polynomial = 0x1; p(x) = x + 1
--	"1"

	-- CRC-3-GSM; Polynomial = 0x3; p(x) = x^3 + x + 1
--	"011"

	-- CRC-4-ITU; Polynomial = 0x3; p(x) = x^4 + x + 1
--	"0011"

	-- CRC-5-EPC; Polynomial = 0x09; p(x) = x^5 + x^3 + 1
--	"01001"

	-- CRC-5-ITU; Polynomial = 0x15; p(x) = x^5 + x^4 + x^2 + 1
--	"10101"

	-- CRC-5-USB; Polynomial = 0x05; p(x) = x^5 + x^2 + 1
--	"00101"

	-- CRC-6-GSM; Polynomial = 0x2F; p(x) = x^6 + x^5 + x^3 + x^2 + x + 1
--	"01111"

	-- CRC-6-ITU; Polynomial = 0x03; p(x) = x^6 + x + 1
--	"000011"

	-- CRC-7; Polynomial = 0x09; p(x) = x^7 + x^3 + 1
--	"0001001"

	-- CRC-8-AUTOSAR; Polynomial = 0x2F; p(x) = x^8 + x^5 + x^3 + x^2 + x + 1
--	"00101111"

	-- CRC-8-Bluetooth; Polynomial = 0xA7; p(x) = x^8 + z^7 + x^5 + x^2 + x + 1
--	"10100111"

	-- CRC-8-CCITT; Polynomial = 0x07; p(x) = x^8 + x^2 + x + 1
--	"00000111"

	-- CRC-8-Dallas/Maxim; Polynomial = 0x31; p(x) = x^8 + x^5 + x^4 + 1
--	"00110001"

	-- CRC-8-DARC; Polynomial = 0x39; p(x) = x^8 + x^5 + x^4 + x^3 + 1
--	"00111001"

	-- CRC-8-GSM-B; Polynomial = 0x49; p(x) = x^8 + x^6 + x^3 + 1
--	"01001001"

	-- CRC-8-SAEJ1850; Polynomial = 0x1D; p(x) = x^8 + x^4 + x^3 + x^2 + 1
--	"00011101"

	-- CRC-8-WCDMA; Polynomial = 0x9B; p(x) = x^8 + x^7 + x^4 + x^3 + x + 1
	"10011011"

	-- CRC-10; Polynomial = 0x233; p(x) = x^10 + x^9 + x^5 + x^4 + x + 1
--	"1000110011"

	-- CRC-11; Polynomial = 0x385; p(x) = x^11 + x^9 + x^8 + x^7 + x^2 + 1
--	"01110000101"

	-- CRC-12; Polynomial = 0x80F; p(x) = x^12 + x^11 + x^3 + x^2 + x + 1
--	"100000001111"

	-- CRC-13-BBC; Polynomial = 0x1CF5; p(x) = x^13 + x^12 + x^11 + x^10 + x^7 + x^6 + x^5 + x^4 + x^2 + 1
--	"1110011110101"

	-- CRC-15-CAN; Polynomial = 0x4599; p(x) = x^15 + x^14 + x^10 + x^8 + x^7 + x^4 + x^3 + 1
--	"100010110011001"

	-- CRC-16-CCITT; Polynomial = 0x1021; p(x) = x^16 + x^12 + x^5 + 1
--	"0001000000100001"

	-- CRC-16-DECT; Polynomial = 0x0589; p(x) = x^16 + x^10 + x^8 + x^7 + x^3 + 1
--	"0000010110001001"

	-- CRC-16-T10-DIF; Polynomial = 0x8BB7; p(x) = x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
--	"1000101110110111"

	-- CRC-16-DNP; Polynomial = 0x3D65; p(x) = x^16 + x^13 + x^12 + x^11 + x^10 + x^8 + x^6 + x^5 + x^2 + 1
--	"0011110101100101"

	-- CRC-16-IBM; Polynomial = 0x8005; p(x) = x^16 + x^15 + x^2 + 1
--	"1000000000000101"

	-- CRC-24; Polynomial = 0x5D6DCB; p(x) = x^24 + x^22 + x^20 + x^19 + x^18 + x^16 + x^14 + x^13 + x^11 + x^10 + x^8 + x^7 + x^6 + x^3 + x + 1
--	"010111010110110111001011"

	-- CRC-24-Radix-64; Polynomial = 0x864CFB; p(x) = x^24 + x^23 + x^18 + x^17 + x^14 + x^11 + x^10 + x^7 + x^6 + x^5 + x^4 + x^3 + x + 1
--	"100001100100110011111011"

	-- CRC-24-WCDMA; Polynomial = 0x800063; p(x) = x^24 + x^23 + x^6 + x^5 + x + 1
--	"100000000000000001100011"

	-- CRC-30; Polynomial = 0x2030B9C7; p(x) = x^30 + x^29 + x^21 + x^20 + x^15 + x^13 + x^12 + x^11 + x^8 + x^7 + x^6 + x^2 + x + 1
--	"100000001100001011100111000111"

	-- CRC-32; Polynomial = 0x04C11DB7; p(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
--	"00000100110000010001110110110111"

	-- CRC-32C; Polynomial = 0x1EDC6F41; p(x) = x^32 + x^28 + x^27 + x^26 + x^20 + x^19 + x^17 + x^16 + x^15 + x^11 + x^10 + x^7 + x^6 + x^4 + x^2 + x + 1
--	"00011100000110111000110011010111"

	-- CRC-32K; Polynomial = 0x742B8CD7; p(x) = x^32 + x^30 + x^29 + x^28 + x^26 + x^20 + x^19 + x^17 + x^16 + x^15 + x^11 + x^10 + x^7 + x^6 + x^4 + x^2 + x + 1
--	"01110100000110111000110011010111"

	-- CRC-32Q; Polynomial = 0x814141AB; p(x) = x^32 + x^31 + x^24 + x^22 + x^16 + x^14 + x^8 + x^7 + x^5 + x^3 + x + 1
--	"10000001010000010100000110101011"

	-- CRC-40-GSM; Polynomial = 0x0004820009; p(x) = x^40 + x^26 + x^23 + x^17 + x^3 + 1
--	"0000000000000100100000100000000000001001"

	-- CRC-64-ECMA; Polynomial = 0x42F0E1EBA9EA3693; p(x) = x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 + x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 + x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 + x^7 + x^4 + x + 1
--	"0100001011110000111000011110101110101001111010100011011010010011"

	-- CRC-64-ISO; Polynomial = 0x000000000000001B; p(x) = x^64 + x^4 + x^3 + x + 1
--	"0000000000000000000000000000000000000000000000000000000000011011"
--
;
----------------------------------------------------------------------------------
-------------------------------- Default Messages --------------------------------
-------- Note that reflections need to be done before the CRC calculation --------
	-- Used for brevity
		-- 8-bit message
	signal message : std_logic_vector( inputSize - 1 downto 0 ) := "11000011";

		-- 64-bit message
--	signal message : std_logic_vector( inputSize - 1 downto 0 ) := "1110101001010101000011100100101001111111101100110111110001000101";
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
	signal crcOut : std_logic_vector( crcBits - 1 downto 0 );
	
	-- Used for an accurate schematic
--	signal message : std_logic_vector( inputSize + crcBits - 1 downto 0 ) := "110011010000";
--	signal crc0 : std_logic;
--	signal crc1 : std_logic;
--	signal crc2 : std_logic;
--	signal crc3 : std_logic;

begin
	-- Set Flip-Flops initially to 0
	rst <= '0' after clockPeriod;
	
	-- Create pulsing clock signal with 50% duty cycle (DC doesn't matter, just pulse it)
    clk <= not( clk ) after ( clockPeriod / 2 );

	DUT: CRC
		port map( 	clk 		=> clk,
					rst 		=> rst,
					init		=> init,
					finalXOR 	=> finalXOR,
					g 			=> g,
					message 	=> message,
					
					-- Used for brevity
					q => q,
					crcOut 	=> crcOut
					
					-- Used for an accurate schematic
--					crc0 => crc0,
--					crc1 => crc1,
--					crc2 => crc2,
--					crc3 => crc3
				);
end Behavioral;
