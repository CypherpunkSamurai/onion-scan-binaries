# Makefile to generate go binaries for platforms

# Configs
GOCMD=go
# Go commands
GO_BUILD=$(GOCMD) build
GO_GET=$(GOCMD) get
GO_TEST=$(GOCMD) test
GO_CLEAN=$(GOCMD) clean
GO_MOD_INIT=$(GOCMD) mod init
GO_MOD_TIDY=$(GOCMD) mod tidy

# Binary
BINARY_NAME=onionscan
WINDOWS_X86_BINARY=$(BINARY_NAME)_win_x32.exe
WINDOWS_X64_BINARY=$(BINARY_NAME)_win_x64.exe
LINUX_X86_BINARY=$(BINARY_NAME)_linux_x32
LINUX_X64_BINARY=$(BINARY_NAME)_linux_x64
MACOS_X64_BINARY=$(BINARY_NAME)_mac_x64




.PHONY:all
all: go_init tidy build

go_init:
	if [ ! -z "go.mod" ]; then ${GO_MOD_INIT} onionscan; fi;

tidy: go.mod
	rm ${BINARY_NAME}_* -fr
	${GO_CLEAN}
	${GO_MOD_TIDY}

# Build for all platforms
build: build_windows_i386 build_windows_amd64 build_linux_i386 build_linux_amd64 build_macos_amd64

build_windows_i386:
	ls
	@echo [!] Builing Windows x32 binary....
	${GO_BUILD} -o ${WINDOWS_X86_BINARY} .

build_windows_amd64:
	@echo [!] Builing Windows x64 binary....
	GOOS=windows GOARCH=amd64 ${GO_BUILD} -o ${WINDOWS_X64_BINARY} .

build_linux_i386:
	@echo [!] Builing Linux x32 binary....
	GOOS=linux GOARCH=386 ${GO_BUILD} -o ${LINUX_X86_BINARY} .

build_linux_amd64:
	@echo [!] Builing Linux x64 binary....
	GOOS=linux GOARCH=amd64 ${GO_BUILD} -o ${LINUX_X64_BINARY} .

build_macos_amd64:
	@echo [!] Builing MacOS x64 binary....
	GOOS=darwin GOARCH=amd64 ${GO_BUILD} -o ${MACOS_X64_BINARY} .
