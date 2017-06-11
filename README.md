# Axel – DevOps Assignment

This repository is made of two parts:
- the static website (`axel-hello` directory)
- the Ansible playbook to automatically deploy the website on a server (`ansible` directory)

## Static website

The static website was made using Jekyll.

The built website can be found at `axel-hello/_site`.

The version of the website is stored in `axel-hello/_config.yml` and is displayed in the footer.

### Development

If you wish to bring modifications to the website, you can run the following commands to automatically re-build the website on any new change and serve it at http://localhost:4000 (note that you need to have `ruby` installed):

```
git clone https://github.com/axelchalon/test-devops
cd test-devops/axel-hello
gem install bundler
bundle
jekyll serve
```

### Script

The static website comes with `axel-hello/script`, a shell script that you can call using:
 - `./script dev`
 
   Make sure you have [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) installed before running this command.
   This will:
     - create a new post, with the current date and time in the title and permalink (slug), and the output of the `fortune` command as contents of the post.
     - increment the version number by 0.0.1 in `_config.yml`
     - build the website (update `axel-hello/_site`)
     - commit and push
     
 - `./script staging`
 
   This will:
     - increment the version number by 0.1.0 in `_config.yml`
     - build the website (update `axel-hello/_site`)
     - commit, tag the commit with the version number, and push

## Ansible Playbook (automatic deployment)

The Ansible Playbook found in `ansible` will:
 - set up your server with all the necessary dependencies to fetch, serve and build the static website
 - fetch the static website from the repository and serve it in two different environments, `dev` and `staging`, each one accessible from a specific hostname (modify them to suit your needs at `ansible/host_vars/axel-hello.yml`)
 - fetch from the repository every 5 minutes, and update `dev` on a new commit, `staging` on a new tag
 - run `script dev` every 10 minutes
 - run `script staging` every hour
 
This was tested on a server with Ubuntu 16.04.

I used the Ansible Playbook to deploy the website on a Digital Ocean droplet:
 - http://dev.findingbeauty.in
 - http://staging.findingbeauty.in 
 
### How-to
Here are the steps to follow to use the Ansible Playbook to deploy the website and run the automated tasks on your server:
 - Install Ansible on your computer
 - Modify or create the Ansible `hosts` file (`/etc/ansible/hosts`) and add the following line:
   ```
   axel-hello ansible_ssh_host=ENTER_YOUR_SERVER_IP_ADDRESS_HERE ansible_user=ENTER_YOUR_SERVER_USERNAME_HERE ansible_ssh_private_key_file=ENTER_THE_PATH_TO_YOUR_PRIVATE_KEY_HERE
   ```
 - Install Python on the machine you want to deploy to.
 - Modify `dev_hostname` and `staging_hostname` in `ansible/host_vars/axel-hello.yml` with domain names that are pointed to your machine.
 - Navigate to the `ansible` directory of this repository: `cd ansible`
 - Run the playbook: `ansible-playbook deploy.yml`
 - You will be asked for your GitHub credentials: they will be used by the server to commit to the repository. **Your credentials will be stored in plaintext on the server in ~/.netrc**
 
## Some notes and thoughts

I would have done a few things intuitively a bit differently if the assignment hadn't asked otherwise:
 - Rather than fetching every 5 minutes, I would have used GitHub Webhooks and have a small server listen to new commits and new tags. Setting up Webhooks on GitHub seems to [also be automatable](https://developer.github.com/v3/repos/hooks/).
 - I wouldn't have commited the built website (`axel-hello/_site`) on GitHub.
 - I would have worked with two branches (`dev` and `staging`) on GitHub and simply set up the `dev` environment to be up-to-date with the `dev` branch, and the `staging` environment to be up-to-date with the `staging` branch.
 
Some things that could be improved:
 - You mentioned testing but I don't really know what to test, or what's the best way to test this.

---

I really liked doing this assignment. I hadn't used Jekyll nor Ansible before, and it was great discovering them.

Thank you for your time!
