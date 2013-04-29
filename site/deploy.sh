
ghc --make site.hs

if [ $? -eq 0 ]
then
    ./site rebuild
fi

if [ $? -eq 0 ]
then
    rsync --delete --verbose --recursive _site/* chrisyoung@chrisyoung.net:~/webapps/static
else
    echo "rsync failed!"
fi
