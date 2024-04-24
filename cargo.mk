##
##===============================================================================
##make cargo-*
cargo-help:### 	cargo-help
	@awk 'BEGIN {FS = ":.*?###"} /^[a-zA-Z_-]+:.*?###/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
cargo-release-all:### 	cargo-release-all
## 	cargo-release-all 	recursively cargo build --release
	for t in */Cargo.toml;  do echo $$t; cargo b -r -vv --manifest-path $$t; done
	for t in ffi/*/Cargo.toml;  do echo $$t; cargo b -r -vv --manifest-path $$t; done
cargo-clean-all:### 	cargo-clean-all - clean release artifacts
## 	cargo-clean-all 	recursively cargo clean --release
	for t in */Cargo.toml;  do echo $$t; cargo clean --release -vv --manifest-path $$t; done
cargo-install-all:### 	cargo-install-all
## 	cargo-install-all 	recursively cargo install -vv $(SUBMODULES)
## 	*** cargo install -vv --force is NOT used.
## 	*** cargo install -vv --force --path <path>
## 	*** to overwrite deploy cargo.io crates.
	for t in $(SUBMODULES); do echo $$t; cargo install -vv gnostr-$$t || echo "gnostr-$$t not found"; done

cargo-b:cargo-build### 	cargo b
cargo-build:### 	cargo build
## 	cargo-build q=true
	@. $(HOME)/.cargo/env
	@cd chat && RUST_BACKTRACE=all cargo b $(QUIET)
.PHONY:chat
chat:cargo-install### 	chat
cargo-i:cargo-install
cargo-install:### 	cargo install --path jj
	#@. $(HOME)/.cargo/env
	@cargo install --path chat
cargo-br:cargo-build-release### 	cargo-br
## 	cargo-br q=true
cargo-build-release:### 	cargo-build-release
## 	cargo-build-release q=true
	@. $(HOME)/.cargo/env
	@cd chat && cargo b --release $(QUIET)
cargo-c:cargo-check
cargo-check:### 	cargo-check
	@. $(HOME)/.cargo/env
	@cd chat && cargo c
cargo-bench:### 	cargo-bench
	@. $(HOME)/.cargo/env
	@cd chat && cargo bench
cargo-t:cargo-test
cargo-test:### 	cargo-test
	@. $(HOME)/.cargo/env
	#@cargo test
	@cd chat && cargo test -p jj-cli --test runner
cargo-report:### 	cargo-report
	@. $(HOME)/.cargo/env
	cd chat && cargo report future-incompatibilities --id 1

cargo-deps-gnostr-all:cargo-deps-gnostr-cat cargo-deps-gnostr-cli cargo-deps-gnostr-command cargo-deps-gnostr-grep cargo-deps-gnostr-legit cargo-deps-gnostr-sha256### 	cargo-deps-gnostr-all
cargo-deps-gnostr-cat:### 	cargo-deps-gnostr-cat
	rustup-init -y -q --default-toolchain $(TOOLCHAIN) && \
    source "$(HOME)/.cargo/env" && \
    cd deps/gnostr-cat && $(MAKE) cargo-build-release cargo-install
    ## cargo $(Z) deps/gnostr-cat install --path .
cargo-deps-gnostr-cli:### 	cargo-deps-gnostr-cli
	cargo -Z unstable-options  -C deps/gnostr-cli install --path .
cargo-deps-gnostr-command:### 	cargo-deps-gnostr-command
	cargo -Z unstable-options  -C deps/gnostr-command install --path .
cargo-deps-gnostr-grep:### 	cargo-deps-gnostr-grep
	cargo -Z unstable-options  -C deps/gnostr-grep install --path .
cargo-deps-gnostr-legit:### 	cargo-deps-gnostr-legit
	cargo -Z unstable-options  -C deps/gnostr-legit install --path .
cargo-deps-gnostr-sha256:### 	cargo-deps-gnostr-sha256
	cargo -Z unstable-options  -C deps/gnostr-sha256 install --path .
##===============================================================================

# vim: set noexpandtab:
# vim: set setfiletype make
