function setup() {
  BST__CONFIG_DIR="${TMP_DIR}/config${RANDOM}"
  mkdir -p "${BST__CONFIG_DIR}"
}

function should_print_usage_for_help() {
  local message
  message="$(bst_list_command__run "--help")"

  assertion__status_code_is_success $?
  assertion__string_contains "${message}" "Usage: bst list"
}

function should_fail_for_any_additionnal_command() {
  local message
  message="$(bst_list_command__run "bleh")"

  assertion__status_code_is_failure $?
  assertion__string_contains "${message}" "bst list: illegal command -- bleh"
}

function should_print_simple_projects() {
  echo "cool-project:/home/alone/dev/cool-project" > "$(bst_config__config_file)"
  echo "bowling-kata:/home/alone/dev/kata/bowling-kata" >> "$(bst_config__config_file)"

  result="$(bst_list_command__run)"

  assertion__equal "$(_expected_simple_output)" "${result}"
}

function _expected_simple_output() {
  echo "cool-project at /home/alone/dev/cool-project"
  echo "bowling-kata at /home/alone/dev/kata/bowling-kata"
}

function should_print_projects_with_tags() {
  echo "cool-project:/home/alone/dev/cool-project:java:git:hobby" > "$(bst_config__config_file)"
  echo "bowling-kata:/home/alone/dev/kata/bowling-kata:python:training" >> "$(bst_config__config_file)"

  result="$(bst_list_command__run)"

  assertion__equal "$(_expected_output_with_tags)" "${result}"
}

function _expected_output_with_tags() {
  echo "cool-project at /home/alone/dev/cool-project #java #git #hobby"
  echo "bowling-kata at /home/alone/dev/kata/bowling-kata #python #training"
}
