# example invocation: coffee init-project.coffe projectName=MyBubuProject

fs = require 'fs'
clc = require 'cli-color'

# returns the value of the given script parameter
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
		console.log clc.green "created folder #{path}"

create folder for folder in folders


# create README file
if not (fs.existsSync 'README.md')
	fs.writeFile 'README.md', "##{projectName}\n## Description"
	console.log clc.green 'created file README'
