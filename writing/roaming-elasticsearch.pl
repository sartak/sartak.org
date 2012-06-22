use Sartak::Blog;

BEGIN { print "title: Roaming ElasticSearch\ndraft: 1\n" }

p { "I've been suffering from an unfortunate side effect of ElasticSearch's default configuration for months I finally got annoyed enough to diagnose and fix the problem." };

p { "By default, [ElasticSearch binds to the first **nonloopback** interface](https://github.com/elasticsearch/elasticsearch/issues/185). This is ordinarily what you want for a search server -- you want to let other computers shove data into and rip data out of ElasticSearch. But if you're developing against a local ElasticSearch running on your laptop, that default works against you. The problem is that laptops are roaming mobile devices that connect to multiple different networks. Just in the past day I've connected to two home networks as well as my cellular hotspot. Each time I switched networks I basically broke ElasticSearch. The symptom is:" };

pre {
    outs_raw << 'HEH';
# [Fri Jun 22 14:52:49 2012] Protocol: http, Server: 192.168.1.105:9200
curl -XPOST 'http://127.0.0.1:9200/_bulk?pretty=1' -d ' ... data ... '

Error connecting to '192.168.1.105:9200' : Can't connect to 192.168.1.105:9200 (Operation timed out) (500)
HEH
};

p { "The way I've been dealing with this is violently restarting ElasticSearch so it binds to a sensible interface again. But that's a pain in the ass in a few ways." };

p { "The way you *actually* fix this, I discovered, is by explicitly telling ElasticSearch that you want a loopback interface because you're not an ordinary production server. Edit your ElasticSearch config to include this line:" };

code_snippet yaml => << 'YAML';
    network.host: 127.0.0.1
YAML

p { "If you've installed ElasticSearch from homebrew, use `brew info elasticsearch` to find your config file." };
