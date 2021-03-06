server {
    listen         80 default_server;
    listen         [::]:80 default_server;
    server_name    example.com www.example.com;
    root           /var/www/html/example.com/public_html;
    index          index.html;
 
    location / {
      try_files $uri $uri/ =404;
    }
 
    location ~* \.php$ {
      fastcgi_pass unix:/run/php/php7.2-fpm.sock;
      include         fastcgi_params;
      fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
      fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }
}
