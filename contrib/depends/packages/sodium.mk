package=sodium
$(package)_version=1.0.16
$(package)_download_path=https://download.libsodium.org/libsodium/releases/
$(package)_file_name=libsodium-$($(package)_version).tar.gz
$(package)_sha256_hash=eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533
$(package)_patches=fix-whitespace.patch

define $(package)_set_vars
$(package)_config_opts=--enable-static --disable-shared
$(package)_config_opts+=--prefix=$(host_prefix)
$(package)_config_opts_android=RANLIB=$($(package)_ranlib) AR=$($(package)_ar) CC=$($(package)_cc)
$(package)_config_opts_darwin=RANLIB="$(host_prefix)/native/bin/x86_64-apple-darwin11-ranlib" AR="$(host_prefix)/native/bin/x86_64-apple-darwin11-ar" CC="$(host_prefix)/native/bin/$($(package)_cc)"
endef

define $(package)_config_cmds
  ./autogen.sh &&\
  patch -p1 < $($(package)_patch_dir)/fix-whitespace.patch &&\
  $($(package)_autoconf) $($(package)_config_opts) AR_FLAGS=$($(package)_arflags)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_postprocess_cmds
  rm lib/*.la
endef
