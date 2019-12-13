alias rudif='rubocop -a $(git diff --name-only master...)'
alias tempo='curl http://wttr.in/hamburg'
alias ccat='pygmentize -f terminal256 -O style=native -g'
alias dbrebuild='bundle exec rake db:drop db:create db:migrate; RAILS_ENV=test bundle exec rake db:drop db:create db:migrate;'
alias rmswp='rm -f $(find . -name *.swp) > /dev/null; rm -f $(find . -name *.swo) > /dev/null; rm -f $(find . -name *.sw) > /dev/null; rm -f /var/tmp/*.swp > /dev/null'
alias c='clear'
eval $(thefuck --alias)
alias speedtest='curl -s  https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias vimch='vim -O $(git s | awk "{print \$2}")'
alias dps='docker ps'
alias be='bundle exec'
alias bu='bundle'
alias chrome="open -a \"Google Chrome\""
alias ctags="`brew --prefix`/bin/ctags"
alias dbdocker='docker run -d -e POSTGRES_USER="$USER" -p 5432:5432 -v local-pg:/var/lib/postgresql/data postgres:10.3'
alias rake='noglob bundle exec rake'
alias rib='rubocop -a $(git diff master..  --name-only  | xargs ls -d 2>/dev/null)'
alias cib='git diff master..  --name-only  | xargs ls -d 2>/dev/null'
