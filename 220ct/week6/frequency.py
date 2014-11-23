import sys
import re

words = {}

if __name__ == '__main__':
    with open(sys.argv[1]) as f:
        filtered = filter(lambda c: c.isalpha() or c is " ", f.read().lower())
        w = ''.join(filtered).split(" ")

        for word in w:
            if word not in words:
                words[word] = 1
            else:
                words[word] += 1

        print(words)
