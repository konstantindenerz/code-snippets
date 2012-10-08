fs = require 'fs'

folders = [
	'bin'
	'lib'
	'src'
	'scripts'
	'doc'
	'artefacts'
	'package'
]

create = (path) -> 
	if not (fs.existsSync path)
		fs.mkdirSync path
		console.log "created folder #{path}"

create folder for folder in folders
