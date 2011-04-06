JC = /usr/bin/javac
JAR = /usr/bin/jar
MKDIR = /bin/mkdir -p
SCP = /usr/bin/scp

# Project title
TITLE = 
REMOTE_HOST = 
HADOOP_HOME = ${HOME}/hadoop

# The classes that need compiling
CLASSES = 

all: class_dir classes

classes : $(CLASSES:.java=.class)

%.class: %.java
	$(JC) -classpath $(HADOOP_HOME)/hadoop-0.20.2-core.jar:$(HADOOP_HOME)/lib/commons-cli-1.2.jar -d $(TITLE)_classes $<

class_dir:
	$(MKDIR) $(TITLE)_classes

jar: class_dir classes
	$(JAR) -cvf $(TITLE).jar -C $(TITLE)_classes/ .

send: jar
	$(SCP) $(TITLE).jar $(REMOTE_HOST):

clean:
	$(RM) -r $(TITLE)_classes
	$(RM) $(TITLE).jar