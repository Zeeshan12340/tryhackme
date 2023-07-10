			Hashes:						Encryption:								Cracked Hash:
1)		c4n y0u c4p7u23 7h3 f149?		Simple alpha-numeric substitution	can you capture the flag?
		
2)		"01101100 01100101 01110100 	Binary to ASCII Encryption 			lets try some binary out!
		01110011 00100000 01110100 
		01110010 01111001 00100000 
		01110011 01101111 01101101 
		01100101 00100000 01100010 
		01101001 01101110 01100001 
		01110010 01111001 00100000 
		01101111 01110101 01110100 
		00100001"

3)		"MJQXGZJTGIQGS4ZAON2XAZLSE			Base32 Encryption					base32 is super common in CTF's
		BRW63LNN5XCA2LOEBBVIRRHOM======"

4)		"RWFjaCBCYXNlNjQgZGlnaXQgcmVwcmV	Base64 Encryption				Each Base64 digit represents exactly 6 bits of data.
		 zZW50cyBleGFjdGx5IDYgYml0cyBvZi
		 BkYXRhLg=="

5)		"68 65 78 61 64 65 63 69 6d 61 6c	Hex to ASCII					hexadecimal or base16?
		 20 6f 72 20 62 61 73 65 31 36 3f"

6)		Ebgngr zr 13 cynprf!				ROT13							Rotate me 13 places!

7)		*@F DA:? >6 C:89E C@F?5 323J C:89E  ROT47							You spin me right round baby right round (47 times)
		 C@F?5 Wcf E:>6DX

8)		"- . .-.. . -.-. --- -- -- ..- -. 	Morse Code						TELECOMMUNICATIONENCODING
		.. -.-. .- - .. --- -.. -. -.-. 
		--- -.. .. -. --."

9)		"85 110 112 97 99 107 32 116 104 	Decimal to ASCII				Unpack this BCD
		105 115 32 66 67 68"

10)		can't show hash, too big, sorry
		
		Decoded hash using base64, which gave a Morse code hash, which gave a binary hash, which gave ROT47(where I gave up) hash, which gave a decimal to ASCII hash with the result 'Let's make this a bit trickier...' \\MF, you already did it. 
