#!/bin/bash

readFile="domain.txt"

#读取域名信息
grep -v '^#' ${readFile} | while read line;do 
    # get_domain=$(echo "${line}" | awk -F ':' '{print $1}')
    get_domain=${line}
    port=443
    # 检测端口是否可以telnet
    result=`echo ""|telnet ${line} 443 2>/dev/null|grep "\^]"|wc -l`

    if [[ ${result} -eq 1 ]];then
      END_TIME=$(echo | openssl s_client -servername ${get_domain}  -connect ${get_domain}:${port} 2>/dev/null | openssl x509 -noout -dates |grep 'After'| awk -F '=' '{print $2}'| awk -F ' +' '{print $1,$2,$4 }' )
      echo "${get_domain} : ${END_TIME}"
    fi
done
