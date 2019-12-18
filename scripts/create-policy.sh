policy=${1:-apps.policy.hcl}
login=${2}

name=$(echo $policy | sed "s/\..*//")

echo $name
vault policy write ${name} ${policy}

[[ -n ${login} ]] && ./login.sh ${name}
