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
    - Movement: unknown
    - Clean: nothing
3. pwnrig
    - Author: unknown
    - Target: Linux
    - Entry: unknown
    - Persistence: rc.d, bash_profile, systemd, cron
    - Evasion: upx
    - Movement: unknown
    - Clean: [pwnrig/clean_miner.sh](pwnrig/clean_miner.sh)
4. JSBot
    - Author: unknown
    - Target: Windows
    - Entry: [JSBot/net.xsl](JSBot/net.xsl), [JSBot/networks.xsl](JSBot/networks.xsl)
    - Persistence: ScheduledTask, WmiEventSubscription, AppInit_DLLs, Service, ProcessInjection
    - Evasion: obfuscation, fileless, lolbin, encryption
    - Movement: pth, ms17010
    - Clean: nothing
