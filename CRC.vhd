library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CRC is
	generic( 	crcBits: integer := 64;
	
				
				inputSize: integer := 8 );

	port(   clk:		in  std_logic;
			rst:		in  std_logic;
			g:			in  std_logic_vector( crcBits downto 0 );
			
			-- Use this for brevity
			message:	in  std_logic_vector( inputSize - 1	downto 0 );
			crcOut : 	out std_logic_vector( crcBits - 1 	downto 0 )

			-- Use this for an accurate schematic
--			message:	in  std_logic_vector( inputSize + crcBits - 1	downto 0 );
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
end CRC;

architecture Behavioral of CRC is
	-- Used to hold intermediate data during LFSR stages
	signal data : std_logic_vector( inputSize + crcBits - 1 downto 0 ) := ( others => '0' );
	
	-- Used to hold output of flip flops
	signal q : std_logic_vector( crcBits - 1 downto 0 );
begin
	-- Use this for brevity
	-- Data is now the message with crcBits zeros appended to the end
	data( inputSize + crcBits - 1 downto crcBits ) <= message;
	data( crcBits - 1 downto 0 ) <= ( others => '0' );

	-- LSFR Process
	--		Input comes into Flip-Flop 0
	--		Propagates in increasing order (i.e., 0 -> 1, 1 -> 2, etc.)
	--		Output from final Flip-Flop is XOR'd with incoming input into Flip-Flop 0
	--
	--		messageIndex keeps track of what input data to send
	--		Is reset during the reset phase
	--		Simulations should be no longer than clockPeriod * ( inputSize + crcBits ) 
	--			plus the length of the reset phase (should be just one clock period)
	CRC_process : process( clk, message )
		-- Goes through inputs from message
		variable messageIndex : integer := inputSize + crcBits - 1;
	begin
		if( rst = '1' ) then
			-- Use this for brevity
			q <= ( others => '0' );

			-- Use this for an accurate schematic
--			crc3 <= '0';
--			crc2 <= '0';
--			crc1 <= '0';
--			crc0 <= '0';

			messageIndex := inputSize + crcBits - 1;
		elsif( rising_edge( clk ) and messageIndex >= 0 ) then
		
			-- Use this for brevity
			for i in ( crcBits - 1 ) downto 1 loop
				q( i ) <= q( i - 1 ) xor ( q( crcBits - 1 ) and g( i ) );
			end loop;
			q( 0 ) <= data( messageIndex ) xor( q( crcBits - 1 ) and g( 0 ) );

			-- Use this for an accurate schematic
--			crc3 <= crcbit2 xor( crc3 and g( 3 ) );
--			crc2 <= crc1 xor( crc3 and g( 2 ) );
--			crc1 <= crc0 xor( crc3 and g( 1 ) );
--			crc0 <= message( messageIndex ) xor( crc3 and g( 0 ) );
			
			-- Move to next input bit
			messageIndex := messageIndex - 1;
		end if;
	end process;

	-- Use this for brevity
	crcOut <= q;
end Behavioral;
