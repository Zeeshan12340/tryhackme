import random

# List of passwords
passwords = [
    "TheReserve", "thereserve", "Reserve", "reserve",
    "CorpTheReserve", "corpthereserve", "Password", "password",
    "TheReserveBank", "thereservebank", "ReserveBank", "reservebank"
]

# Special characters to append
special_chars = "!@#$%^"

# Function to generate a password with a number and a special character
def generate_password(password):
    # Append a random number and a random special character
    password += str(random.randint(0, 9)) + random.choice(special_chars)
    return password

# Generate passwords
generated_passwords = []
for password in passwords:
    # Ensure the password is between 8 and 10 characters
    while len(password) > 14:
        password = generate_password(password)
    generated_passwords.append(password)

# Print the generated passwords
with open("passwords.txt","w") as w:
    for password in generated_passwords:
        w.write(password + "\n")

