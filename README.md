# Hukku

a web application to sf.jp git repositories to github

## Usage

$ git clone --bare --mirror git://hoge.git.sourceforge.net/gitroot/hoge/ hoge.git
$ cd hoge.git
$ git remote add github git@github.com:fuga/hoge.git
$ git config remote.github.mirror true

set web hook in sf.jp repository

