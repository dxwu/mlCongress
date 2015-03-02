import re
import numpy
import os
import sys
import nltk
import shutil

#
#   Usage: python extract_words.py passdir/ faildir/
#   Output: maxCount.txt vocab_length.txt vocab.txt labels.txt
#
#   Each document in ./pass_test/ and ./fail_test/ has a corresponding preprocessed version in ./pass_test_clean/ and ./fail_test_clean/
#   writes to maxCount.txt the maximum number of words across all test documents

stopwords_list = "a,s,able,about,above,according,accordingly,across,actually,after,afterwards,again,against,ain,t,all,allow,allows,almost,alone,along,already,also,although,always,am,among,amongst,an,and,another,any,anybody,anyhow,anyone,anything,anyway,anyways,anywhere,apart,appear,appreciate,appropriate,are,aren,t,around,as,aside,ask,asking,associated,at,available,away,awfully,be,became,because,become,becomes,becoming,been,before,beforehand,behind,being,believe,below,beside,besides,best,better,between,beyond,both,brief,but,by,c,mon,c,s,came,can,can,t,cannot,cant,cause,causes,certain,certainly,changes,clearly,co,com,come,comes,concerning,consequently,consider,considering,contain,containing,contains,corresponding,could,couldn,t,course,currently,definitely,described,despite,did,didn,t,different,do,does,doesn,t,doing,don,t,done,down,downwards,during,each,edu,eg,eight,either,else,elsewhere,enough,entirely,especially,et,etc,even,ever,every,everybody,everyone,everything,everywhere,ex,exactly,example,except,far,few,fifth,first,five,followed,following,follows,for,former,formerly,forth,four,from,further,furthermore,get,gets,getting,given,gives,go,goes,going,gone,got,gotten,greetings,had,hadn,t,happens,hardly,has,hasn,t,have,haven,t,having,he,he,s,hello,help,hence,her,here,here,s,hereafter,hereby,herein,hereupon,hers,herself,hi,him,himself,his,hither,hopefully,how,howbeit,however,i,d,i,ll,i,m,i,ve,ie,if,ignored,immediate,in,inasmuch,inc,indeed,indicate,indicated,indicates,inner,insofar,instead,into,inward,is,isn,t,it,it,d,it,ll,it,s,its,itself,just,keep,keeps,kept,know,knows,known,last,lately,later,latter,latterly,least,less,lest,let,let,s,like,liked,likely,little,look,looking,looks,ltd,mainly,many,may,maybe,me,mean,meanwhile,merely,might,more,moreover,most,mostly,much,must,my,myself,name,namely,nd,near,nearly,necessary,need,needs,neither,never,nevertheless,new,next,nine,no,nobody,non,none,noone,nor,normally,not,nothing,novel,now,nowhere,obviously,of,off,often,oh,ok,okay,old,on,once,one,ones,only,onto,or,other,others,otherwise,ought,our,ours,ourselves,out,outside,over,overall,own,particular,particularly,per,perhaps,placed,please,plus,possible,presumably,probably,provides,que,quite,qv,rather,rd,re,really,reasonably,regarding,regardless,regards,relatively,respectively,right,said,same,saw,say,saying,says,second,secondly,see,seeing,seem,seemed,seeming,seems,seen,self,selves,sensible,sent,serious,seriously,seven,several,shall,she,should,shouldn,t,since,six,so,some,somebody,somehow,someone,something,sometime,sometimes,somewhat,somewhere,soon,sorry,specified,specify,specifying,still,sub,such,sup,sure,t,s,take,taken,tell,tends,th,than,thank,thanks,thanx,that,that,s,thats,the,their,theirs,them,themselves,then,thence,there,there,s,thereafter,thereby,therefore,therein,theres,thereupon,these,they,they,d,they,ll,they,re,they,ve,think,third,this,thorough,thoroughly,those,though,three,through,throughout,thru,thus,to,together,too,took,toward,towards,tried,tries,truly,try,trying,twice,two,un,under,unfortunately,unless,unlikely,until,unto,up,upon,us,use,used,useful,uses,using,usually,value,various,very,via,viz,vs,want,wants,was,wasn,t,way,we,we,d,we,ll,we,re,we,ve,welcome,well,went,were,weren,t,what,what,s,whatever,when,whence,whenever,where,where,s,whereafter,whereas,whereby,wherein,whereupon,wherever,whether,which,while,whither,who,who,s,whoever,whole,whom,whose,why,will,willing,wish,with,within,without,won,t,wonder,would,would,wouldn,t,yes,yet,you,you,d,you,ll,you,re,you,ve,your,yours,yourself,yourselves,zero".split(',')
recover_list = {"wa":"was", "ha":"has"}
wl = nltk.WordNetLemmatizer()

