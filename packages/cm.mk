# Required CM packages
#PRODUCT_PACKAGES += \
#    Focal \
#    Development \
#    LatinIME \
#    Superuser \
#    su

# Optional CM packages
#PRODUCT_PACKAGES += \
#    VoicePlus \
#    VideoEditor \
#    VoiceDialer \
#    SoundRecorder \
#    Basic

# Extra tools in CM
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync
