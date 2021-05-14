## Automatically Generate Posts for Hugo Static Website

### Create Hugo Website

Firstly, make sure `hugo`, `fortune` and `python3`
have been installed on the system.

To create a new site, run `hugo new site my-website`.
Before starting hugo server, we need to configure the
website theme.

```sh
cd my-website
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo 'theme = "ananke"' >> config.toml
mkdir content/posts
```

Now we can start the hugo server, simply run `hugo server`
and then open `http://localhost:1313/` on your browser.
You can see there is no posts there, we will use the Python script
to generate posts automatically later.

### Setup Git Repository

Since the Python script will also commit and push the new generated
posts to remote git repository, we need to create that git repository
and push code to Github first.

```sh
git init
git add .
git commit -m'first commit'
git remote add origin https://github.com/joekyo/hugo-static-site.git
git push origin master
```

### Run the Script

Make sure that the script `add_post.py` and the website directory
are under same directory, then we can execute the script.

```sh
chmod +x add_post.py
./add_post.py my-website
```

We can see there is output message like
`Generate new post "post-at-2021-05-13-155043.md" successfully`.
Visit `http://localhost:1313/` and there is new post generated.
The new generated file will also be committed and pushed to Github.

We can also run this script in a loop. For example, to generate
new post every 5 seconds automatically.

```sh
while ./add_post.py my-website; do sleep 5; done
```

Press `ctrl c` to exit the loop.
