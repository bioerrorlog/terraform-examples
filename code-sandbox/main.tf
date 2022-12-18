# map key starting with numbers causes error
locals {
  map_example = {
    key_valid = "abcd"
    123       = "abcd"
    # 123key = "abcd" # Error: Missing key/value separator
    "123key" = "abcd" # OK

    # spaces cause same error
    # 123 key = "abcd" # Error: Missing key/value separator
    "123 key" = "abcd" # OK
  }
}
