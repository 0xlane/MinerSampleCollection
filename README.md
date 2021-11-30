# MinerSampleCollection

1. moneroocean
    - Author: TeamTNT
    - Target: Linux(CentOS)
    - Entry: [moneroocean/moneroocean_miner.sh](moneroocean/moneroocean_miner.sh)
    - Persistence: rc.local, profile, docker, systemd
    - Evasion: kernel-module(diamorphine), clean-history, fake-kernel-process-name(bioset)
    - Clean: [moneroocean/clean_miner.sh](moneroocean/clean_miner.sh)
2. zzd
    - Author: unknown
    - Target: Linux
    - Entry: [zzd/zzd.sh](zzd/zzd.sh)
    - Persistence: unknown
    - Evasion: unknown
    - Clean: nothing
3. pwnrig
    - Author: unknown
    - Target: Linux
    - Entry: unknown
    - Persistence: rc.d, bash_profile, systemd, cron
    - Evasion: upx
    - Clean: [pwnrig/clean_miner.sh](pwnrig/clean_miner.sh)
