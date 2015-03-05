import sys
import nltk
import numpy
import string
import collections
from nltk.corpus import wordnet as wn
from nltk.collocations import *
bigram_measures = nltk.collocations.BigramAssocMeasures()
#hap=['happy','glad','good','great','love','joy']
#sad=['sad','sorrow','hurt','cry','bad','worry']
#ang=['angry','sorrow','stupid','annoy','frustrate','jealous']
#fear=['fear','afraid','frighten','scare','terrify','threaten']
#sur=['surprise','amazing','astonish','incredible','wonder','awe']
emo=[]
dep=[]
ded=[]
app=[]
aff=[]
hap=['happy','good','win','successful','cheerful','contented','delighted','excited','fulfilled','glad','gleeful','gratified','radiant','rapturous','calm','joyful','interested','proud','accepted','powerful','peaceful','intimate','liberated','ecstatic','amused','inquistive','important','confident','respected','funfilled','courageous','provocative','loving','hopeful','sensitive','playful','open','inspired','encouraged','friendly','inspired','jovial','smiling','upbeat','joyful','lively','merry','optimistic','playful','pleased','rejuvenated','relaxed','satisfied','blissful','egocentric','elated','enthralled','euphoric','exhilarated','giddy','jubiliant','manic']
sad=['sad','bored','lonely','depressed','despair','abandoned','guilty','remorseful','ashamed','ignored','victimized','powerless','vulnearable','inferior','empty','isolated','apathetic','indifferent','contemplated','disappointed','disconnected','distracted','grounded','listless','low','regretful','wistful','dejected','discouraged','down','drained','forlorn','gloomy','grieving','heavyhearted','melancholy','mournful','grief','sorrow','angiushed','bereaved','bleak','despair','despondent','heartbroken','hopeless','inconsolable','morose']
ang=['angry','bristling','exasperated','incensed','indignant','inflamed','offended','resentful','riledup','critical','apathetic','certain' ,'cold','crabby','cranky','cross','detached','displeased','impatient','distant','frustrated','appalled','belligerent','bitter','contemptuous','hostile','irate','livid','menacing','outrage','ranting','raving','seething','spiteful','vengeful','vicious','vindictive','violent','aggressive','mad','hateful','threatened','hurt','embarrassed','devastated','insecure','jealous','resentful','violated','furious','enraged','provoked','hostile','infuriated','irritated','peeved','rankled','affronted','aggravated','antagonized','arrogant','withdrawn','suspicious','skeptical','sarcastic','annoyed']
fear=['fear','threatened','shocked','terrorized','afraid','alarmed','aversive','distrustful','jumpy','nervous','perturbed','rattled','shaky','humiliated','rejected','submissive','insecure','anxious','scared','ridiculed','disrespected','alienated','inadequate','insignificant','worthless','worried','overwhlemed','frightened','terrified','alert','apprehensive','cautious','concerned','confused','curious','disconcerted','disoriented','diquieted','doubtful','edgy','fidgety','hesistant','indecisive','insecure','instinctive','intuitive','leery','pensive','shy','timid','uneasy','watchful','unnerved','unsettled','wary','phobic','petrified','horrified','jealous','possesive']
sur=['surprise','startled','confused','amazed','excited','dismayed','disillusioned','preplexed','astonished','awe','eager','energetic','thrilled']
neg=['not','never','no']
def tokenize_text(str):
	from nltk.tokenize import RegexpTokenizer
	tokenizer = RegexpTokenizer(r'\w+')
	w=tokenizer.tokenize(s)
	return w
def stop_removal(w):
	stop=set(('i','been', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself','it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and','but','if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in','out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all','any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'nor', 'only', 'own', 'same', 'so','than', 'too', 'very','s', 't', 'can', 'will', 'just', 'don', 'should', 'now'))
	n=[i.lower() for i in w if i.lower() not in stop]	

	return n
def stem_func(v):
	from nltk.stem import PorterStemmer
	stemmer=PorterStemmer()
	s=[]
	for word in v:
        	s.append(stemmer.stem(word))
	return s
def chunks(seq, n):

    return (seq[i:i+n] for i in xrange(0, len(seq), n))


s1=[]
for i in range(1,len(sys.argv)):
	s1.append(sys.argv[i])
print s1
s=' '.join(s1)

print s
w=tokenize_text(s)
n=stop_removal(w)
print n
v=nltk.pos_tag(n)
print v

x=stem_func(n)
#print x
for word,y in v:
        if y=='JJ' or y=='JJR' or y=='JJS' or y=='RB' or y=='RBR' or y=='RBS' or y=='NN':
                dep.append(word)
        if word in neg:
                ded.append(word)
def uni_c(word):
        return s.count(word)

def bi_c(word,cha):
        sc=0
	sc+=s.count(cha+' '+word)
        sc+=s.count(word+' '+cha)
        return sc
def pmi(j,p):
        sc=0.0
        su=[]
        for word in j:
                for cha in p:
                        prob_word1 = uni_c(word)
                        #print prob_word1
                        prob_word2=uni_c(cha)
                        #print prob_word2
                        prob=bi_c(word,cha)
                        #print prob
                        #print prob_word1*prob_word2
                        try:
                                r= prob/float(prob_word1*prob_word2)
                                sc+=r
			#	print sc
                        except:
                                r=0
		su.append(sc)
		sc=0.0
	return su	
h1=pmi(n,hap)
s1=pmi(n,sad)
a1=pmi(n,ang)
f1=pmi(n,fear)
su1=pmi(n,sur)
#print h1
#print s1
#print a1
#print f1
#print su1
for h in n:
        if h in ded:
                g=n.index(h)
                af=n[g+1]
                aff.append(af)
h_sum=(sum(h1)/len(n))
s_sum=(sum(s1)/len(n))
a_sum=(sum(a1)/len(n))
f_sum=(sum(f1)/len(n))
su_sum=(sum(su1)/len(n))
for word in aff:
        if word in hap:
                h_sum-=h_sum 
        elif word in sad:
                s_sum-=s_sum
        elif word in ang:
                a_sum-=a_sum
        elif word in fear:
               f_sum-=f_sum
        elif word in sur:
                su_sum-=su_sum
emo.append(h_sum)
emo.append(s_sum)
emo.append(a_sum)
emo.append(f_sum)
emo.append(su_sum)
print emo
max_emo=max(emo)
print  max_emo
def final(max_emo):
	if max_emo==h_sum:
		return '1'
	if max_emo==s_sum:
		return '2'
	if max_emo==a_sum:
		return '3'
	if max_emo==f_sum:
		return '4'
	if max_emo==su_sum:
		return '5'
the_emo=final(max_emo)
print the_emo


open('finish.txt', 'w').close()
with open('finish.txt', 'wb') as fh:
    fh.write(the_emo+'\n')
