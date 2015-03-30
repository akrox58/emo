import sys
import urllib
import re
import lxml.html
import unicodedata
import os


class Song(object):
    def __init__(self, artist, title):
        self.artist = self.__format_str(artist)
        self.title = self.__format_str(title)
        self.url = None
        self.url1=None
        self.lyric = None

    def __format_str(self, s):
        
        s = s.strip()
        try:
            
            s = ''.join(c for c in unicodedata.normalize('NFD', s)
                         if unicodedata.category(c) != 'Mn')
        except:
            pass
        s = s.title()
        return s

    def __quote(self, s):
         return urllib.parse.quote(s.replace(' ', '_'))

    def __make_url(self):
        artist = self.__quote(self.artist)
        title = self.__quote(self.title)
        artist_title = '%s:%s' %(artist, title)
        artist_title1='%s/%s.html' %(artist,title)
        url = 'http://lyrics.wikia.com/' + artist_title
        url1='http://www.azlyrics.com/lyrics/'+artist_title1
        self.url = url
        self.url1=url1

    def update(self, artist=None, title=None):
        if artist:
            self.artist = self.__format_str(artist)
        if title:
            self.title = self.__format_str(title)

    def lyricwikia(self):
        self.__make_url()
        try:
            doc = lxml.html.parse(self.url)
            lyricbox = doc.getroot().cssselect('.lyricbox')[0]
        except IOError:
            self.lyric = ''
            return
        lyrics = []

        for node in lyricbox:
            if node.tag == 'br':
                lyrics.append('\n')
            if node.tail is not None:
                lyrics.append(node.tail)
        self.lyric =  "".join(lyrics).strip()    
        return self.lyric
s1=sys.argv[1]
s2=sys.argv[2]
song = Song(artist=s1, title=s2)
lyr = song.lyricwikia()
print(lyr)

open('word.txt', 'w').close()
with open('word.txt', 'wb') as fh:
    fh.write(bytes(lyr,'UTF-8'))

