

default:
  @just --list

doctor:
  {{flutter}} doctor -v

get:
  {{flutter}} pub get

upgrade:
  {{flutter}} pub upgrade

outdated:
  {{flutter}} pub outdated

analyze:
  {{flutter}} analyze

format:
  {{dart}} format lib

format-check:
  {{dart}} format --set-exit-if-changed lib

test:
  {{flutter}} test

check: get format-check analyze

generate:
  {{dart}} run build_runner build --delete-conflicting-outputs

translations:
  {{dart}} run slang

clean:
  {{flutter}} clean
  {{flutter}} pub get

run device="":
  if [[ -n "{{device}}" ]]; then \
    {{flutter}} run -d "{{device}}"; \
  else \
    {{flutter}} run; \
  fi

build-ios:
  {{flutter}} build ios

ios-pod-install:
  cd ios && {{pod}} install

ios-pod-update:
  cd ios && {{pod}} install --repo-update

ios-build-generic:
  xcodebuild \
    -workspace ios/Runner.xcworkspace \
    -scheme Runner \
    -configuration Debug \
    -sdk iphoneos \
    -destination 'generic/platform=iOS' \
    build \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGN_IDENTITY=

splash:
  dart run flutter_native_splash:create

icon:
  dart run flutter_launcher_icons
