#!/usr/bin/python
import argparse, json, sys, os, time
import subprocess, datetime, re

# Define Iteration class for making new post and publish
class Iteration(object):
    def __init__(self):
        # Specify Github token for auto-publish
        self.otoken = "f543c1a8d0784c82a6d8e79229109cec9f213151"
        # Specify the project-source repository meta
        self.srcRepoName = "test-blog"
        self.srcBranch = "master"
        self.sourceRepo = "https://github.com/devfans/test-blog.git"
        # Specify the project-compiled repository meta
        self.cpdRepoName = "test-blog-compiled"
        self.cpdBranch = "master"
        self.compiledRepo = "https://github.com/devfans/test-blog-compiled.git"
        self.compiledRepoOauth = "https://" + self.otoken + ":x-oauth-basic@github.com/devfans/test-blog-compiled.git"
        # Store the version of the site
        self.version = None
        # Set default git user info if not set yet when make a commit
        self.gitEmail = "devops@wiredcraft.com"
        self.gitUser = "devops stefan"
        # Specify the time interval (in minutes) for new post generation
        self.devInterval = 10
        # Specify after how many new posts created, it needs to make staging release
        self.devsToStage = 6
        # Specify the temp work directory to store repos
        self.workDir = os.environ['HOME']
        self.srcPath = os.path.join(self.workDir, self.srcRepoName)
        self.cpdPath = os.path.join(self.srcPath, "_site")
        # Specify the new post template
        self.template = """---
layout: post
title:  {blogTitle}
date:   {blogDate}
categories: update
---
{blogContent}"""
        # Prepare local environment for work
        self.syncSrc()
        self.initFortune()
        self.initJekyll()
        self.initGit()
        return None

    def initGit(self):
        try:
            mailaddr = subprocess.check_output("git config --get user.email", shell=True)
        except:
            os.system("git config --global user.email " + self.gitEmail)
        try:
            username = subprocess.check_output("git config --get user.name", shell=True)
        except:
            os.system("git config --global user.name " + self.gitUser)
        return None
    # Define method to fetch repos from Github
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
    # Prepare fortune
    def initFortune(self):
        os.system("sudo apt-get install fortune-mod -y")
        return None
    # Prepare jekyll tools
    def initJekyll(self):
        try:
            os.system("sudo apt-get install -y git gem ruby ruby-dev gcc nodejs")
            os.system("sudo gem install jekyll")
            os.system("sudo gem install bundle")
        except BaseException as e:
            print("Error occurred when prepare for jekyll!")
            print(e)
        return None
    # Define new post generation process
    def genPost(self):
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
        return None
    # Increase site version by 0.0.1 for new post
    def devIncreVer(self):
        print("increase the version number")
        # To fetch site version from jekyll data file and update it
        verPath = os.path.join(self.srcPath, '_data','meta.yml')
        version = subprocess.check_output("cat " + verPath, shell=True)
        ver = re.findall(r'(version: \d.\d.)(\d)', version)
        newVersion = ver[0][0] + str(int(ver[0][1]) + 1)
        self.version = re.findall(r'version: (\d.\d.\d)', newVersion)[0]
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
        return None
    # Increase site version by 0.1.0 for new staging release
    def stagingIncreVer(self):
        print("increase the version number for release")
        verPath = os.path.join(self.srcPath, '_data','meta.yml')
        version = subprocess.check_output("cat " + verPath, shell=True)
        ver = re.findall(r'(version: \d.)(\d)(.\d)', version)
        newVersion = ver[0][0] + str(int(ver[0][1]) + 1) + ".0"
        self.version = re.findall(r'version: (\d.\d.\d)', newVersion)[0]
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
        return None
    # Commit changes and push back to Github with new tags
    def CommitGH(self):
        os.chdir(self.srcPath)
        os.system("jekyll build --config _config.yml")
        os.chdir(self.cpdPath)
        try:
            os.system("git init . && git remote add origin " + self.compiledRepoOauth)
        except:
            print("Remote origin already exist!")
        os.system("git pull origin " + self.cpdBranch + " -f")
        os.system("git add * && git commit -m 'Add new post'")
        os.system("git tag -a " + self.version + " -m 'Release new version '" )
        os.system("git push origin master")
        os.system("git push origin --tags")
        return None
    # Dev entry to make a new post
    def dev(self):
        self.genPost()
        self.devIncreVer()
        self.CommitGH()
        return None
    # Staging entry to make a staging release
    def staging(self):
        self.stagingIncreVer()
        self.CommitGH()
        return None
    # iteration entry to start iterations
    def iterate(self):
        elapse = 0
        while True:
            self.dev()
            time.sleep(self.interval*60)
            elapse += 1
            if elapse >= self.devsToStage:
                self.staging()
                elapse = 0
        return True



# main entry
def main():
    parser = argparse.ArgumentParser(description="Generating posts for test-blog-site")
    parser.add_argument("action", help="use dev to generate new post using fortune and push compiled site back to github with version added by 0.0.1. use staging to push compiled site back to github with version added by 0.1.0.")
    choice = parser.parse_args()
    if choice.action == 'dev':
        try:
            interator = Interation()
            interator.dev()
            print("A dev action was made!")
        except BaseException as e:
            print(e)
        return None
    elif choice.action == 'staging':
        try:
            interator = Interation()
            interator.staging()
            print("A release action was made!")
        except BaseException as e:
            print(e)
        return None
    elif choice.action == 'iteration':
        try:
            print("Iteration started!")
            interator = Interation()
            interator.iterate()
        except BaseException as e:
            print(e)
        return None
    else:
        print("Wrong arguments provided!")
        return None

if __name__ == "__main__":
    main()