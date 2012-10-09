fs = require 'fs'
path = require 'path'
showdown = require 'showdown'
converter = new showdown.converter()

extensions = [
	'.md'
	'.markdown'
	'.mkd'
]


# process markdown
process = (filename)->
	target = "#{filename}.html"
	markdown = fs.readFileSync filename, 'utf8'
	html = converter.makeHtml markdown
	fs.writeFileSync target, html
	console.log "processed #{filename} to #{target}"

processAllFiles = ()->
	files = fs.readdirSync '.'
	files = files.filter (file)-> (extension for extension in extensions when file.substr(-extension.length) is extension).length > 0
	files = files.map (item, i)-> path.resolve item
	process file for file in files


fs.watch '.', (event, filename)->
	console.log 'dir',event, filename
	setTimeout processAllFiles, 1500


