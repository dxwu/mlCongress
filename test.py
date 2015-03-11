import os
import parse_testbill
import subprocess

#k = 8
#subprocess.call(["python extract_words.py ./pass_training/ ./fail_training/ " + str(k)], shell=True);
#subprocess.call(["/Applications/MATLAB_R2014b.app/bin/matlab -nosplash -nodisplay -r \"lda("+str(k)+",0.1,0.1,20,15);quit()\""],shell=True)
subprocess.call(["python parse_testbill.py ./pass_test/ ./fail_test/ " + str(k)], shell=True)
subprocess.call(["/Applications/MATLAB_R2014b.app/bin/matlab -nosplash -nodisplay -r \"classify(" + str(k) + ", 0.1, 0.1, 30, 15, ['./pass_test_clean/'; './fail_test_clean/']);quit()\""], shell=True)
