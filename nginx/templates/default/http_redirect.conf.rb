server {
    listen       80;
    rewrite ^(.*) https://$host$1 permanent;
}
