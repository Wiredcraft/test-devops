#!/bin/bash
# Generate random content to post
# set -ex


cd `dirname $0`/TimeLordFangTest
#pwd

postGenerateTime=$(date "+%Y%m%d%H%M%S")
postName="RandomGenerate-${postGenerateTime}"
new_result=$(hugo new posts/${postName}.md)
post_path=$(echo $new_result |cut -d " " -f 1)

# generate content 
fortune >>  $post_path

# change draft to false
sed -i '' 's/^draft: true/draft: false/g' $post_path # for macOS 
#sed -i  's/^draft: true/draft: false/g' $post_path

# generate static file
hugo -D
if [ $? -eq 0 ]
then 
git add ./ 
git commit -am 'add new random post'
git push 
else
echo "Generate Static File Failed , CHECK content "
fi
