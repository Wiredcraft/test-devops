# encoding:utf-8
# author:huang
import argparse
from bs4 import BeautifulSoup as BS


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


def write_version(html_path, v):
    with open(html_path, encoding="utf-8") as html_fobj:
        soup = BS(html_fobj)
    tag = soup.find_all(id="specialflag")[0]
    tag.string = "Site Version %s" %v
    with open(html_path, "wb") as html_fobj:
        html_fobj.write(soup.prettify("utf-8"))


if __name__ == "__main__":
    write_version("/Users/admin/quickstart/themes/beg/layouts/_default/baseof.html")
    pass
