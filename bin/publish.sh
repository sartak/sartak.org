mkdir -p work
GIT_WORK_TREE=work/ git checkout -f
cd work
perl -Ilib bin/generate.pl ~/sartak.org