def is_stopword(w):
    return w in stopwords_list

def is_stopword_id(self, id):
    return self.vocas[id] in stopwords_list
"""
def process_bills(bill_dir, target_dir):
    maxCount = 0
    for root, dirs, filenames in os.walk(bill_dir):
        #print str(root) + ': ' + dirs + ': ' + filenames
        for f in filenames:
            if 'clean' not in os.path.dirname(os.path.realpath(f)):
                count = 0
                data=open(bill_dir + f).read()
                words = re.sub('[^0-9a-zA-Z]+', ' ', data).lower().split(' ')
                word_ids = []#numpy.zeros(len(words))
                for i, w in enumerate(words):
                    w_id = vocab.term_to_id(w)
                    if w_id != None:
                        word_ids.append(w_id)
                        count += 1
                if count > maxCount:
                    maxCount = count
                fw = open(target_dir+f, 'w')
                fw.write(','.join(str(x) for x in word_ids))
    return maxCount
"""

class Vocabulary:
    def __init__(self, pass_test, fail_test, excluds_stopwords=False):
        self.vocas = []        # id to word
        self.vocas_id = dict() # word to id
        self.populate_vocab('./vocab.txt')
        self.maxCount = 0
        self.processTestBill(pass_test, './pass_test_clean/')
        self.processTestBill(fail_test, './fail_test_clean/')
        fw = open('maxCount.txt', 'w')
        fw.write(str(self.maxCount))
        self.excluds_stopwords = excluds_stopwords

    def populate_vocab(self, filename):
        for line in open(filename):
            [wid, word] = line.split(':')
            self.vocas_id[word.strip()] = int(wid)

    def processTestBill(self, testdir, targetdir):
        for root, dirs, filenames in os.walk(testdir):
            for f in filenames:
                data=open(testdir + f).read()
                words = re.sub('[^0-9a-zA-Z]+', ' ', data).lower().split(' ')
                word_ids = []#numpy.zeros(len(words))
                for i, word in enumerate(words):
                    w = wl.lemmatize(word.lower())
                    if not is_stopword(w) and w in self.vocas_id.keys():
                        word_ids.append(self.vocas_id[w])
                fw = open(targetdir+f, 'w')
                fw.write(','.join(str(x) for x in word_ids))
                if len(word_ids) > self.maxCount:
                    self.maxCount = len(word_ids)
"""
    def term_to_id(self, term0):
        term = wl.lemmatize(term0.lower())
        if not re.match(r'[a-z]+$', term): return None
        if self.excluds_stopwords and is_stopword(term): return None
        if term not in self.vocas_id:
            voca_id = len(self.vocas)+1
            self.vocas_id[term] = voca_id
            self.vocas.append(term)
            #print(str(voca_id))
            #self.docfreq.append(0)
        else:
            voca_id = self.vocas_id[term]
        return voca_id
"""
if __name__=='__main__':
    
    if os.path.isdir('./pass_test_clean') == True:
        shutil.rmtree('./pass_test_clean')
    if os.path.isdir('./fail_test_clean') == True:
        shutil.rmtree('./fail_test_clean')

    os.makedirs('./pass_test_clean')
    os.makedirs('./fail_test_clean')
    
    r = open('./labels.txt', 'a')
    r.write(str(len([name for name in os.listdir(sys.argv[1]) if os.path.isfile(sys.argv[1] + name)])) + ',')
    r.write(str(len([name for name in os.listdir(sys.argv[2]) if os.path.isfile(sys.argv[2] + name)])))

    vocab = Vocabulary(sys.argv[1], sys.argv[2], True)
"""
    #test directory: '/Users/barrychen/Desktop/CS74Project/bills_old/sres/sres596/'
    maxCountP = process_bills(sys.argv[1], './pass_clean/') 
    maxCountF = process_bills(sys.argv[2], './fail_clean/') 
    
    p = open('./vocab_length.txt', 'w')
    q = open('./vocab.txt', 'a')
    #q.write(str(vocab.vocas_id))
    
    for key, value in vocab.vocas_id.items():
        q.write(str(value) + ':' + str(key) + '\n')
    
    p.write(str(len(vocab.vocas_id)))

    q = open('./maxCount.txt', 'w')
    q.write(str(max(maxCountP, maxCountF)))
"""
