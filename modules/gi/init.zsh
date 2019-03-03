#
# Allow access the gitignore.io API
#
# Authors:
#   Rogério R. Alcantara <rogerio.alcantara@gmail.com>
#

# Add a function to the environment
function gi() { curl -sLw "\n" https://www.gitignore.io/api/\$@ ;}
