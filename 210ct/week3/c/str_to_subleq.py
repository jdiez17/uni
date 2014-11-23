import sys

if __name__ == '__main__':
    seq = sys.argv[1]
    ascii_codepoints = [ord(c) for c in seq]

    subleq = []

    i = 1
    for cp in ascii_codepoints:
        subleq.extend([
            (i + 1) * 3, -1, (i + 2) * 3, # Print character
            0, 0, (i + 2) * 3,            # Jump
            cp, 0, 0                      # Character data
        ])

        i += 3 # We wrote 3 instructions

    subleq.extend([0, 0, -1]) # Exit

    print(" ".join(map(str, subleq)))
