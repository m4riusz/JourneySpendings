if which swiftlint >/dev/null; then
  swiftlint --path ${SRCROOT} --config ${SRCROOT}/.swiftlint.yml --fix
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi