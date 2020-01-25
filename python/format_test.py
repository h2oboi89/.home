import sys

def main(args):
    if len(args) < 2:
        print("Usage: <script> <test file>")
        exit(1)
    
    lines = []
    
    try:
        with open(args[1]) as f:
            for line in f:
                lines.append(line)

    except FileNotFoundError as error:
        print(error)
        exit(1)

    with open(args[1], 'w') as f:
        f.write("import pytest\n")
        
        count = 0
        for line in lines:
            if line.startswith("    def test"):
                f.write(f"    @pytest.mark.run(order={count})\n")
                count += 1

            f.write(line)

if __name__ == '__main__':
    main(sys.argv)
