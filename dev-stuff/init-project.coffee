fs = require 'fs'
clc = require 'cli-color'

get = (parameterName) ->
	key = "#{parameterName}="
	args = process.argv.slice 2
	return arg.replace(key, '') for arg in args when arg.indexOf(key) is 0

projectName = get 'projectName'

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
		console.log clc.green("created folder #{path}")

create folder for folder in folders


# create README file
fs.writeFile 'README.md', "##{projectName}\n## Description"
