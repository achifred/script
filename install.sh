#!/bin/sh

#packagename = "node"
initproject () {
    cd $DIR

    npm init
    echo "project created ..."
    
    echo "creating index.js file "
    sleep 3
    touch index.js .env .envexample

    echo "index.js file created"

    add_dependencies
}

create_Folders () {
    mkdir $APIFOLDER
    cd $APIFOLDER

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
add_dependencies () {
    echo "installing basic dependencies"
    sleep 2
    npm install --save express 
    echo "express installed"

}
APIFOLDER=api

echo " this script will create an empty folder and initiate a nodejs project in it "
read -p "enter yes to continue and no to quit: " OPTION
if [ $OPTION =  'yes' -o  $OPTION =  'y' -o $OPTION = 'Y' -o $OPTION = 'YES' ];
then
    read -p "enter directory:  " DIR
    echo "creating directory $DIR"
    sleep 2
   

    if [ ! -d "$DIR" ]
        then
            mkdir $DIR
            echo "directory created"
            if ! type nodejs > /dev/null;
            then
                echo "node not installed ...."
                echo "installing nodejs ...."

                initproject
            else
                initproject

            fi

            
            echo "this step creates other folders for you"
            read -p "Enter s to skip this step or c to continue:  " OPT
            if [ $OPT = 'c' ]
            then
                read -p "enter the folders to be created: " FNAME
                
                # creating additional folders
                create_Folders
                
              
            elif [ $OPT = 's' ]
            then
                echo 'done'
            fi

    else
        echo "errorcreating folder directory already exist"
    fi
    

elif [ $OPTION = "no" -o $OPTION = "n" -o $OPTION = "N" -o $OPTION = "NO" ]
then
    echo 'quit'
else
    echo 'enter a valid argument'
fi


 