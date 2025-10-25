import random
import string
import time

def brute_force_attack(target_password):
    print("Starting brute-force attack...\n")
    characters = string.ascii_letters + string.digits
    attempts = 0
    guess = ''
    while guess != target_password:
        guess = ''.join(random.choices(characters, k=len(target_password)))
        attempts += 1
        print(f"Attempt {attempts}: {guess}")
        time.sleep(0.1)
    print(f"\nPassword found: {guess} in {attempts} attempts!\n")


def hid_attack_simulation(payload):
    print("Starting HID attack simulation...\n")
    print("Simulating keystroke injection:")
    for char in payload:
        print(char, end='', flush=True)
        time.sleep(0.1)
    print("\nPayload delivered!\n")


def main():
    print("Welcome to the Hacking Game!")
    print("Choose your attack:\n1. Brute-force\n2. HID Attack Simulation")
    choice = input("Enter 1 or 2: ")

    if choice == '1':
        target_password = input("Set a password for brute-force attack (e.g., abc123): ")
        brute_force_attack(target_password)
    elif choice == '2':
        payload = input("Enter the payload to inject (e.g., rm -rf /): ")
        hid_attack_simulation(payload)
    else:
        print("Invalid selection. Exiting.")


if __name__ == "__main__":
    main()