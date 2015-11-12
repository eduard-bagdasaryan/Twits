#! /bin/bash

users_cnt=7
srv=http://localhost:3001
users="Иванов Петров Сидоров Нельсон_Мандела Трус Балбес Бывалый"
dflt_tok="tok1"
i=1
twit_id=1

for u in $users
do
    tok=tok${i}
    echo  "user[name]=$u" "user[token]=tok${i}"
    curl -d "user[name]=${u}" -d "user[token]=${tok}" ${srv}/users
    for j in `seq $i`
    do
        curl -d "twit[message]=${u}_message_${j}" -H "Authorization: Token token=${tok}" ${srv}/twits
        votes=`shuf -i 1-3 -n 1`
        for((k = 0; k < $votes; k++ )); do
            curl --request PATCH -H "Authorization: Token token=${dflt_tok}" ${srv}/twits/${twit_id}
        done
        twit_id=$((twit_id+1))
    done
    i=$((i+1))
done
