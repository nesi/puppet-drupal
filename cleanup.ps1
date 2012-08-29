echo "Cleaning up template..."
if ((Test-Path 'Modulefile') -and (Test-Path 'manifests/init.pp') -and (Test-Path 'tests/init.pp')){
	echo "Deleting .orig templates..."
	objFSO.DeleteFile('Modulefile.orig')
	objFSO.DeleteFile('manifests/init.pp.orig')
	objFSO.DeleteFile('tests/init.pp.orig')
	objFSO.DeleteFile('README1st.markdown')
	objFSO.DeleteFile('unblank.ps1')
	objFSO.DeleteFile('cleanup.ps1')
} else {
	throw "ERROR: Cannot find required files, have you run unblank.ps1?"
}
if (Test-Path manifests\init.pp){
	del manifests\init.pp.orig
}