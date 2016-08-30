server {
	listen 80;
	listen [::]:80;

	server_name dev.com www.dev.com;

	root /var/www/dev.com;
	index index.html;

	location / {
		try_files $uri $uri/ = 404;
	}
}