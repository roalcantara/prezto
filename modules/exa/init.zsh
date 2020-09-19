#
# Exa
# https://the.exa.website
#
# Authors:
#   roalcantara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

#
# Settings
#
#

# https://the.exa.website/features/colours
# di directories
# ex executable files
# fi regular files
# ln symlinks
# ur,uw,ux user permissions
# gr,gw,gx group permissions
# tr,tw,tx others permissions
# sn the numbers of a file's size
# sb the units of a file's size
# uu user that is you
# un user that is someone else
# gu a group that you belong to
# gn a group you aren't a member of
# ga new file in Git
# gm a modified file in Git
# gd a deleted file in Git
# gv a renamed file in Git
# da a file's date

export EXA_COLORS="\
fi=34:\
di=1;36:\
sn=32:\
sb=32:\
uu=1;36:\
un=38;5;160:\
gu=38;5;40:\
gn=38:5:160:\
bl=38;5;220:\
ur=34:\
uw=1;34:\
ux=1;35:\
ue=1;35:\
ga=36:\
gm=33:\
gd=31:\
gv=33:\
gt=37:\
gr=34:\
gw=1;34:\
gx=1;35:\
tr=34:\
tw=1;34:\
tx=1;35:\
su=37:\
sf=37:\
lc=37:"
