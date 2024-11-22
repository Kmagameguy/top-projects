#  A  B  C  D  E  F  G  H  I   J   K   L   M   N
#  1  2  3  4  5  6  7  8  9  10  11  12  13  14  

#  O   P   Q   R   S   T   U   V   W   X   Y   Z   
# 15  16  17  18  19  20  21  22  23  24  25  26 =>

# Need to:
# Take text input and convert it to an array of characters
# Map each character to its position in the alphabet (ignoring special characters)
# Add the offset to each character (and wrap if above 26)
# Map each number back to its corresponding character
# Join back into a string
# Keep the casing consistent

def caesar_cipher(text, offset)
  puts text; puts offset
end

caesar_cipher('What a string!', 5)
