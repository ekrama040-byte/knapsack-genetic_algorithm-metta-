import os

def translate_file():
    input_path = "input.txt"
    output_path = "cases.metta"
    
    if not os.path.exists(input_path):
        print(f"Error: {input_path} not found.")
        return

    with open(input_path, "r") as f:
        lines = [line.strip() for line in f if line.strip()]

    if not lines:
        return

    num_cases = int(lines[0])
    idx = 1
    
    with open(output_path, "w") as out:
        out.write(";; Automatically generated test cases for PeTTa\n\n")
        
        for case_num in range(1, num_cases + 1):
            if idx >= len(lines):
                break
            capacity = lines[idx]
            item_count = int(lines[idx+1])
            idx += 2
            
            # Assemble items into a nested MeTTa Cons list structure
            metta_list = "Nil"
            for _ in range(item_count):
                val, wt = lines[idx].split()
                metta_list = f"(Cons (Item {val} {wt}) {metta_list})"
                idx += 1
                
            out.write(f"(= (get-case {case_num}) (Case {capacity} {metta_list}))\n")
            
    print("Success: Generated cases.metta for PeTTa evaluation.")

if __name__ == "__main__":
    translate_file()
