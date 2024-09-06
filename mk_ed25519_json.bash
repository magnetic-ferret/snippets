mk_ed25519_json() {
  openssl_private_key() { openssl genpkey -quiet -algorithm ed25519; }
  openssl_public_key() { openssl pkey -pubout; }

  wrap_into_json() {
    jq --raw-input --slurp --arg key "${*}" '{$key:@text}';
  }

  openssl_private_key | tee \
    >( openssl_public_key > >(wrap_into_json "public_key") ) \
    > >(wrap_into_json "private_key") \
  | jq -cs add;
}
