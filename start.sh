#!/usr/bin/env bash

if [ ! -e "./currentenv.sh" ]
then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.3/install.sh | bash
    ~/.nvm/nvm.sh
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install 4.2.0
    nvm alias ghosted 4.2.0
    nvm use ghosted
    cd ghost
    npm install
    npm install -g coffee-script jsonlint jison jshint js-beautify grunt
    cd ..
    touch ./currentenv.sh
    echo "#!/usr/bin/env bash\nexport NODE_ENV=\"production\"" > ./currentenv.sh
    chmod +x ./currentenv.sh
    chown -R kaaterhaus:kaaterhaus *
fi

./currentenv.sh
cd ghost
nvm exec ghosted node index.js
