library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CRC is
	generic( 	crcBits: integer := 16;
	
				inputSize: integer := 8 );

	port(   clk:		in  std_logic;
			rst:		in  std_logic;
			init:		in  std_logic_vector( crcBits - 1 downto 0 );
			finalXOR:	in  std_logic_vector( crcBits - 1 downto 0 );
			g:			in  std_logic_vector( crcBits - 1 downto 0 );
			
			-- Use this for brevity
			message:	in  std_logic_vector( inputSize - 1	downto 0 );
			q:			inout std_logic_vector( crcBits - 1 downto 0 );
			crcOut : 	out std_logic_vector( crcBits - 1 	downto 0 )

			-- Use this for an accurate schematic
--			message:	in  std_logic_vector( inputSize + crcBits - 1	downto 0 );
--			crc0:		inout std_logic;
--			crc1:		inout std_logic;
--			crc2:		inout std_logic;
--			crc3:		inout std_logic
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
	-- Holds initial value, then message, then crcBits zeros
	signal data : std_logic_vector( inputSize + crcBits - 1 downto 0 ) := ( others => '0' );
	
	-- Used to hold output of flip flops
--	signal q : std_logic_vector( crcBits - 1 downto 0 );
begin
	-- Use this for brevity
	data <= message & ( crcBits - 1 downto 0 => '0' );

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
			if( rising_edge( clk ) ) then
--				q <= data( inputSize + crcBits - 1 downto inputSize ) xor init;
				q <= ( others => '0' );
--				q <= init;
			end if;
			
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
--			q( 0 ) <= data( messageIndex ) xor ( q( crcBits - 1 ) and g( 0 ) );
			
			if( messageIndex > ( inputSize - 1 ) ) then
				q( 0 ) <= ( data( messageIndex ) xor init( messageIndex - inputSize ) ) xor ( q( crcBits - 1 ) and g( 0 ) );
			else
				q( 0 ) <= data( messageIndex ) xor ( q( crcBits - 1 ) and g( 0 ) );
			end if;		
			report "data( " & integer'image( messageIndex ) & " ) = " & std_logic'image( data( messageIndex ) );

			-- Use this for an accurate schematic
--			crc63 <= crc62 xor( crc63 and g( 63 ) );
--			crc62 <= crc61 xor( crc63 and g( 62 ) );
--			crc61 <= crc60 xor( crc63 and g( 61 ) );
--			crc60 <= crc59 xor( crc63 and g( 60 ) );
--			crc59 <= crc58 xor( crc63 and g( 59 ) );
--			crc58 <= crc57 xor( crc63 and g( 58 ) );
--			crc57 <= crc56 xor( crc63 and g( 57 ) );
--			crc56 <= crc55 xor( crc63 and g( 56 ) );
--			crc55 <= crc54 xor( crc63 and g( 55 ) );
--			crc54 <= crc53 xor( crc63 and g( 54 ) );
--			crc53 <= crc52 xor( crc63 and g( 53 ) );
--			crc52 <= crc51 xor( crc63 and g( 52 ) );
--			crc51 <= crc50 xor( crc63 and g( 51 ) );
--			crc50 <= crc49 xor( crc63 and g( 50 ) );
--			crc49 <= crc48 xor( crc63 and g( 49 ) );
--			crc48 <= crc47 xor( crc63 and g( 48 ) );
--			crc47 <= crc46 xor( crc63 and g( 47 ) );
--			crc46 <= crc45 xor( crc63 and g( 46 ) );
--			crc45 <= crc44 xor( crc63 and g( 45 ) );
--			crc44 <= crc43 xor( crc63 and g( 44 ) );
--			crc43 <= crc42 xor( crc63 and g( 43 ) );
--			crc42 <= crc41 xor( crc63 and g( 42 ) );
--			crc41 <= crc40 xor( crc63 and g( 41 ) );
--			crc40 <= crc39 xor( crc63 and g( 40 ) );
--			crc39 <= crc38 xor( crc63 and g( 39 ) );
--			crc38 <= crc37 xor( crc63 and g( 38 ) );
--			crc37 <= crc36 xor( crc63 and g( 37 ) );
--			crc36 <= crc35 xor( crc63 and g( 36 ) );
--			crc35 <= crc34 xor( crc63 and g( 35 ) );
--			crc34 <= crc33 xor( crc63 and g( 34 ) );
--			crc33 <= crc32 xor( crc63 and g( 33 ) );
--			crc32 <= crc31 xor( crc63 and g( 32 ) );
--			crc31 <= crc30 xor( crc63 and g( 31 ) );
--			crc30 <= crc29 xor( crc63 and g( 30 ) );
--			crc29 <= crc28 xor( crc63 and g( 29 ) );
--			crc28 <= crc27 xor( crc63 and g( 28 ) );
--			crc27 <= crc26 xor( crc63 and g( 27 ) );
--			crc26 <= crc25 xor( crc63 and g( 26 ) );
--			crc25 <= crc24 xor( crc63 and g( 25 ) );
--			crc24 <= crc23 xor( crc63 and g( 24 ) );
--			crc23 <= crc22 xor( crc63 and g( 23 ) );
--			crc22 <= crc21 xor( crc63 and g( 22 ) );
--			crc21 <= crc20 xor( crc63 and g( 21 ) );
--			crc20 <= crc19 xor( crc63 and g( 20 ) );
--			crc19 <= crc18 xor( crc63 and g( 19 ) );
--			crc18 <= crc17 xor( crc63 and g( 18 ) );
--			crc17 <= crc16 xor( crc63 and g( 17 ) );
--			crc16 <= crc15 xor( crc63 and g( 16 ) );
--			crc15 <= crc14 xor( crc63 and g( 15 ) );
--			crc14 <= crc13 xor( crc63 and g( 14 ) );
--			crc13 <= crc12 xor( crc63 and g( 13 ) );
--			crc12 <= crc11 xor( crc63 and g( 12 ) );
--			crc11 <= crc10 xor( crc63 and g( 11 ) );
--			crc10 <= crc9 xor( crc63 and g( 10 ) );
--			crc9 <= crc8 xor( crc63 and g( 9 ) );
--			crc8 <= crc7 xor( crc63 and g( 8 ) );
--			crc7 <= crc6 xor( crc63 and g( 7 ) );
--			crc6 <= crc5 xor( crc63 and g( 6 ) );
--			crc5 <= crc4 xor( crc63 and g( 5 ) );
--			crc4 <= crc3 xor( crc63 and g( 4 ) );
--			crc3 <= crc2 xor( crc3 and g( 3 ) );
--			crc2 <= crc1 xor( crc3 and g( 2 ) );
--			crc1 <= crc0 xor( crc3 and g( 1 ) );
--			crc0 <= message( messageIndex ) xor( crc3 and g( 0 ) );
			
			-- Move to next input bit
			messageIndex := messageIndex - 1;
		end if;
	end process;

	-- Use this for brevity
	crcOut <= q xor finalXOR;
end Behavioral;
