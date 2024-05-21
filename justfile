set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# first recipe is default when just is run without commands

# list
default:
  just --list
# create a new page for the app
mkpage +args:
    py scripts/make_page.py {{args}}
# run flutter clean
clean:
    puro flutter clean
# flutter pub get
get:
    puro flutter pub get
# run flutter clean then pub get
clean-get:
    just clean
    just get
# flutter pub upgrade --major-versions
up-major:
    puro flutter pub upgrade --major-versions
padd +args:
    dart pub add {{args}}
# flutter run -verbose
runv:
    puro flutter run --verbose
bdocker:
    cd web
    docker build -t jellybean-web .
# build app for the specified platform
build +arg:
    just get
    puro flutter build {{arg}}
# package windows using msix
winb:
    just get
    puro dart run msix:create

# flutter upgarde for puro
fup:
    puro flutter upgrade
# run build runner
brun:
    puro dart run build_runner build
# build runner watch
bwatch:
    puro dart run build_runner watch
