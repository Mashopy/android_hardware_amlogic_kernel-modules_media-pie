MEDIA_CONFIGS := \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG12=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG2_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MPEG4_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VC1=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H264_MVC=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_H265=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_VP9=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_MJPEG_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_REAL=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS_MULTI=m \
    CONFIG_AMLOGIC_MEDIA_VDEC_AVS2=m \
    CONFIG_AMLOGIC_MEDIA_VENC_H264=m \
    CONFIG_AMLOGIC_MEDIA_VENC_H265=m

MEDIA_CFLAGS := -Wno-error=pointer-sign -Wno-error=frame-larger-than= -Wno-error=missing-braces -Wno-pointer-sign -Wno-unused-but-set-variable

obj-m += media.o

all: modules strip

modules:
	$(MAKE) -C $(KERNEL_SRC) M=$(M)/drivers ARCH=$(ARCH) CROSS_COMPILE="$(CROSS_COMPILE)" EXTRA_CFLAGS="$(MEDIA_CFLAGS)" $(MEDIA_CONFIGS) modules

strip:
	modules=$$(find . -type f -name '*.ko'); \
	for f in $$modules; do \
		$(KERNEL_TOOLCHAIN_PATH)strip --strip-unneeded $$f; \
	done;

modules_install:
	@$(MAKE) INSTALL_MOD_STRIP=1 M=$(M)/drivers -C $(KERNEL_SRC) modules_install

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(M)/drivers clean
