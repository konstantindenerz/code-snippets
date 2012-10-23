# This script should be used to process markdown files.
# It creates a directory watcher for current directory.
# The output is written to a file that is named exactly
# like the markdown and is extended with the html extension.
fs = require 'fs'
path = require 'path'
showdown = require 'showdown'
converter = new showdown.converter()

extensions = [
	'.md'
	'.markdown'
	'.mkd'
]


# Process a markdown file
process = (filename)->
	target = "#{filename}.html"
	markdown = fs.readFileSync filename, 'utf8'
	html = converter.makeHtml markdown
	fs.writeFileSync target, html
	console.log "processed #{filename} to #{target}"

# Call-back of the directory watcher
processAllFiles = ()->
	files = fs.readdirSync '.'
	files = files.filter (file)-> (extension for extension in extensions when file.substr(-extension.length) is extension).length > 0
	files = files.map (item, i)-> path.resolve item
	process file for file in files

# Directory watcher on current directory
fs.watch '.', (event, filename)->
	console.log 'dir',event, filename
	setTimeout processAllFiles, 1500


