function feature_vectors()

for k = 6:10
system('python extract_words.py ./pass_training/ ./fail_training/');
lda( k, 0.1, 0.1, 30, 15 );
system('python parse_testbill.py ./pass_test/ ./fail_test/');
classify(k, 0.1, 0.1, 30, 15, ['./pass_test_clean/'; './fail_test_clean/']);
end