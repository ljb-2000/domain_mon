#!/bin/bash
#初始变量初始化
db_host="localhost"
db_user="test"
pass_wd="test"
db_default="url_mon"
###函数定义区域
sql_exec(){
    ###定义了使用sql的方法###
    sql=$@
    mysql -u${db_user} -p${pass_wd} -h ${db_host} -N ${db_default} -e "${sql}"
}
check_one_url(){
    ###定义了检查一个url的方法，网页包含关键词的话，就返回0，否则返回0###
    url=$1
    key=$2
    curl ${url} 2>/dev/null | grep -q "${key}"
    echo $?
}
get_url_old_status(){
    ###获取ID的历史状态###
    id=$1
    sql_cmd="select status_code from status_code where ID = ${id}"
    echo $(sql_exec ${sql_cmd})
}
status_2_sql(){
    ###根据ID把状态写会数据库###
    ID=$1
    st_code=$2
    sql_cmd="update status_code set status_code = ${st_code} where ID =${ID} and rep_point = '192.168.31.105';"
    sql_exec ${sql_cmd}
}
main(){
    ###业务逻辑###
     sql_exec "select * from montior_url" | while read ID t_url t_location t_method t_keyword t_post_data t_fail_time
     do 
        url="http://${t_url}${t_location}"
        status_code=$(check_one_url "${url}" "${t_keyword}")
        last_code=$(get_url_old_status ${ID})
        re_code=$((${status_code} * ${last_code} + ${status_code}))
        status_2_sql ${ID} ${re_code}
 done
}

main