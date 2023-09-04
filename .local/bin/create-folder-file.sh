#!/usr/bin/env sh

create_folder_file() {
    for file_path_info in "$@"; do
        mkdir -p -- "$(dirname -- "$file_path_info")"
        touch -- "$file_path_info"
    done
}
if [ $# -lt 1 ]; then
    echo "Error: Argument missing, please enter the filename with fullpath.";
    exit 0;
fi
