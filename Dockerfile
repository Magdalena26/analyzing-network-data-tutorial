FROM ubuntu:latest

RUN apt-get update && apt-get install -y python3 \
    python3-pip

RUN pip3 install jupyter

RUN apt-get -qq update; \
    apt-get install -qqy \
        graphviz ruby-graphviz \
        python-pydot python3-pydot python-pygraphviz python3-pygraphviz; \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install pyvis

RUN pip3 install pygraphviz

RUN	pip3 install community

RUN pip3 install pandas

RUN pip3 install networkx

RUN pip3 install matplotlib

RUN pip3 install seaborn

RUN useradd -ms /bin/bash jupyter

USER jupyter

ADD analyzing_network_data_tutorial.ipynb quakers_edgelist.csv quakers_nodelist.csv /home/code/

USER root

RUN chown -R jupyter:jupyter /home/code
RUN chmod 755 /home/code

USER jupyter

# Set the container working directory to the user home folder
WORKDIR /home/code

# Start the jupyter notebook
CMD jupyter notebook --no-browser --ip 0.0.0.0 --port 8888 /home/code
