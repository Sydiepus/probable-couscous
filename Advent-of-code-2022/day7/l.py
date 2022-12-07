import os
from os.path import join, getsize
dirs_dict = {}

#We need to walk the tree from the bottom up so that a directory can have easy
# access to the size of its subdirectories.
for root, dirs, files in os.walk('aoc',topdown = False):

    # Loop through every non directory file in this directory and sum their sizes
    size = sum(getsize(join(root, name)) for name in files) 

    # Look at all of the subdirectories and add up their sizes from the `dirs_dict`
    subdir_size = sum(dirs_dict[join(root,d)] for d in dirs)

    # store the size of this directory (plus subdirectories) in a dict so we 
    # can access it later
    my_size = dirs_dict[root] = size + subdir_size

    print('%d %s'%(my_size,root))