FROM fendouxiong/java18:latest
MAINTAINER  fendouxiong <wuxiaofei8023@gmail.com>

#安装javasdk
RUN yum install -y wget java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-1.b12.el7_4.x86_64" >> /etc/profile.d/java.sh && \
    echo "export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile.d/java.sh && \
    echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile.d/java.sh && \
    source /etc/profile.d/java.sh && \
    yum clean all