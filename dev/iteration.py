#!/usr/bin/python
import argparse, json, sys, os, time
import subprocess, datetime, re

# Define Iteration class for making new post and publish
class Iteration(object):
    def __init__(self):
        # Specify Github token for auto-publish
        self.otoken = "20-822 144 dabd-43bec-ab7cf5 334b530 6-e05ed-d cf 0"
        # Specify the project-source repository meta
        self.srcRepoName = "test-blog"
        self.srcBranch = "master"
        self.sourceRepo = "https://github.com/devfans/test-blog.git"
        self.sourceRepoOauth = "https://" + self.otoken.replace(" ","").replace("-","") + ":x-oauth-basic@github.com/devfans/test-blog.git"
        # Specify the project-compiled repository meta
        self.cpdRepoName = "test-blog-compiled"
        self.cpdBranch = "master"
        self.compiledRepo = "https://github.com/devfans/test-blog-compiled.git"
        self.compiledRepoOauth = "https://" + self.otoken.replace(" ","").replace("-","") + ":x-oauth-basic@github.com/devfans/test-blog-compiled.git"
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
            else:
                os.chdir(self.workDir)
                os.system("git clone " + self.sourceRepoOauth)
        except:
            #os.system("mkdir -p " + self.srcPath)
            os.chdir(self.workDir)
            os.system("git clone " + self.sourceRepoOauth)
        os.system("mkdir -p " + self.cpdPath)
        os.chdir(self.cpdPath)
        try:
            os.system("git init . && git remote add origin " + self.compiledRepoOauth)
        except:
            print("Remote origin already exist!")
        os.system("git pull origin " + self.cpdBranch + " -f")
        return None
    # Prepare fortune
    def initFortune(self):
        os.system("sudo apt-get install fortune-mod -y")
        return None
    # Prepare jekyll tools
    def initJekyll(self):
        try:
            os.system("sudo apt-get install -y git gem ruby ruby-dev gcc nodejs")
            aptList = subprocess.check_output("apt list",shell=True)
            if aptList.count("git") <= 0:
            	os.system("sudo apt-get install -y git")
            if aptList.count("gem") <= 0:
            	os.system("sudo apt-get install -y gem")
            if aptList.count("ruby") <= 0:
            	os.system("sudo apt-get install -y ruby")
            if aptList.count("ruby-dev") <= 0:
            	os.system("sudo apt-get install -y ruby-dev")
            if aptList.count("gcc") <= 0:
            	os.system("sudo apt-get install -y gcc")
            if aptList.count("nodejs") <= 0:
            	os.system("sudo apt-get install -y nodejs")
            gemList = subprocess.check_output("gem list",shell=True)
            if gemList.count("jekyll") <= 0:
            	os.system("sudo gem install jekyll -f")
            if gemList.count("bundle") <= 0:
            	os.system("sudo gem install bundle -f")
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
        ver = re.findall(r'(version: )(\d).(\d).(\d)', version)
        if ver[0][2] == '9' and ver[0][3] == '9':
            newVersion = ver[0][0] + str(int(ver[0][1]) + 1) + ".0" + ".0"
        elif ver[0][3] == '9':
            newVersion = ver[0][0] + ver[0][1] + "." + str(int(ver[0][2]) + 1) + ".0"
        else:
            newVersion = ver[0][0] + ver[0][1] + "." + ver[0][2] + "." + str(int(ver[0][3]) + 1)
        self.version = re.findall(r'version: (\d.\d.\d)', newVersion)[0]
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
        return None
    # Increase site version by 0.1.0 for new staging release
    def stagingIncreVer(self):
        print("increase the version number for release")
        verPath = os.path.join(self.srcPath, '_data','meta.yml')
        version = subprocess.check_output("cat " + verPath, shell=True)
        ver = re.findall(r'(version: )(\d).(\d)(.\d)', version)
        if ver[0][2] == '9':
            newVersion = ver[0][0] + str(int(ver[0][1]) + 1) + ".0" + ".0"
        else:
            newVersion = ver[0][0] + ver[0][1] + "." + str(int(ver[0][2]) + 1) + ".0"
        self.version = re.findall(r'version: (\d.\d.\d)', newVersion)[0]
        with open(verPath, 'w+b') as f:
            f.write(newVersion)
        return None
    # Commit changes and push back to Github with new tags
    def CommitGH(self):
    	# Commit compiled project repo
        os.chdir(self.srcPath)
        os.system("jekyll build --config _config.yml")
        os.chdir(self.cpdPath)
        #try:
        #    os.system("git init . && git remote add origin " + self.compiledRepoOauth)
        #except:
        #    print("Remote origin already exist!")
        #os.system("git pull origin " + self.cpdBranch + " -f")
        os.system("git add * && git commit -m 'Add new post'")
        os.system("git tag -a " + self.version + " -m 'Release new version '" )
        os.system("git push origin master")
        os.system("git push origin --tags")
        # Commit project source repo
        os.chdir(self.srcPath)
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
            time.sleep(self.devInterval*60)
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
            interator = Iteration()
            interator.dev()
            print("A dev action was made!")
        except BaseException as e:
            print(e)
        return None
    elif choice.action == 'staging':
        try:
            interator = Iteration()
            interator.staging()
            print("A release action was made!")
        except BaseException as e:
            print(e)
        return None
    elif choice.action == 'iteration':
        try:
            print("Iteration started!")
            interator = Iteration()
            interator.iterate()
        except BaseException as e:
            print(e)
        return None
    else:
        print("Wrong arguments provided!")
        return None

if __name__ == "__main__":
    main()
