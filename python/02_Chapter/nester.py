import sys

#list a list's all elements
def print_lol(the_list, indent=False, level=0, out=sys.stdout):
	for each_item in the_list:
		if isinstance(each_item, list):
			print_lol(each_item, indent, level+1, out)
		else:
			if indent:
				for tab_stop in range(level):
					print("\t",end="", file=out)
			print(each_item, file=out)