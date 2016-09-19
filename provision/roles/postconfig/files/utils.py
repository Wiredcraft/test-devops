#!/usr/bin/python
#-*- coding:utf-8 
from time import strftime
import commands, os 
import re
from sys import exit

class MakeFortunePost(object):

    markdown_template = '''---
layout: post
title:  {title}
date:   {timestamp}
categories: autobot
tags: devops
---

{content}
'''
    def __init__(self,output,cmd='/usr/games/fortune',template=markdown_template):
        self.cmd = cmd
        self.output = output
        self.timestamp = strftime('%Y-%m-%d %H:%M:%S')  
        self.template = template

    def _generate(self):
        content = os.system(self.cmd)
        title = " ".join(re.split('\W+',content)[:5])
        final_post = self.template.format(title=title,content=content,timestamp=self.timestamp)
        return final_post

    def writedown(self):
        with open(self.output,'w+') as fp:
            fp.write(self._generate())


class VersionUpdateHandler(object):
    def __init__(self,enviroment,filepath ,debug=False):
        self.enviroment = enviroment
        self.filepath = filepath
        with open(self.filepath,'r') as f:
            self.major,self.minor,self.revision = f.readline().split(':')[-1].split('.')
            self.before_msg="before process ,current version: major: %s ,minor: %s , revision: %s"%(self.major,self.minor,self.revision)
            if self.enviroment == 'dev':
               self.revision = int(self.revision) + 1
            elif self.enviroment == 'staging':
                self.minor = int(self.minor) + 1
                self.revision = 0
            self.final_version = 'Version: %d.%d.%d'%(int(self.major),int(self.minor),int(self.revision))
            self.after_msg = "final_version: %s" % self.final_version 
            if debug:
                print self.before_msg+'\n'+self.after_msg
            
    def writeback(self):
        try:
            with open(self.filepath,'w+') as w:
                w.write(self.final_version)
                return self.final_version.split(":")[-1].strip()
        except Exception as e:
            print e
    
    def resetversion(self):
        try:
            with open(self.filepath,'w+') as w:
                w.write('Version: 0.0.0')
        except Exception as e:
            print e

class PushtoGH(object):
    def __init__(self,env,config):
        self.env = env
        self.config = config
        self.path = self.config[env]['base']
    
    def sync_to_staging(self):
        rsync = '/usr/bin/rsync -avzr --delete {s} {d}'.format(s=self.config['dev']['source'],d=self.config['staging']['source'])
        os.system(rsync)     
    def push(self,ver):
        if self.env == 'dev':
            try:
                print 'in devops dev process'
                os.chdir(self.path)
                print os.system('jekyll build -q --config _config_dev.yml')
                print os.system('git init')
                print os.system('git add _posts _site')
                print os.system('git commit -m "just add a new post"')
                print os.system('git push origin master -f') 
                print 'leave devops dev process'
            except Exception as e:    
                print e
        if self.env == 'staging':
             try:
                print 'in devops staging process'
                self.sync_to_staging()
                os.chdir(self.path)
                print os.system('jekyll build -q --config _config_staging.yml')
                print os.system('git init')
                print os.system('git add _posts _site -f')
                print os.system('git commit -m "just add release tag"')
                print os.system('git tag  -a v%s -m "add new tag"'%ver)
                print os.system('git push --tags origin master -f')
                print 'leave devops staginf process'
             except  Exception as e:
                print e
