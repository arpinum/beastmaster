function should_print_usage_for_help() {
  local message
  message="$(bst_config_command__run "--help")"

  assertion__status_code_is_success $?
  assertion__string_contains "${message}" "Usage: bst config"
}

function should_fail_for_any_additionnal_command() {
  local message
  message="$(bst_config_command__run "bleh")"

  assertion__status_code_is_failure $?
  assertion__string_contains "${message}" "bst config: illegal command -- bleh"
}

function should_open_config_file_in_editor() {
  EDITOR=_mock_editor
  BST__CONFIG_DIR="${TMP_DIR}/config${RANDOM}"

  result="$(bst_config_command__run)"

  assertion__equal "editor called with: ${BST__CONFIG_DIR}/config" "${result}"
}

function _mock_editor() {
  echo "editor called with: $@"
}
