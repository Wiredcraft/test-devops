server {
	listen 80;
	listen [::]:80;

	server_name staging.com www.staging.com;

	root /var/www/staging.com;
	index index.html;

	location / {
		try_files $uri $uri/ = 404;
	}
}