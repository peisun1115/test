# AWS related. Copy this function to setup a new aws instance.
    mm="mvn -Pdeveloper -T 2C clean install -Dmaven.javadoc.skip=true -DskipTests -Dlicense.skip=true -Dcheckstyle.skip=true -Dfindbugs.skip=true"
    sudo apt-get install maven
    sudo apt-get install "openjdk-7-jre"
    mkdir -p ~/workspace
    cd ~/workspace
    git clone https://github.com/peisun1115/alluxio.git
    cd alluxio
    ${mm}
    cd
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    git config --global user.email "peis@alluxio.com"
    git config --global user.name "Pei Sun"
