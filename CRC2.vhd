library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CRC2 is
	generic( 	crcBits: integer := 8;
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
--			crcbit2:		inout std_logic;
--			crc3:		inout std_logic 
		);
end CRC2;

architecture Behavioral of CRC2 is
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
--			crcbit2 <= '0';
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
--			crcbit2 <= crc1 xor( crc3 and g( 2 ) );
--			crc1 <= crc0 xor( crc3 and g( 1 ) );
--			crc0 <= message( messageIndex ) xor( crc3 and g( 0 ) );
			
			-- Move to next input bit
			messageIndex := messageIndex - 1;
		end if;
	end process;

	-- Use this for brevity
	crcOut <= q;
end Behavioral;
