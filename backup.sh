
#run script before updating to github

fileList=(~/.tmux.conf ~/.vimrc ~/.bashrc)

for file in "${fileList[@]}"
do
    cp -r ${file} ./
    echo $file
done
