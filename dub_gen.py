## os operations
import os

## get the current directory
current_directory = os.getcwd()
## store the contents of the current directory.
current_directory_contents = os.listdir(current_directory)

## pare down the contents to just those directories that start with a number
demo_directories = []

for directory in current_directory_contents:
    if directory.startswith(tuple("0123456789")):
        demo_directories.append(directory)

dub_script_start = '{\n	"authors": [\n\
		"Ron Tarrant"\n\
	],\n\
	"configurations": [\n'

dub_script_end = '	],\n\
	"copyright": "Copyright © 2024, Ron Tarrant",\n\
	"dependencies": {\n\
		"gtk-d": "~>3.10.0",\n\
	},\n\
	"description": "A project with multiple executable configurations",\n\
	"license": "proprietary",\n\
	"name": "my-project"\n\
}\n\
'

config_01 = '		{\n\
			"mainSourceFile": "'

config_02 = '",\n\
			"name": "'

config_03 = '",\n\
			"targetName": "'

config_04 = '",\n\
			"targetType": "executable"\n\
		},\n'

config_final = '",\n\
			"targetType": "executable"\n\
		}\n'


## step into each directory and create a dub.json file
for directory in demo_directories:
    build_dir = directory[4:]
    ## clear the variables that will be used to create the scripts
    dub_script = ""
    configurations = ''
    ## create and sort a list of all the .d code files in the current directory
    files_in_cwd = os.listdir(directory)
    source_files = []
        
    for file in files_in_cwd:
        if file.endswith(".d"):
            source_files.append(file)

    source_files.sort()
    
    ## create a list of build configurations for the current directory
    for ordinal, file in enumerate(source_files):
        build_name = file[:-2]
        if ordinal == len(source_files):
            configurations += config_01 + file + config_02 + build_dir + str(ordinal) + config_03 + build_name + config_final
        else:
            configurations += config_01 + file + config_02 + build_dir + str(ordinal) + config_03 + build_name + config_04

    dub_script = dub_script_start + configurations + dub_script_end
    print(dub_script)
    print("\n\n\n")
    
    with open(directory + "/dub.json","w+") as f:
        f.writelines(dub_script)

