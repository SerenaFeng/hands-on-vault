source env.sh

vault login ${ROOT_TOKEN}
if [[ $@ == *"wrap"* ]]; then
  export WRAPPING=$(vault token create -policy=$@ | grep "wrapping_token: " | awk '{print $2}')
  echo "login as $@ with wrap token ${WRAPPING}"
  token=${WRAPPING}
elif [[ $# != 0 ]]; then
  export TOKEN=$(vault token create -policy=$@ | grep "token " | awk '{print $2}')
  echo "login as $@ with token ${TOKEN}"
  token=${TOKEN}
fi

[[ -n ${token} ]] && vault login $token
