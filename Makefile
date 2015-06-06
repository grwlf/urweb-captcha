# This Makefile was generated by the Cake3
# https://github.com/grwlf/cake3

GUARD = .cake3/GUARD_$(1)_$(shell echo $($(1)) | md5sum | cut -d ' ' -f 1)

ifeq ($(MAIN),1)
unexport MAIN

# Main section

URWEB = urweb
UWCC = $(shell $(shell $(URWEB) -print-ccompiler) -print-prog-name=gcc)
UWFLAGS = 
UWINCLUDE = -I$(shell $(URWEB) -print-cinclude)
UWINCLUDEDIR = $(shell $(URWEB) -print-cinclude)/..
UWVER = $(shell $(URWEB) -version)
.PHONY: ./all
./all: ./Makefile ./test/Captcha1.db ./test/Captcha1.exe ./test/Captcha1.sql
./test/Captcha1.db: ./Makefile ./test/Captcha1.exe ./test/Captcha1.sql
	dropdb --if-exists Captcha1
	createdb Captcha1
	psql -f ./test/Captcha1.sql Captcha1
	touch ./test/Captcha1.db
./.cake3/tmp___test_Captcha1_in_2: ./Makefile ./lib.urp ./test/Captcha1.ur
	( \
	echo   ;\
	echo $$\/list  ;\
	echo $$\/char  ;\
	echo $$\/string  ;\
	echo \.\.\/test\/Captcha1  ;\
	) > ./.cake3/tmp___test_Captcha1_in_2
./.cake3/tmp___test_Captcha1_in_1: ./Makefile ./lib.urp ./test/Captcha1.ur
	( \
	echo database\ dbname\=Captcha1  ;\
	echo sql\ \.\.\/test\/Captcha1\.sql  ;\
	echo library\ \.\.\/  ;\
	) > ./.cake3/tmp___test_Captcha1_in_1
./.cake3/tmp___lib_in_2: ./Captcha.h ./Captcha.o ./Makefile
	( \
	echo   ;\
	) > ./.cake3/tmp___lib_in_2
./.cake3/tmp___lib_in_1: ./Captcha.h ./Captcha.o ./Makefile
	( \
	echo ffi\ \.\/Captcha  ;\
	echo include\ \.\/Captcha\.h  ;\
	echo link\ \.\/Captcha\.o  ;\
	) > ./.cake3/tmp___lib_in_1
.PHONY: ./test
./test: ./Makefile ./test/Captcha1.db ./test/Captcha1.exe ./test/Captcha1.sql
.PHONY: ./lib
./lib: ./Makefile ./lib.urp
.INTERMEDIATE: ./.fix-multy1
./.fix-multy1: ./Makefile ./test/Captcha1.urp $(call GUARD,URWEB) $(call GUARD,UWFLAGS) $(call GUARD,UWINCLUDEDIR) $(call GUARD,UWVER)
	C_INCLUDE_PATH=$(UWINCLUDEDIR) $(URWEB) -dbms postgres $(UWFLAGS) ./test/Captcha1
./Captcha.o: ./Captcha.c ./Makefile $(call GUARD,UWCC) $(call GUARD,UWCFLAGS) $(call GUARD,UWINCLUDE)
	$(UWCC) -c $(UWINCLUDE) $(UWCFLAGS)  -o ./Captcha.o ./Captcha.c
./lib.urp: ./.cake3/tmp___lib_in_1 ./.cake3/tmp___lib_in_2 ./Makefile
	cat ./.cake3/tmp___lib_in_1 > ./lib.urp
	cat ./.cake3/tmp___lib_in_2 >> ./lib.urp
./test/Captcha1.exe: ./.fix-multy1
./test/Captcha1.sql: ./.fix-multy1
./test/Captcha1.urp: ./.cake3/tmp___test_Captcha1_in_1 ./.cake3/tmp___test_Captcha1_in_2 ./Makefile
	cat ./.cake3/tmp___test_Captcha1_in_1 > ./test/Captcha1.urp
	cat ./.cake3/tmp___test_Captcha1_in_2 >> ./test/Captcha1.urp
$(call GUARD,URWEB):
	rm -f .cake3/GUARD_URWEB_*
	touch $@
$(call GUARD,UWCC):
	rm -f .cake3/GUARD_UWCC_*
	touch $@
$(call GUARD,UWCFLAGS):
	rm -f .cake3/GUARD_UWCFLAGS_*
	touch $@
$(call GUARD,UWFLAGS):
	rm -f .cake3/GUARD_UWFLAGS_*
	touch $@
$(call GUARD,UWINCLUDE):
	rm -f .cake3/GUARD_UWINCLUDE_*
	touch $@
$(call GUARD,UWINCLUDEDIR):
	rm -f .cake3/GUARD_UWINCLUDEDIR_*
	touch $@
$(call GUARD,UWVER):
	rm -f .cake3/GUARD_UWVER_*
	touch $@

else

# Prebuild/postbuild section

ifneq ($(MAKECMDGOALS),clean)

.PHONY: ./all
./all: ./.fix-multy1
.PHONY: ./test/Captcha1.db
./test/Captcha1.db: ./.fix-multy1
.PHONY: ./.cake3/tmp___test_Captcha1_in_2
./.cake3/tmp___test_Captcha1_in_2: ./.fix-multy1
.PHONY: ./.cake3/tmp___test_Captcha1_in_1
./.cake3/tmp___test_Captcha1_in_1: ./.fix-multy1
.PHONY: ./.cake3/tmp___lib_in_2
./.cake3/tmp___lib_in_2: ./.fix-multy1
.PHONY: ./.cake3/tmp___lib_in_1
./.cake3/tmp___lib_in_1: ./.fix-multy1
.PHONY: ./test
./test: ./.fix-multy1
.PHONY: ./lib
./lib: ./.fix-multy1
.INTERMEDIATE: ./.fix-multy1
./.fix-multy1:
	-mkdir .cake3
	MAIN=1 $(MAKE) -f ./Makefile $(MAKECMDGOALS)
.PHONY: ./Captcha.o
./Captcha.o: ./.fix-multy1
.PHONY: ./lib.urp
./lib.urp: ./.fix-multy1
.PHONY: ./test/Captcha1.exe
./test/Captcha1.exe: ./.fix-multy1
.PHONY: ./test/Captcha1.sql
./test/Captcha1.sql: ./.fix-multy1
.PHONY: ./test/Captcha1.urp
./test/Captcha1.urp: ./.fix-multy1

endif
.PHONY: ./clean
./clean:
	-rm ./.cake3/tmp___lib_in_1 ./.cake3/tmp___lib_in_2 ./.cake3/tmp___test_Captcha1_in_1 ./.cake3/tmp___test_Captcha1_in_2 ./Captcha.o ./lib.urp ./test/Captcha1.db ./test/Captcha1.exe ./test/Captcha1.sql ./test/Captcha1.urp
	-rm -rf .cake3

endif
