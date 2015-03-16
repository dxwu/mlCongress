import os
import parse_testbill
import subprocess
import sys

if not os.path.isfile("/Applications/MATLAB_R2014b.app/bin/matlab"):
	print "'/Applications/MATLAB_R2014b.app/bin/matlab' is not a file"
	sys.exit(1)

k = input("Choose a topic size from [5, 8, 10, 15, 20]: ")

subprocess.call(["python extract_words.py ./pass_training/ ./fail_training/ " + str(k)], shell=True);
subprocess.call(["/Applications/MATLAB_R2014b.app/bin/matlab -nosplash -nodisplay -r \"lda("+str(k)+",0.1,0.1,30,15);quit()\""],shell=True)
subprocess.call(["python parse_testbill.py ./pass_test/ ./fail_test/ " + str(k)], shell=True)
subprocess.call(["/Applications/MATLAB_R2014b.app/bin/matlab -nosplash -nodisplay -r \"classify(" + str(k) + ", 0.1, 0.1, 30, 15, ['./pass_test_clean/'; './fail_test_clean/']);quit()\""], shell=True)
