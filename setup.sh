# AWS related. Copy this function to setup a new aws instance.
    alias mm="mvn -Pdeveloper -T 2C clean install -Dmaven.javadoc.skip=true -DskipTests -Dlicense.skip=true -Dcheckstyle.skip=true -Dfindbugs.skip=true"
    sudo yum update
    sudo yum install -y -q java-1.7.0-openjdk-devel.x86_64
    sudo wget 'http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo' -O  /etc/yum.repos.d/epel-apache-maven.repo
    sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    sudo yum install -y apache-maven
    mvn --version
    sudo yum install git
    mkdir -p ~/workspace
    cd ~/workspace
    git clone https://github.com/peisun1115/alluxio.git
    cd alluxio
    mm
    cd
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh

