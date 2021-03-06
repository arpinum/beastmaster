create_config_dir_for_tests() {
  BST_CONFIG_DIR="${TMP_DIR}/config${RANDOM}"
  mkdir -p "${BST_CONFIG_DIR}"
  touch "${BST_CONFIG_DIR}/config"
}

create_project_dir_for_test() {
  local directory="${TMP_DIR}/${RANDOM}/$1"
  mkdir -p "${directory}"
  echo "${directory}" >> /tmp/test
  system__print "${directory}"
}
