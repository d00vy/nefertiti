# get the release version
if [ $# -eq 0 ]; then
    echo "version is missing from command-line"
    exit 1
fi
version="$1";

# build every platform
gox --ldflags="-X 'main.APP_VERSION=$version'" --os="darwin linux windows" --output="./bin/{{.Dir}}_{{.OS}}_{{.Arch}}"

# create a new release
gh auth login
gh release create v$version
gh release upload v$version ./bin/nefertiti_darwin_amd64
gh release upload v$version ./bin/nefertiti_darwin_arm64
gh release upload v$version ./bin/nefertiti_linux_386
gh release upload v$version ./bin/nefertiti_linux_amd64
gh release upload v$version ./bin/nefertiti_linux_arm
gh release upload v$version ./bin/nefertiti_linux_arm64
gh release upload v$version ./bin/nefertiti_linux_mips
gh release upload v$version ./bin/nefertiti_linux_mips64
gh release upload v$version ./bin/nefertiti_linux_mips64le
gh release upload v$version ./bin/nefertiti_linux_mipsle
gh release upload v$version ./bin/nefertiti_linux_ppc64
gh release upload v$version ./bin/nefertiti_linux_ppc64le
gh release upload v$version ./bin/nefertiti_linux_s390x
gh release upload v$version ./bin/nefertiti_windows_386.exe
gh release upload v$version ./bin/nefertiti_windows_amd64.exe

# fetch the new tag locally after the release
git fetch --tags origin
