#!/usr/bin/env bash

# 获取时间
get_datetime(){
  local time=$(date  "+%Y%m%d%H%M%S")
  echo "$time"
}
# 查看文件是否存在
function file_is_exist ()
{
  local filename=$1
  if [[ -f $filename ]]
  then
    return 1
  else
   return 0
  fi
}

# 查看目录是否存在
function path_is_exist ()
{
  local path=$1
  if [[ -d $path ]];then
    return 1
  else 
    return 0
  fi
}

# 复制文件到指定目录。如何有同名文件选择是否覆盖
file_backup(){
  if [[ $# -ne 2 ]];then
    echo "Usage: file_backup require 2 arguments"
    echo "args1: file_path"
    echo "args2: backup_path"
    return 1
  fi

  local file_path=$1
  local backup_path=$2
  echo "file_path = $file_path"
  echo "backup_path = $backup_path"

  file_is_exist "$file_path"
  local is_exist=$?
  if [[ $is_exist -ne 1 ]];then
    echo "$file_path is not exist"
    return 1
  fi
  path_is_exist "$backup_path"
  is_exist=$?
  if [[ $is_exist -ne 1 ]];then
    echo "$backup_path is not exist"
    return 1
  fi
  
  local time=$(get_datetime)
  local filename=$(basename $file_path)
  echo "filename = $filename"
  local filepath_d="${backup_path}/${filename}"
  echo "filepath_d : $filepath_d"
  # #
  file_is_exist "$filepath_d"
  is_exist=$?
  if [[ $is_exist -ne 0 ]]; then
    local back_file_name="${filename}_${time}"
    local back_file_path="${backup_path}/${back_file_name}"
    echo "filename = $filename"
    echo "back_file_path = $back_file_path"

    read -p "Find "$filename" ,backup "$filename" to "$back_file_name" [Y/N]" ch
    if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
      cp "$filepath_d" "$back_file_path"
    fi
  fi
  cp "$file_path" "$filepath_d"
}

main()
{
  file=/home/cube/Myproject/Mis-semester/05/myconfig/tmux/tmux.conf
  d_path=/home/cube/Myproject/Mis-semester/05/myconfig
  file_backup "$file" "$d_path"
}

# 测试代码

test(){
  time=$(get_datetime)
  echo "$time"
}

main
