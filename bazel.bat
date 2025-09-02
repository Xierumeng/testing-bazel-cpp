@echo off
setlocal

set bazelisk_directory=bazelisk\
set bazelisk_file_name=bazelisk-windows-amd64.exe
set bazelisk_version=v1.27.0
set bazelisk_checksum_sha-256=d4b5e1cea61fcdb0bed60f8868c2e37684221b65feae898d1124482cd39ec89e

if not exist %bazelisk_directory% (
    echo "Creating directory: %bazelisk_directory%"
    mkdir %bazelisk_directory%
)

set bazelisk_download_url=https://github.com/bazelbuild/bazelisk/releases/download/%bazelisk_version%/%bazelisk_file_name%

if not exist %bazelisk_directory%\%bazelisk_file_name% (
    echo "Downloading Bazelisk: %bazelisk_download_url%"
    curl -L %bazelisk_download_url% --output %bazelisk_directory%\%bazelisk_file_name%
)

@REM TODO: Figure out how to compare hashes.
certutil -hashfile %bazelisk_directory%\%bazelisk_file_name% sha256

echo ======
echo Running Bazel command: %bazelisk_directory%\%bazelisk_file_name% %*
echo ======

%bazelisk_directory%\%bazelisk_file_name% %*
