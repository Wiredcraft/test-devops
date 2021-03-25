The deploy script will generate a new post with given post title or with the date (default value), then the new script will create new branch with post title name, add new post, commit and push it to new remote branch. 


Run hugo server
```
hugo server -D --bind={IP} --baseURL=http://{IP}:{PORT} -v
```

Generate the new post 
```
# with default date(yyyy-mm-dd) as title 
python ./deploy.py

# with given title 
python ./deploy.py -t <title>

```

to check the new post content, visit:
http://{IP}:{PORT}/posts/{Title}/