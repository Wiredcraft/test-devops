### Prerequisites

- VirtualBox
- Vagrant
- Ansible
- Git
- Edit `hosts` file (`/etc/hosts` in OS X / Linux) in host machine. (If there is an ip conflict, change it accordingly and make sure `private_network` in `Vagrantfile` use the same ip)

```
# append
192.169.233.10 dev.com www.dev.com
192.169.233.10 staging.com www.staging.com
```

### Run

- clone this repo

- `vagrant up`

- waite script to finish ...

- open `http://dev.com` and `http://staging.com` in browser using `private mode` (in case of browser cache)

#### Notes

- some `cdn files` (used by `hugo theme`) may be blocked by `GFW`, use `Proxy / VPN`.
