# Custom functions
function el { Start-Process -Verb RunAs wt }
Function ng {ngrok http 3000}

# Git stuff
Function thisBranch {git rev-parse --abbrev-ref HEAD}

Function gtpl {git pull}
Function gtps {git push}
Function gtpsf {git push -f}
Function gtpso {git push -u origin HEAD}
Function gts {git status}
Function gta {git add .}
Function gtl {git log -n $args[0]}

# Function gtac {git add . && gitmoji -c}
# Function gtc {gitmoji -c}
Function gtac {git add . && git commit}
Function gtc {git commit}

Function gtca {git add . && git commit --amend}

Function gtb {git branch $args[0]}
Function gtch {git checkout $args[0]}
Function gtchb {git checkout -b $args[0]}
Function gtchdev {git checkout develop}
Function gtchdevsync {
  git checkout develop -f
  git reset --hard HEAD
  git status
}

Function gtrdev {
  $branch= thisBranch
  git checkout develop
  git pull
  git checkout $branch
  git rebase develop
}

Function gtrc {git rebase --continue}
Function gtarc {git add . && git rebase --continue}

Function gtsync {
  git checkout -f develop
  git branch -D main
  git checkout -f main
  git pull
  git remote update origin --prune
  git branch -vv | Select-String -Pattern ": gone]" | % { $_.toString().Split(" ")[2]} | % {git branch -D $_}
  git branch -vv
  git branch -D develop
  git checkout -f develop
  git pull
}

Function gtreset {
  git reset --hard "@{u}"
  git clean -df
  git pull
}


Function squashThis {
  if (!$args[0]) {
    Write-Host "please provide a merge-base branch"
  } else {
    $branch= thisBranch
    $base= git merge-base $branch $args[0]
    git reset --soft $base
    git commit
  }
}

# npm stuff

Function nms {npm start}
Function nnms {start pwsh "-c nms"}
Function nsb {npm run sb}
Function nnsb {start pwsh "-c nsb"}

Function nmd {npm run docz:dev}
Function nnmd {start pwsh "-c nmd"}

Function npmreset {
  npm cache clear --force
  npm i --save --save-dev
}
