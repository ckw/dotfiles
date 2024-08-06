#! /usr/bin/env python3
import random
import argparse

# Read words from the file
with open('/usr/share/dict/words', 'r') as file:
    word_list = file.read().splitlines()

# Filter words to be shorter than 8 characters and not start with a capital letter
filtered_words = [word for word in word_list if len(word) < 6 and word.islower()]

def generate_password():
    return '-'.join(random.sample(filtered_words, 5))

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description='Generate passwords from random English words.')
    parser.add_argument('count', type=int, nargs='?', default=1, help='Number of passwords to generate')

    # Parse the arguments
    args = parser.parse_args()

    # Generate and print the passwords
    for _ in range(args.count):
        print(generate_password())

if __name__ == '__main__':
    main()
