#!/usr/bin/env python3

import os
import sys
import subprocess
from datetime import datetime

default_website_dir = 'website'

def add_post(website_dir):
  # make sure posts directory exists
  posts_dir = os.path.join(website_dir, 'content', 'posts')
  if not os.path.exists(posts_dir):
    print(f'Posts directory "{posts_dir}" does not exist')
    sys.exit(1)
  
  # generate title of post based on datetime
  now = datetime.now().strftime('%Y-%m-%d-%H%M%S')
  title = f'Post at {now}'

  # generate random content of post using `fortune`
  try:
    output = subprocess.run('fortune', stdout=subprocess.PIPE)
  except OSError as err:
    print(f'Failed to run command `fortune`: {err}')
    sys.exit(1)

  content = output.stdout.decode('utf-8')

  # save post to markdown file
  filename = f'post-at-{now}.md'
  try:
    file = open(os.path.join(posts_dir, filename), 'w')
    date = datetime.now().astimezone().strftime('%Y-%m-%dT%H:%M:%S%z')
    meta_data = f'---\ntitle: "{title}"\ndate: {date}\ndraft: false\n---\n\n'
    file.write(meta_data)
    file.write(content)
    file.close()
  except OSError as err:
    print(f'Failed to create file "{filename}": {err}')
    sys.exit(1)

  print(f'Generate new post "{filename}" successfully')

  # commit and push to github repo
  try:
    os.chdir(website_dir)
    os.system(f'git add content/posts')
    os.system(f'git commit -m "Add Post {filename}"')
    os.system('git push')
  except OSError as err:
    print(f'Failed to push to git repository: {err}')
    sys.exit(1)


if __name__ == '__main__':
  if len(sys.argv) == 2 and (sys.argv[1] == '-h' or sys.argv[1] == '--help'):
    print(f'Usage: {sys.argv[0]} [website_path] (default path is "website")')
    sys.exit(0)

  if len(sys.argv) == 2:
    website_dir = sys.argv[1]
  else:
    website_dir = default_website_dir

  add_post(website_dir)
