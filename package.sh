#!/bin/bash

# callback for fetching the raw package data
function h3pkg_script_get_raw () {
	#
	local PUB_PATH="/home/pub/prof/klauck_christoph/VS"

	rsync -aP "${H3PKG_USER}@${H3PKG_REMOTE_HOME}:${PUB_PATH}" "${H3PKG_PACKAGE_HOME}/.cache"

	return $?
}

# callback for building the package
function h3pkg_script_build_package () {
	local raw_base=${H3PKG_PACKAGE_HOME}/.cache/VS
	#
	cd ${H3PKG_PACKAGE_HOME} && {
		rm -rf vs
		mkdir -p vs
		cd vs && {
			mkdir -p doc lab etc

			cp ${raw_base}/abgabe_aivsp.html doc
			cp ${raw_base}/BA_Erlang.pdf doc
			cp ${raw_base}/Entwurf.pdf doc
			#cp ${H3PKG_PACKAGE_HOME}/.cache/VS/ doc
			mkdir -p etc/coulouris
			unzip ${raw_base}/VSloesung_Coulouris.zip -d etc/coulouris
			mkdir -p etc/tanenbaum
			unzip ${raw_base}/VSloesung_Tanenbaum.zip -d etc/tanenbaum

			tar -jcf vs.tar doc lab etc
		}
	}

	return 0
}
