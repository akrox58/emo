import nltk,re, pprint,pattern.en
from nltk.corpus import stopwords
from pattern.en import singularize
from nltk.tokenize import sent_tokenize
from nltk.tokenize import word_tokenize
from nltk.tokenize import RegexpTokenizer
from nltk.stem import PorterStemmer
from nltk.stem.lancaster import LancasterStemmer
from collections import Counter
from itertools import chain
i=[0,0,0,0,0]

#Reading text files
def read_file(name):
	files=open(name,"r")
	mood=files.read()
	mood=mood.lower()
	mood=mood.split()
	return mood

def StoI(name):
	name=[i for i in name if i]
	name = [int(i) for i in name]
	return name
#reads all files
happy=read_file("happy.txt")
sad=read_file("sad.txt")
angry=read_file("angry.txt")
fear=read_file("fear.txt")
surprise=read_file("surprise.txt")
neg=read_file("neg.txt")
quant=read_file("quant.txt")
stops=read_file("stopwords_en.txt")
hr=read_file("hr.txt")
sar=read_file("sar.txt")
fr=read_file("fr.txt")
ar=read_file("ar.txt")
sur=read_file("sur.txt")
hr=StoI(hr)
sar=StoI(sar)
fr=StoI(fr)
ar=StoI(ar)
sur=StoI(sur)
#tokenizing the text obtained from the document
def ie_preprocess(document):
	#sentences = nltk.sent_tokenize(document)
	#tokenizer = RegexpTokenizer(r'\w+')
	sentences = [sent.split() for sent in document]
	for sentence in sentences:
		for word in sentence:
			punc=['.',',','?','!']
			if word[-1] in punc:
				add=word.split(word[-1])
				prev=sentence.index(word)
				sentence.remove(word)
				add.remove(add[-1])
				add=''.join(add)
				sentence.insert(prev,add)

	sentences = [remove_stop(sent) for sent in sentences]
#	sentences = [stem_func(sent) for sent in sentences]
#     	sentences = [singularize(word) for word in sent for sent in sentences]

	return sentences

#removing unneccessary words
def remove_stop(sent):
	sentences=[w for w in sent if w not in stops or w in neg]
	return sentences

#getting all verbs to its roots.
def stem_func(v):

	lancaster_stemmer = LancasterStemmer()
        s=[]

        for word in v:
			if word not in quant+neg+happy+sad+angry+surprise+fear:
              			s.append(lancaster_stemmer.stem(word))
			else :
				s.append(word)
	return s

#Returns word after negation
def neg_points(word):
	if word in happy:
		return 1
	elif word in sad:
		return 0
	elif word in angry:
		return 0
	elif word in fear:
		return 4
	elif word in surprise:
		return 3

#returns mood points for each sentence
def add_mood(word,moodid,i,add):
	if moodid!=-1:
		i[moodid]=i[moodid]+add

	else:
				if word in happy:
					moodid=0
					moodf=happy
					moodr=hr
				elif word in sad:
					moodid=1
					moodf=sad
					moodr=sar
				elif word in angry:
					moodid=2
					moodf=angry
					moodr=ar
				elif word in fear:
					moodid=3
					moodf=fear
					moodr=fr
				elif word in surprise:
					moodid=4
					moodf=surprise
					moodr=sur
				value=moodr[moodf.index(word)]
				i[moodid]=i[moodid]+add+value
	return (moodid,i)

def award_points(sent):
	i=[0,0,0,0,0]
	cont=0
	q=0
	add=0
	moodid=-1
	nega=0
	conj=['and','but','than']
	moods=happy+sad+angry+fear+surprise
	for word in sent:
		if word in moods+neg+quant+conj:

			if word in conj:
				if word == 'and' or word == 'than':
					if moodid==-1:
						add=1
						continue
					add=add+1
					(moodid,i)=add_mood(word,moodid,i,add)
					add=0
					continue
				add=add+1
				continue
			if word in quant or q==1:
				if q==0:
					add=add+1
					q=1
					continue
				if word not in moods+neg:
					continue

				if q==1:
					q=0
					add=1+add

			if word in neg or cont==1:

				if word in neg and cont==1:
					cont=0
					nega=1
					continue
				if cont==0:
					cont=1
					nega=1
					continue
				if word not in moods:
					nega=1
					continue
				cont=0
				moodid=neg_points(word)
				(moodid,i)=add_mood(word,moodid,i,2)
				add=0
				nega=0
				continue

			elif word in moods:
				(moodid,i)=add_mood(word,-1,i,add)
			add=0
	if nega==1 and sent and moodid==-1:
		i[1]=i[1]+1
	return i

#Finding out the mood of each sentence
def mood_persent(point):
	return [point.index(max(point)),max(point)]


#Returning most frequent value:
def Most_Common(lst):
    data = Counter(lst)
    return data.most_common(1)[0][0]

def Most(point):
	point=sorted(point)
	lent=len(point)
	mood=[0,0,0,0,0]
	for i in range(0,len(point)):
			if point[i][0]==0:
				mood[0]+=point[i][1]
			if point[i][0]==1:
				mood[1]+=point[i][1]
			if point[i][0]==2:
				mood[2]+=point[i][1]
			if point[i][0]==3:
				mood[3]+=point[i][1]
			if point[i][0]==4:
				mood[4]+=point[i][1]
	print mood
	return mood
#Printing mood detected
def printingMood(mood):

	smood=mood.index(max(mood))
	if smood==0:
		return 'Happy'
	if smood==1:
		return 'Sad'
	if smood==2:
		return 'Angry'
	if smood==3:
		return 'Fear'
	if smood==4:
		return 'Surprise'


text=open('word.txt','r')
text=text.read()
result=text
text=text.lower()
text=text.split('\n')
#punc=['.','!','?']
#text=filter(None, re.split("['\n'.!?]+",text))
#Getting tokenized output
sentences=ie_preprocess(text)
print sentences

points=[award_points(sent) for sent in sentences]
zeroes=[0,0,0,0,0]
zap=[]
for x in points:
	if x==zeroes:
		continue
	zap.append(x)
print zap
if not zap:
	result="Happy"

else:

	point=[mood_persent(point) for point in zap]
	print point
	mood=Most(point)
	print mood
	result=printingMood(mood)
print result
fh=open('result.txt', 'w')
fh.write(str(result)+'\n')
fh.close()


