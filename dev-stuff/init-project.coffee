# example invocation: coffee init-project.coffee projectName=MyBubuProject

fs = require 'fs'
path = require 'path'
color = require 'cli-color'

# returns the value of the given script parameter
get = (parameterName) ->
	key = "#{parameterName}="
	args = process.argv.slice 2
	return arg.replace(key, '') for arg in args when arg.indexOf(key) is 0

projectName = get 'projectName'

# create directories

directories = [
	'bin'
	'lib'
	'src'
	'scripts'
	'doc'
	'artefacts'
	'package'
  'test'
]

mk = (dir) ->
	if not (fs.existsSync dir)
		fs.mkdirSync(dir)
		fs.writeFileSync path.join(dir, '.initproject'), ''
		console.log color.green "created folder #{dir}"

mk dir for dir in directories

# create files 

files =
	'README.md': "##{projectName}\n## Description"
	'doc/TODO_Dependencies.md': "##{projectName}\n## Dependencies"

write = (file, text) ->
	if not (fs.existsSync file)
		fs.writeFileSync file, text
		console.log color.green "created file #{file}"

write file, text for file, text of files

