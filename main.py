import argparse

def main(index, temperature, category):
    # Dummy routine, can be replaced for any self-contained function
    # Your code here

    # Some dummy processing to stdout
    print('Index: ',index)
    print('Temperature: ', temperature)
    print('Category: ', category)
    return



if __name__ == "__main__":
    # Set parser for arguments submitted to main.py (with data types enforced)
    parser = argparse.ArgumentParser(description='Process input parsed from parameters.csv')
    parser.add_argument('--index', type=int, required=True)
    parser.add_argument('--temperature', type=float, required=True)
    parser.add_argument('--category', type=str, required=True)

    args = parser.parse_args()
    main(args.index, args.temperature, args.category)
