ifndef REPO_HOME
  $(error "execute 'source ./bin/conf.sh' to configure environment")
endif

.PHONY: doc

all   : doc

doc   :
	@${MAKE} -C ${REPO_HOME}/doc all

clean : 
	@${MAKE} -C ${REPO_HOME}/doc clean

