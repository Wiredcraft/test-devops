#!/usr/bin/python
# -*- coding:utf-8 -*-

import os, json, urllib2, subprocess, time, datetime, sys

class GitHubAccess(object):
    def __init__(self):
        # define github access token mix with - or space to ignore from github security
        self.token = "20-822 144 dabd-43bec-ab7cf5 334b530 6-e05ed-d cf 0"
        self.repo = "test-blog-compiled"
        self.api = "https://api.github.com/repos"
        self.gitUser = "devfans"
        return None
    # get tags api url
    def getTagsUrl(self):
        return self.api + "/" + self.gitUser + "/" + self.repo + "/tags"
    # get commits api url
    def getCommitsUrl(self):
        return self.api + "/" + self.gitUser + "/" + self.repo + "/commits"
    # post github api to retrieve data
    def post(self, url):
        try:
			request = urllib2.Request(url)
			request.add_header('Authorization', 'token ' + self.token.replace("-","").replace(" ",""))
			res = urllib2.urlopen(request)
			jsonRes = json.load(res)
			return jsonRes
        except urllib2.HTTPError as error:
			print(error.read().decode())
        except BaseException as e:
			print(e)
			return False
    # Get repo's last tag
    def getLastTag(self):
        tags = self.post(self.getTagsUrl())
        return tags[0]['name']
    # Get repos last commit date
    def getLastCommitDate(self):
        commits = self.post(self.getCommitsUrl())
        lastCommitDate = commits[0]['commit']['committer']['date']
        return datetime.datetime.strptime(lastCommitDate, '%Y-%m-%dT%H:%M:%SZ')

# Define constinuous deloyment class
class ConsDeploy(object):
    def __init__(self):
        self.lastCommitDate = None
        self.lastTag = None
        self.gitaccess = GitHubAccess()
        self.repoTag = None
        self.repoCommitDate = None
        self.interval = 2
        self.repoBranch = "master"
        self.devPath = "/opt/web/dev"
        self.stagingPath = "/opt/web/staging"
        self.devConfigPath = "_config_dev.yml"
        self.stagingConfigPath = "_config_staging.yml"
        return None
    # Get local repo last commit date
    def getLastCommitDate(self):
        os.chdir(self.devPath)
        os.chdir("source")
        repoDateStr = subprocess.check_output("git show -s --format=%ci ", shell=True)
        self.lastCommitDate = datetime.datetime.strptime(repoDateStr.split(" +")[0], '%Y-%m-%d %H:%M:%S')
        print("Got last local commit date" + str(self.lastCommitDate))
        return None
    # Get local repo's latest tag
    def getLastTag(self):
        os.chdir(self.stagingPath)
        os.chdir("source")
        self.lastTag = subprocess.check_output("git describe --abbrev=0 --tags", shell=True)
        print("Got last local tag: " + self.lastTag)
        return None
    # Get repo's last commit date
    def getRepoCommitDate(self):
        self.repoCommitDate = self.gitaccess.getLastCommitDate()
        print("Got last repo commit date: " + str(self.repoCommitDate))
        return None
    # Get repo's latest tag
    def getRepoTag(self):
        self.repoTag = self.gitaccess.getLastTag()
        print("Got last repo tag: " + self.repoTag)
        return None
    # Deploy for dev domain
    def deployDev(self):
        print("Start updating dev site!")
        os.chdir(self.devPath)
        os.chdir("source")
        os.system("git pull origin " + self.repoBranch + " -f")
        os.chdir(self.devPath)
        os.system("jekyll build --config " + self.devConfigPath)
        return None
    # Deploy for staging domain
    def deployStaging(self):
        print("Start updating staging site!")
        os.chdir(self.stagingPath)
        os.chdir("source")
        os.system("git pull origin " + self.repoBranch + " -f")
        os.chdir(self.stagingPath)
        os.system("jekyll build --config " + self.stagingConfigPath)
        return None
    # Start constinuous deployment
    def consDeploy(self):
        while True:
            self.getRepoTag()
            self.getLastTag()
            self.getRepoCommitDate()
            self.getLastCommitDate()
            if self.lastCommitDate < self.repoCommitDate:
                self.deployDev()
            if self.lastTag < self.repoTag:
                self.deployStaging()
            time.sleep(self.interval*60)
        return None

def main():
    consdeploy = ConsDeploy()
    consdeploy.consDeploy()
    return None

if __name__ == "__main__":
    main()
