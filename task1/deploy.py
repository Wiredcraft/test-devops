#!/usr/bin/env python
# -*- coding:utf-8 -*-
import subprocess
import logging
import argparse

import settings


logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

def subprocess_print(cmd):
    """ print subprocess input and execution output
    :param cmd: The input cmd
    :return: The execution result
    """
    logging.info(cmd) 
    res = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    output, error = res.communicate()
    if int(res.returncode) == 0:
        if output :
            logging.info(output)
        return output
    elif int(res.returncode) != 0 and output:
        raise Exception("Return code: {}".format(res.returncode), output)
    elif error:
        raise Exception("Return code: {}".format(res.returncode), error)


def genereate_new_post(hugo_bin_path, web_base_path, web_post_path, post_title):
    """generate new random post content with fortune
    :param hugo_bin_path: The post title 
    :param post_title: The post title 
    :return: the new post abs path
    """
    post_path = subprocess_print("cd {} && {} new {}/{}.md".format(web_base_path, 
                            hugo_bin_path, web_post_path, post_title)).split()[0]
    subprocess_print("fortune >> {}/{}".format(web_base_path, post_path))

    return "{}/{}".format(web_base_path, post_path)


def commit_new_post(github_folder, github_url, title, post_path):
    """commit new post on the new title branch
    :param github_folder: The post title 
    :param github_url: The post title 
    :param title: The post title 
    :param post_path: The post file path 

    """
    subprocess_print("rm -rf {github_folder} && git clone {github_url} {github_folder} && git checkout -b {title}"
                    .format(github_folder = github_folder, github_url = github_url, title = title))
    subprocess_print("cp {} {}/posts/".format(post_path, github_folder))
    subprocess_print("cd {} && git add posts/".format(github_folder))
    subprocess_print("cd {github_folder} && git commit -m 'add new post {title}' && git push origin {title}"
                    .format(github_folder = github_folder, title = title))


if __name__ == '__main__':
    
    parser = argparse.ArgumentParser()
    parser.add_argument( "-t", dest="title", help = "new test title, the default value will be date as 2021-03-24")
    args = parser.parse_args()
    if args.title:
        title = args.title
    else:
        title = subprocess_print("date '+%Y-%m-%d'").rstrip()

    post_path = genereate_new_post(settings.WEB_CONFIG["HUGO_BIN_PATH"], settings.WEB_CONFIG["WEB_BASE_PATH"],
                        settings.WEB_CONFIG["WEB_POST_PATH"], title)

    commit_new_post(settings.GITHUB_CONFIG["GITHUB_FOLDER"], settings.GITHUB_CONFIG["GITHUB_URL"], title, post_path)