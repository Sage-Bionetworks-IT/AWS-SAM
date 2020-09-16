FROM homebrew/brew
RUN sudo apt-get update

# From https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-linux.html
# Step 5
RUN brew tap aws/tap
RUN brew install aws-sam-cli
ENV BREW_DIR /home/linuxbrew/.linuxbrew
ENV BREW_BIN ${BREW_DIR}/bin
RUN echo "eval \$($(${BREW_BIN}/brew --prefix)/bin/brew shellenv)" >>~/.profile

# Python doesn't work unless we do this
ENV HOMEBREW_CELLAR ${BREW_DIR}/Cellar
RUN echo "export LD_LIBRARY_PATH=${HOMEBREW_CELLAR}/python@3.7/3.7.9/lib">>~/.profile

# System can't find sam executable unless we do this
ENV SAM_DIR ${HOMEBREW_CELLAR}/aws-sam-cli/1.2.0
RUN ln -s ${SAM_DIR}.reinstall ${SAM_DIR}    
RUN ln -s ${SAM_DIR}/bin/sam ${BREW_BIN}/sam

# ensure that bash loads .profile on start up
CMD /bin/bash -il
