# Task 2

## init the environment

ansible.cfg

```
[defaults]
inventory = hosts
remote_user = user
remote_port = 22
#private_key_file = /Users/egoist/.vagrant.d/insecure_private_key
private_key_file = /Users/egoist/.ssh/id_rsa
host_key_checking = False

pipelining = True
forks = 20
```

playbook.yaml

```
---
- name: deploy web server
  hosts: vagrant1
  gather_facts: True
  become: True
  vars: 
    key_file: /etc/nginx/conf.d/ssl/nginx.key
    cert_file: /etc/nginx/conf.d/ssl/nginx.crt
    conf_file: /etc/nginx/conf.d/discover.conf
    backend:  127.0.0.1:3000
    server_name: www.example.com
  tasks:
    - name: install nginx
      apt: pkg=nginx update_cache=yes cache_valid_time=3600
    - name: remove default config
      file: path={{ item }} state=absent
      with_items:
        - /etc/nginx/sites-available/default
        - /etc/nginx/sites-enabled/default
    - name: create directories for ssl certificates
      file: path=/etc/nginx/conf.d/ssl state=directory
    - name: copy TLS key
      copy: src=files/site.key dest={{ key_file }} owner=root mode=0600
      notify: restart nginx
    - name: copy TLS certificate
      copy: src=files/site.crt dest={{ cert_file }} 
      notify: restart nginx
    - name: copy nginx configure file
      copy: src=files/nginx.conf dest=/etc/nginx/nginx.conf
      notify: restart nginx
    - name: copy configure file
      template: src=templates/server.conf.j2 dest={{ conf_file }}
      notify: restart nginx
  handlers:
  - name: restart nginx
    service: name=nginx state=restarted

- name: deploy postgres database
  hosts: vagrant1
  become: True
  gather_facts: True
  vars:
    ext_port: 5432
    db_data: website
    db_pass: <we can use vault here>
  tasks:
    - name: install docker
      apt: pkg={{ item }} update_cache=yes
      with_items:
        - docker
        - docker.io
    - name: create data directory
      file:
        path: "/data/{{ db_data }}"
        state: directory
    - name: start postgresql container
      ignore_errors: yes
      shell: >
        docker run -p {{ ext_port }}:5432 --name discoverdb -v /data/{{ db_data }}:/var/lib/postgresql/data -e POSTGRES_USER={{ db_data }} -e POSTGRES_PASSWORD={{ db_pass }} -e POSTGRES_DB={{ db_data }} -h {{ db_data }} --restart always -d postgres:9.6

```

server.conf.j2

```
server {
    listen     443 ssl;
    listen  	 80;
    server_name  {{ server_name }};
    client_max_body_size    20m;
    ssl on;
    ssl_certificate {{ cert_file }};
    ssl_certificate_key {{ key_file }};
    ssl_verify_client off;

    location / {
        proxy_pass http://{{ backend }};
        proxy_set_header host $host;
        proxy_set_header x-real-ip $remote_addr;
	      proxy_set_header x-forwarded-for $proxy_add_x_forwarded_for;
	}
}
```

nginx.conf

```
user www-data;
worker_processes auto;
worker_rlimit_nofile 1998600;
pid /run/nginx.pid;

events {
	worker_connections 65535;
	use epoll;	
	multi_accept on;
	accept_mutex on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	types_hash_max_size 2048;
	keepalive_timeout 45;
	client_header_timeout 30;
	reset_timedout_connection on;
	send_timeout 20;
	server_tokens off;

	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;
	ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 10m;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;
	gzip_disable "msie6";

	# gzip_vary on;
	gzip_proxied any;
	gzip_comp_level 6;
	gzip_buffers 16 8k;
	gzip_min_length 1000;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
```



db backup **Skip**