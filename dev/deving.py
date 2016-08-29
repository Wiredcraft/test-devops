#!/usr/bin/python
import argparse, json, sys, os
import subprocess, datetime, re


class Deving(object):
    def __init__(self):
        self.srcRepoName = "test-blog"
        self.srcBranch = "master"
        self.cpdRepoName = "test-blog-compiled"
        self.cpdBranch = "master"
        self.sourceRepo = "https://github.com/devfans/test-blog.git"
        self.compiledRepo = "https://github.com/devfans/test-blog-compiled.git"
        self.workDir = os.environ['HOME']
        self.srcPath = os.path.join(self.workDir, self.srcRepoName)
        self.cpdPath = os.path.join(self.srcPath, "_site")
        self.template = """---
layout: post
title:  {blogTitle}
date:   {blogDate}
categories: update
---
{blogContent}"""
        self.syncSrc()
        self.initFortune()
        return None
    def syncSrc(self):
        print("Sync from source")
        try:
            if os.chdir(self.srcPath) == 0 and os.system("git status") == 0:
                os.system("git pull origin " + self.srcBranch)
                return None
            else:
                os.chdir(self.workDir)
                os.system("git clone " + self.sourceRepo)
                return None
        except:
            #os.system("mkdir -p " + self.srcPath)
            os.chdir(self.workDir)
            os.system("git clone " + self.sourceRepo)
            return None
    def initFortune(self):
        os.system("sudo yum install fortune-mod -y")
        return None
    def dev(self):
        print("Will make a new post")
        postPath = os.path.join(self.srcPath, "_posts")
        os.chdir(postPath)
        content = subprocess.check_output("fortune", shell=True)
        dateNow = str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) + "+0800"
        stamp = datetime.datetime.now().date().isoformat()
        title = content[0:18]
        blog = self.template.format(blogContent = content, blogTitle = title, blogDate = dateNow)
        filename = stamp + "-" + title.replace(" ","-").replace(".","").replace("'","").replace("\"","").replace("?","").replace(":","").replace(",","") + "-newpost.markdown"
	print(filename)
        filePath = os.path.join(postPath, filename)
        with open(filePath, 'w+b') as f:
            f.write(blog)
        print("increase the version number")
        verPath = os.path.join(self.srcPath, '_data','meta.yml')
        version = subprocess.check_output("cat " + verPath, shell=True)
        ver = re.findall(r'(version: \d.\d.)(\d)', version)
        newVersion = ver[0][0] + str(int(ver[0][1]) + 1)
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
	os.chdir(self.srcPath)
	os.system("jekyll build --config _config.yml")
	os.chdir(self.cpdPath)
	os.system("git init . && git remote add origin " + self.compiledRepo)
	os.system("git pull origin " + self.cpdBranch + " -f")
	os.system("git add * && git commit -m 'newpost'")
	os.system("git push origin master")
        return None
    def staging(self):
        print("increase the version number")
        verPath = os.path.join(self.srcPath, '_data','meta.yml')
        version = subprocess.check_output("cat " + verPath, shell=True)
        ver = re.findall(r'(version: \d.)(\d)(.\d)', version)
        newVersion = ver[0][0] + str(int(ver[0][1]) + 1) + ".0"
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
        return None









def main():
    parser = argparse.ArgumentParser(description="Generating posts for test-blog-site")
    parser.add_argument("action", help="use dev to generate new post using fortune and push compiled site back to github with version added by 0.0.1. use staging to push compiled site back to github with version added by 0.1.0.")
    choice = parser.parse_args()
    if choice.action == 'dev':
        try:
            deving = Deving()
            deving.dev()
            print("A dev action was made!")
        except BaseException as e:
            print(e)
        return None
    elif choice.action == 'staging':
        try:
            deving = Deving()
            deving.staging()
            print("A release action was made!")
        except BaseException as e:
            print(e)
        return None
    else:
        print("Wrong arguments provided!")
        return None

if __name__ == "__main__":
    main()
