# AWS related. Copy this function to setup a new aws instance.
    mm="mvn -Pspark -T 2C clean install -Dmaven.javadoc.skip=true -DskipTests -Dlicense.skip=true -Dcheckstyle.skip=true -Dfindbugs.skip=true"
    sudo yum -y update
    sudo yum install -y -q java-1.7.0-openjdk-devel.x86_64
    sudo wget 'http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo' -O  /etc/yum.repos.d/epel-apache-maven.repo
    sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
    sudo yum install -y apache-maven
    mvn --version
    sudo yum install -y git
    mkdir -p ~/workspace
    cd ~/workspace
    git clone https://github.com/Alluxio/alluxio.git
    cd alluxio
    git checkout v1.1.1
    ${mm}
    cd
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh

cd ~
curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
sudo yum -y install sbt
git clone https://github.com/peisun1115/spark-sql-perf.git
cd spark-sql-perf
sbt assembly
