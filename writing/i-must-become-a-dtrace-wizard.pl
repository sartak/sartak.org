use Sartak::Blog;

BEGIN { print "title: I Must Become a DTrace Wizard\ndraft: 1\n" }

p { "Once upon a time, I was running [Request Tracker](http://bestpractical.com/rt/)'s tests under Apache and was seeing some odd failures." };

pre {
    outs << 'FAIL';
# Failed test at t/mail/gnupg-reverification.t line 63.
# 'gpg: error reading key: 公開鍵が見つかりません
# '
# doesn't match '(?-xism:public key not found)'
FAIL
};

p { "One of the most difficult parts of debugging is that you must challenge your assumptions. If all of your beliefs about a particular problem were true, then you'd know where the bug is. For me, the assumption that I _didn't_ challenge was that modperl applications pass environment variables (especially `LANG`) to spawned children." };

