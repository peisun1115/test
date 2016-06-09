#!/bin/bash

COPY_ONLY=$1
echo ${COPY_ONLY}
if [[ -z ${COPY_ONLY} ]]; then
  cd alluxio
  mvn -T 2C clean install -Dmaven.javadoc.skip=true -DskipTests -Dlicense.skip=true -Dcheckstyle.skip=true -Dfindbugs.skip=true
  cd ..

  rm -rf alluxio-tar
  cp -r alluxio alluxio-tar
  
  cd alluxio-tar
  rm -rf .git* logs ; cd ..
  
  gtar -czvf alluxio-bin.tar.gz alluxio-tar
fi
  
for i in $(cat ./alluxio/conf/workers); do
	ssh $i 'rm -rf alluxio*'
	scp alluxio-bin.tar.gz $i:/home/ec2-user/
	ssh $i 'tar xvfz alluxio-bin.tar.gz; mv alluxio-tar alluxio '
done

