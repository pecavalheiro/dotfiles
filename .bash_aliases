alias tempo='curl http://wttr.in/porto-alegre'
alias ccat='pygmentize'
alias ctrails='ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'
alias dbrebuild='rake db:drop; rake db:create; rake db:migrate; RAILS_ENV=test rake db:drop; RAILS_ENV=test rake db:create; RAILS_ENV=test rake db:migrate;'
alias rmswp='rm $(find -name *.swp) 2>&1 /dev/null; rm $(find -name *.swo) > /dev/null; rm $(find -name *.sw) > /dev/null'
alias irrs='kill -9 $(cat tmp/pids/server.pid); RAILS_ENV=test bundle exec rake db:integration_reset && RAILS_ENV=test bundle exec rails s -b 127.0.0.1 -p 3001'
alias c='clear'
eval $(thefuck --alias)
alias tmux="TERM=screen-256color-bce tmux"
alias speedtest='curl -s  https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
