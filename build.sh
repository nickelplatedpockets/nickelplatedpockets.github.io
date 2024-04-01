#!/bin/bash -li

# Iterate over all pages.
for _file in `find . -type f -name "*.md"`; do
	[ -f "$_file" ] || break # Exit loop if no matching file
	file="${_file%.md}.html"
	rm $file
	touch $file
	echo "${file} ${_file}"
	pandoc --standalone --template "$PWD/templates/header.html" $_file >> $file
	if [[ $_file == *"/posts/"* ]]; then
		echo "${_file} contains posts"
		pandoc --standalone --template "$PWD/templates/post.html" $_file >> $file
	else
		echo "${_file}"
		pandoc --standalone --template "$PWD/templates/content.html" $_file >> $file
	fi
	pandoc --standalone --template "$PWD/templates/footer.html" $_file >> $file
done

# For each page, run a set of pandoc conversions from markdown to html
# if the initial file is markdown, obviously.
# Do this in such a way that the file is an amalgamation of outputs.

