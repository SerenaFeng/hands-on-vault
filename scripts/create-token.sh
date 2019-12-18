
if [[ $@ == *"wrap"* ]]; then
  export WRAPPING=$(vault token create -policy=$@ | grep "wrapping_token: " | awk '{print $2}')
  echo "the wrap token of $1 is ${WRAPPING}"
else
  export TOKEN=$(vault token create -policy=$@ | grep "token " | awk '{print $2}')
  echo "the token of $1 is ${TOKEN}"
fi
