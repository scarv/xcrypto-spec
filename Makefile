.PHONY: doc

all   : doc

doc   :
	@${MAKE} -C ${REPO_HOME}/doc all

clean : 
	@${MAKE} -C ${REPO_HOME}/doc clean

