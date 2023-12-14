import subprocess

commands = [
    "make sim BP=ALWAYS_NOT_TAKEN",
    "make sim BP=ALWAYS_TAKEN",
    "make sim BP=BIT PR_BIT=1",
    "make sim BP=BIT PR_BIT=2",
    "make sim BP=LOCAL",
    "make sim BP=GSHARE",
    "make sim BP=TOURNAMENT_BIT",
    "make sim BP=TOURNAMENT",
    # "make sim BP=BIT PR_BIT=1 BTB_BIT=2",
    # "make sim BP=BIT PR_BIT=2 BTB_BIT=2",
    # "make sim BP=LOCAL BTB_BIT=2",
    # "make sim BP=GSHARE BTB_BIT=2",
    # "make sim BP=TOURNAMENT_BIT BTB_BIT=2",
    # "make sim BP=TOURNAMENT BTB_BIT=2"
]

log_file = "console_output.log"

for command in commands:
    subprocess.run("make clean", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    with open(log_file, "a") as log:
        result_clean = subprocess.run("make clean", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    
    with open(log_file, "a") as log:
        log.write(f"\n\nCommand: {command}\n")
        result_make = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        log.write(result_make.stdout)
    
    with open(log_file, "a") as log:
        log.write(f"\n\nCommand: make br_analyze\n")
        result_br_analyze = subprocess.run("make br_analyze", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        log.write(result_br_analyze.stdout)
