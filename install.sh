#!/bin/sh

#initialize project
initproject () {
    
    npm init
    
    if [ $? -eq 0 ] ;
    then
        
        echo "project created ..."

        echo "creating index.js file "
        sleep 3
        touch index.js 
        touch app.js
        touch .env 
        touch .envexample
        if [ $? -eq 0 ]
        then
            echo "index.js file created"
            sleep 3
            add_dependencies
        else
            echo 'error creating index.js'
        fi
    else
        echo 'error initializing project'
    fi

    
}

folder () {
     echo "this step creates other folders for you"
    read -p "Enter s to skip this step or c to continue:  " OPT
    if [ $OPT = 'c' ]
    then 
        create_Folders
        
    elif [ $OPT = 's' ]
    then
        echo 'done'
    else
        echo 'enter a valid option'
    fi
}

#create additional folders

create_Folders () {
    mkdir $APIFOLDER
    cd $APIFOLDER

    read -p "enter the folders to be created: " FNAME

    echo "creating the following folders " $FNAME
    sleep 2
    
    mkdir $FNAME
    
    for folder in $FNAME
        do

            cd $folder
            touch index.js
            cd ..
            
    done
    sleep 4
    echo "done!!! happy coding"
                
}
#install dependencies
add_dependencies () {
    echo "installing basic dependencies"
    sleep 2
    sudo npm install --save express body-parser dotenv nodemon
    
    echo 'installing babel dependencies'
    npm install --save @babel/runtime
    sleep 3
    echo 'installing dev dependencies'
    npm install --save-dev @babel/cli
    npm install --save-dev @babel/core
    npm install --save-dev @babel/node
    npm install --save-dev @babel/plugin-transform-runtime
    npm install --save-dev @babel/preset-env
    npm install --save-dev babel-loader
     
    echo "dependencies  installed"

}


#setting babel

IndexSetup () {
    echo "setting up index.js ${PWD} "
    sleep 8
    
    echo "
       import express from 'express'
       import bodyParser from 'body-parser'
       

        const app = express()

        app.use(bodyParser.json());
        app.use(bodyParser.urlencoded({extended:false}));
        app.use((req,res,next)=>{
            res.header('Access-Control-Allow-Origin', '*');
            res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization')
            if(req.method ==='OPTIONS'){
                res.header('Access-Control-Allow-Methods', 'POST, PUT, GET, DELETE, PATCH');
                return res.status(200).json({});

            }
            next();
        })


        app.use((req,res,next)=>{
            const error = new Error('NOT FOUND');
            error.status=404;
            next(error)
        })

        app.use((error, req, res, next)=>{
            res.status(error.status||500)
            res.json({
                error:{
                    message: error.message
                }
            })
        })
            
        export{app}
        export default app
    ">>${PWD}/app.js

    if [ $? -eq 0 ] 
    then 
        echo "
                import {} from 'dotenv/config'
                import  {app} from './app'

                app.set('port', process.env.PORT || 3000);

                var server = app.listen(app.get('port'), ()=>{
                console.log(' server listening on port ' + server.address().port);
                });


        ">>${PWD}/index.js
    else
        echo 'something went wrong'
    fi
}


# installs nodejs and npm if not installed
installNode (){
    echo "installing node.js"
    sleep 2
    echo 'fetching node repository'
    sleep 3
    curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
    if [ $? == 0 ]
    then
        echo 'fetching repository'
        sleep 3
        sudo apt install nodejs

        if [ $? -eq 0 ] 
        then
            echo 'node.js installed'
        else
            echo 'problem installing node'
        fi
    else
        echo 'error fetching repository'
    fi
}

APIFOLDER=api

echo " this script will create an empty folder and initiate a nodejs project in it "
read -p "enter yes to continue and no to quit: " OPTION
if [ $OPTION =  'yes' -o  $OPTION =  'y' -o $OPTION = 'Y' -o $OPTION = 'YES' ];
then
    
            
    if ! type nodejs > /dev/null;
    then
        echo "node not installed ...."
        echo "installing nodejs ...."
        sleep 3
        installNode
        sleep 3

        initproject
    else
        
        initproject
        if [ $? -eq 0 ] 
        then
            folder

            cd ..

            IndexSetup
        else
            echo ' error creating additonal folders'
        fi

    fi


elif [ $OPTION = "no" -o $OPTION = "n" -o $OPTION = "N" -o $OPTION = "NO" ]
then
    echo 'quit'
else
    echo 'enter a valid argument'
fi


 