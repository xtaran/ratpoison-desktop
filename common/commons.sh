# Define some functions
wh() {
    which "$1" > /dev/null
}
whe() {
    wh "$1" && "$@"
}
whee() {
    wh "$1" && exec "$@" &
}
