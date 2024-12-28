import subprocess
import os
import signal
import queue
import threading
import time
import random
import string

asm = ["./asm/string_s"]
c = ["./c/string"]
tests = 100
max_len = 80
chars = string.ascii_letters + string.digits
charspace = chars + ' '


def read_output(pipe, output_queue):
    for line in iter(pipe.readline, ''):
        output_queue.put(line)
    pipe.close()


def run_process(command, query, timeout):
    process = subprocess.Popen(
        command,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        bufsize=1
    )

    process.stdin.write(query)
    process.stdin.flush()

    output_queue = queue.Queue()
    output_thread = threading.Thread(target=read_output, args=(process.stdout,
                                                               output_queue))
    output_thread.start()

    out = ""

    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            line = output_queue.get(timeout=0.01)
            if line:
                out += line
        except queue.Empty:
            pass

    process.terminate()
    try:
        process.wait(timeout=1)
    except subprocess.TimeoutExpired:
        print("Process did not terminate in time, killing now.")
        os.kill(process.pid, signal.SIGKILL)

    output_thread.join()
    output, errors = process.communicate()
    if errors:
        print("Errors:", errors.strip())

    process.stdin.close()
    process.stdout.close()
    process.stderr.close()

    return out


def ran_char():
    return random.choice(chars)


def ran_string():
    len = random.randrange(0, max_len - 1)
    str = ran_char()

    for i in range(0, len):
        str += random.choice(charspace)

    return str


def gen_test():
    test = ""

    # strlen
    test += ran_string()
    test += "\n"

    # strcpy 1, strcpy 2, strcmp
    for i in range(1, 4):
        test += ran_string()
        test += "\n"
        test += ran_string()
        test += "\n"

    # strchr, strchrr
    for i in range(1, 3):
        test += ran_string()
        test += "\n"
        test += ran_char()
        test += "\n"

    return test


if __name__ == "__main__":
    for i in range(1, tests + 1):
        test = gen_test()

        asm_out = run_process(asm, test, 0.01)
        c_out = run_process(c, test, 0.01)

        print(f"==== TEST {i} ====")

        print("==== ASSEMBLY ====")
        print(asm_out)

        print("\n======= C ========")
        print(c_out)

        if asm_out == c_out:
            print("\n=> PASSED\n\n\n")
        else:
            print("\n=> FAILED\n")
            print("Faulty input was:")
            print(test)
            print("\n")
