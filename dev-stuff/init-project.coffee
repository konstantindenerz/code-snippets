# A little script that can be used to generate
# initial folder structure for development projects.
# Example invocation: coffee init-project.coffee projectName=MyBubuProject

fs = require 'fs'
path = require 'path'
color = require 'cli-color'

# returns the value of the given script parameter
get = (parameterName) ->
	key = "#{parameterName}="
	args = process.argv.slice 2
	return arg.replace(key, '') for arg in args when arg.indexOf(key) is 0

projectName = get 'projectName'

# An array of directories that should be created.

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

# Create given directory. Each empty directory gets a dotfile. Currently the design of the git index (staging area) only permits files to be listed.
mk = (dir) ->
	if not (fs.existsSync dir)
		fs.mkdirSync(dir)
		fs.writeFileSync path.join(dir, '.initproiject'), ''
		console.log color.green "created folder #{dir}"

mk dir for dir in directories

# Files / placeholder that should be created.
files =
	'README.md': "##{projectName}\n## Description"
	'doc/TODO_Dependencies.md': "##{projectName}\n## Dependencies"

# Create files with given content.
write = (file, text) ->
	if not (fs.existsSync file)
		fs.writeFileSync file, text
		console.log color.green "created file #{file}"

write file, text for file, text of files

