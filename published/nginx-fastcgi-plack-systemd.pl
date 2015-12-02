use Sartak::Blog;

BEGIN { print "title: nginx + FastCGI + Plack + systemd
date: 2015-12-02
" }

p { "One of my backburner projects has been to migrate this here website onto a fresh server. I never want to feel stuck on an old server again, so I've been investing time to make deploying the full sartak.org experience both quick and painless. That means managing all the configuration with the configuration manager I hate the least. Today that happens to be Ansible." };

p { "As part of this betterment, I have decided that the following is no longer an acceptable way to manage web applications:"};

code_snippet 'crontab' => << 'CRON';
$ crontab -l
…
@reboot cd /home/sartak/Sartak-Microblog; screen -dmUS microblog plackup -Ilib -E production -s FCGI --listen /tmp/microblog.sock -a app.psgi
@reboot cd /home/sartak/Sartak-Quotes; screen -dmUS quotes plackup -Ilib -E production -s FCGI --listen /tmp/quotes.sock -a app.psgi
…
CRON

p { "I do admit this setup hasn't caused me much grief (probably thanks to how robust FCGI and Plack are), but it definitely feels like amateur hour. And I'm supposed to be a [respectable professional](https://twitter.com/sartak/status/588708639860469760) here, sheesh." };

p { "Since I'm deploying to the latest Debian, I've decided to give systemd a try. It was a little tricky to find the right incantations but I've smuggled them out just for you." };

p { "Here's what I'm working with here. I've got a small, light-traffic Perl web app called [`Sartak-Microblog`](https://github.com/sartak/Sartak-Microblog). Its code, git repository, and SQLite database all live in `/usr/local/share/Sartak-Microblog`, so that needs to be the current directory from which the app is launched. nginx will serve it up as [`http://micro.sartak.org`](http://micro.sartak.org), talking to Plack's FastCGI handler over a UNIX socket in `/tmp`. This doesn't need to be a Google-scale production. I don't need zero-downtime updates or hot spares or multi-datacenter redundancy. I just want the app to at least _try_ to stay running. Also, letting Plack itself serve my static files is plenty fine by me." };

p { "First, the nginx config. (For those following along at home, replace both instances of `micro.sartak.org` with your domain name)" };

outs_raw << 'NGINX';
<pre class="nginx code_snippet"><span class="synStatement">server</span> {
    server_name <span class="synIdentifier">micro.sartak.org</span>;
    <span class="synStatement">location</span> <span class="synIdentifier">/</span> {
        fastcgi_pass <span class="synIdentifier">unix:/tmp/micro.sartak.org.sock</span>;
        include <span class="synIdentifier">fastcgi_params</span>;
        fastcgi_param <span class="synConstant">SCRIPT_NAME</span> <span class="synIdentifier">""</span>;
    }
}</pre>
NGINX

p { "Next is to convince systemd to keep the app running. Drop this into `/etc/systemd/system/micro.sartak.org.service` (Replace `micro.sartak.org` and `/usr/local/share/Sartak-Microblog`, and possibly also `app.psgi`)" };

code_snippet 'dosini' => << 'INI';
[Unit]
Description=micro.sartak.org
After=network.target

[Service]
ExecStart=/usr/bin/plackup -Ilib -E production -s FCGI --listen /tmp/micro.sartak.org.sock -a app.psgi
WorkingDirectory=/usr/local/share/Sartak-Microblog
Restart=on-failure

[Install]
WantedBy=multi-user.target
INI

p { "Tell systemd to use this new config:" };

code_snippet 'bash' => << 'BASH';
$ systemctl enable /etc/systemd/system/micro.sartak.org.service
BASH

p { "And finally, have systemd start the web app now:" };

code_snippet 'bash' => << 'BASH';
$ systemctl start micro.sartak.org
BASH

p { "Now when you reboot the machine, the app will be launched automatically. And if the app dies (perhaps it was an accident, perhaps you `kill -9`'d it), it will be restarted right away." };

p { "Sure beats `screen` in a `crontab`." };

