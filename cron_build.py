# encoding:utf-8
# python3
# author:huang
from bs4 import BeautifulSoup as BS
from git import Repo
import toml
import time
import subprocess
import os
from threading import Timer
global_pwd = os.getcwd()
if "config.toml" not in os.listdir(global_pwd):
    global_pwd = os.path.split(os.path.realpath(__file__))[0]
assert "config.toml" in os.listdir(global_pwd)


def write_version(v):
    html_path = global_pwd+"/themes/beg/layouts/_default/baseof.html"
    with open(html_path, encoding="utf-8") as html_fobj:
        soup = BS(html_fobj)
    tag = soup.find_all(id="specialflag")[0]
    tag.string = "Site Version %s" % v
    with open(html_path, "wb") as html_fobj:
        html_fobj.write(soup.prettify("utf-8"))


def update_config(flag):
    path = global_pwd + "/config.toml"
    cfg_dict = toml.load(path)
    global_flag = flag
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


def shell_cmd(post_name):
    create_p = ["hugo", "new", "posts/%s.md" % post_name]
    pipeline = "fortune >> %s" % global_pwd+"/content/posts/"+post_name+".md"
    try:
        output = subprocess.check_output(create_p, shell=True)
    except:
        os.mkdir(global_pwd+"/themes/beg/archetypes")
    output = subprocess.check_output(pipeline, shell=True)
    print(output.decode("utf-8"))


def git_operate(v):
    global global_pwd
    repo_ins = Repo(global_pwd)
    untracked = repo_ins.untracked_files
    if len(untracked) > 0:
        repo_ins.index.add(untracked)
    repo_ins.index.commit("Website Version "+v)
    org_ins = repo_ins.remotes.origin
    org_ins.push()


def temporary_tag(v):
    print(
        subprocess.check_output(
            ["git", "tag", "-a", v, "-m", v]
        ).decode("utf-8")
    )
    print(
        subprocess.check_output(
            ["git", "push", "--tags"]
        ).decode("utf-8")
    )


def title_gen(version):
    title = version.split(".")[2]
    return str(int(title)+1)


def staging():
    last_v = update_config("staging")
    write_version(last_v)
    git_operate(last_v)
    time.sleep(5)
    temporary_tag(last_v)


def dev():
    last_v = update_config("dev")
    write_version(last_v)
    shell_cmd(title_gen(last_v))
    git_operate(last_v)


class CycleRun(object):

    def __init__(self, interval, func, *args, **kwargs):
        self._timer = None
        self.function = func
        self.interval = interval
        self.args = args
        self.kwargs = kwargs
        self.is_running = False
        self.start()

    def _run(self):
        self.is_running = False
        self.start()
        self.function(*self.args, **self.kwargs)

    def start(self):
        if not self.is_running:
            self._timer = Timer(self.interval, self._run)
            self._timer.start()
            self.is_running = True

    def stop(self):
        self._timer.cancel()
        self.is_running = False


dev_timer = CycleRun(600, dev)
staging_timer = CycleRun(3600, staging)


if __name__ == "__main__":
    print("Starting...")

