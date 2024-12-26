import subprocess
import os
import signal
import queue
import threading
import time
import random
import string

max_len = 80
chars = string.ascii_letters + string.digits + ' '


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

    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            line = output_queue.get(timeout=0.01)
            if line:
                print(line.strip())
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
    if output:
        print(output.strip())
    if errors:
        print("Errors:", errors.strip())

    process.stdin.close()
    process.stdout.close()
    process.stderr.close()

    return output.strip()


def ran_char():
    return random.choice(chars)


def ran_string():
    len = random.randrange(0, max_len)
    str = ""

    for i in range(0, len):
        str += ran_char()

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
    asm = ["./asm/string"]
    c = ["./c/string"]

    test = gen_test()

    print("==== ASSEMBLY ====")
    asm_out = run_process(asm, test, 0.1)
    print("\n======= C ========")
    c_out = run_process(c, test, 0.1)

    if asm_out == c_out:
        print("\n=> PASSED")
    else:
        print("\n=> FAILED")
