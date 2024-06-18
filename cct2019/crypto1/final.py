from Crypto.Util.number import long_to_bytes

enc = "11122112141311112123131222211121621211124112213221112162112113114163113211421121132221622222411321311331611221121413111121231312222111216322121412123312222111122141624112123212416214122231631132114221112162321321242113531132142162321211424112123212322111121322231221111322216222232122141212112163113211422111216231224113221211211232216231224113113232121151124162312311111311416311321142211113212221112162411321222111216212111214132122211121623212114241121232123221111213222312211113222162411211422111124112214113316121421413132163131211211212321241642112141311112162222241132122211121624112231241121121121323221311416311321142141322122111216121212163131214121322213221111321311331615113114162411213242121632122411311322111211241631312211112123212416221321412132221112162411213222141621142211113212221112162112113222164211214131111132131622222123241122323113161421142111111341211212111151322122111122111111512213221111241122131151232121121135211422111132123221115124112123212311513113211422111111513113211211212111221111511"

result = ""

for i in range(len(enc)):               # Looping through the big number, this is the reason I made it a
                                        # string, since it's easier to iterate over it this way.
    binary = '0' if i % 2 == 0 else '1' # Now the cool stuff starts! here I used a one liner to check
                                        # if the i (the index) is odd or even, this determines if our
                                        # binary number will be a 1 or a 0.
    result+=binary*int(enc[i])          # Now for the end, we append the binary number
                                        # to the string n times (n being our number)

flag = long_to_bytes(int(result, 2)).decode("ASCII") 
print(flag)