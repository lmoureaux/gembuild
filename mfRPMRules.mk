# Created with insights from
## amc13/config/mfRPMRules.mk
## xdaq/config/mfRPM.rules
## xdaq/config/mfBuildRPM.rules
## xdaq/config/mfSetupRPM.rules
## xdaq/config/mfExternRPM.rules

RPMBUILD_DIR=${PackagePath}/rpm/RPMBUILD

.PHONY: rpm _rpmall
rpm: _rpmall
_rpmall: _all _spec_update _rpmbuild

.PHONY: _rpmbuild
_rpmbuild: _spec_update
	mkdir -p ${RPMBUILD_DIR}/{RPMS/{arm,noarch,i586,i686,x86_64},SPECS,BUILD,SOURCES,SRPMS}
	rpmbuild -bb -bl --buildroot=${RPMBUILD_DIR}/BUILD --target ${Arch} --define  "_topdir ${RPMBUILD_DIR}" rpm/${PackageName}.spec
	find  ${RPMBUILD_DIR} -name "*.rpm" -exec mv {} $(PackagePath)/rpm \;


.PHONY: _spec_update	
_spec_update:
	mkdir -p ${PackagePath}/rpm
	cp ${BUILD_HOME}/${Project}/config/specTemplate.spec ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__package__#${Package}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__packagename__#${PackageName}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__version__#$(PACKAGE_VER_MAJOR).$(PACKAGE_VER_MINOR).$(PACKAGE_VER_PATCH)#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__release__#${CMSGEMOS_OS}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__prefix__#/opt/${Package}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__sources_dir__#${RPMBUILD_DIR}/SOURCES#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__packagedir__#${PackagePath}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__os__#${CMSGEMOS_OS}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__platform__#None#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__project__#${Project}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__author__#${Packager}#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__summary__#None#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__description__#None#' ${PackagePath}/rpm/${PackageName}.spec
	sed -i 's#__url__#None#' ${PackagePath}/rpm/${PackageName}.spec


.PHONY: cleanrpm _cleanrpm
cleanrpm: _cleanrpm
_cleanrpm:
	-rm -r rpm

