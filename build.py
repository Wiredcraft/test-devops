# encoding:utf-8
# author:huang
from bs4 import BeautifulSoup as BS
from git import Repo
import toml
import argparse
import subprocess
import os
os_args = argparse.ArgumentParser(
    prog="build tool",
    description="Development Task in Python"
)
os_args.add_argument(
    "command",
    help='''
        dev:
            1.create new post with some setting in yaml
            2.output of fortune command as content
            3.configure version and compile the website
            4.posts and website file will be pushed to github
        staging:
            1.increment the big version
            2.configure and compile
            3.posts and website file will be pushed to github
    '''
)
global_flag = os_args.parse_args().command
global_pwd = os.getcwd()
assert "config.toml" in os.listdir(global_pwd)


def write_version(html_path, v):
    with open(html_path, encoding="utf-8") as html_fobj:
        soup = BS(html_fobj)
    tag = soup.find_all(id="specialflag")[0]
    tag.string = "Site Version %s" % v
    with open(html_path, "wb") as html_fobj:
        html_fobj.write(soup.prettify("utf-8"))


def update_config(path):
    cfg_dict = toml.load(path)
    global global_flag
    if "version" in cfg_dict:
        ary = cfg_dict["version"].split(".")
        if global_flag == "dev":
            ary[2] = str(int(ary[2]) + 1)
        if global_flag == "staging":
            ary[1] = str(int(ary[1]) + 1)
        cfg_dict["version"] = ".".join(ary)
    else:
        cfg_dict["version"] = "0.0.1"
    with open(path, "w") as fobj:
        toml.dump(cfg_dict, fobj)
    return cfg_dict["version"]


def shell_cmd(cmd_ary):
    global_pwd
    try:
        path_fd = os.open()
        os.fchdir(path_fd)
    except IOError:
        return False
    output = subprocess.check_output(cmd_ary)
    return output


def git_operate(v):
    global global_pwd
    repo_ins = Repo(global_pwd)
    untracked = repo_ins.untracked_files
    if len(untracked) > 0:
        repo_ins.index.commit(untracked)
    repo_ins.index.commit("Website Version "+v)
    org_ins = repo_ins.remotes.origin
    org_ins.push()


if __name__ == "__main__":
    version = update_config("/Users/admin/quickstart/config.toml")
    write_version(
        "/Users/admin/quickstart/themes/beg/layouts/_default/baseof.html",
        version
    )
