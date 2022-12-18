# map key starting with numbers causes error
locals {
  map_example = {
    key_valid = "abcd" # OK
    123       = "abcd" # OK
    # 123key = "abcd" # Error: Missing key/value separator
    "123key" = "abcd" # OK
    key123   = "abcd" # OK

    # spaces cause same error
    # 123 key = "abcd" # Error: Missing key/value separator
    "123 key" = "abcd" # OK
  }
}
