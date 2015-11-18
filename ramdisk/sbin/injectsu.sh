#!/system/bin/sh

mount -o remount,rw /system

#Auto-Root SuperSU
if [ ! -f /system/xbin/su ]; then

	#extract SU from ramdisk to correct locations
	rm -rf /system/bin/app_process
	rm -rf /system/bin/install-recovery.sh
	cp /sbin/su/supolicy /system/xbin/
	cp /sbin/su/su /system/xbin/
	cp /sbin/su/libsupol.so /system/lib64/
	cp /sbin/su/install-recovery.sh /system/etc/

	#begin supersu install process
	cp /system/xbin/su /system/xbin/daemonsu
	cp /system/xbin/su /system/xbin/sugote
	cp /system/bin/sh /system/xbin/sugote-mksh
	mkdir -p /system/bin/.ext
	cp /system/xbin/su /system/bin/.ext/.su

	cp /system/bin/app_process64 /system/bin/app_process_init
	mv /system/bin/app_process64 /system/bin/app_process64_original

	echo 1 > /system/etc/.installed_su_daemon

	chmod 755 /system/xbin/su
	chmod 755 /system/xbin/daemonsu
	chmod 755 /system/xbin/sugote
	chmod 755 /system/xbin/sugote-mksh
	chmod 755 /system/xbin/supolicy
	chmod 777 /system/bin/.ext
	chmod 755 /system/bin/.ext/.su
	chmod 755 /system/bin/app_process_init
	chmod 755 /system/bin/app_process64_original
	chmod 644 /system/lib64/libsupol.so
	chmod 755 /system/etc/install-recovery.sh
	chmod 644 /system/etc/.installed_su_daemon
	
	ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh
	ln -s /system/xbin/daemonsu /system/bin/app_process
	ln -s /system/xbin/daemonsu /system/bin/app_process64

	/system/xbin/su --install
fi

#Auto-Busybox (injects busybox if not present)
if [ ! -f /system/xbin/busybox ]; then
	cp /sbin/busybox /system/xbin/
	chmod 755 /system/xbin/busybox
	/system/xbin/busybox --install -s /system/xbin
fi

#Auto-Kills knox and security/software checking related apps
rm -rf /knox_data
rm -rf /system/container
rm -rf /system/tima_measurement_info
rm -rf /system/app/BBCAgent
rm -rf /system/app/Bridge
rm -rf /system/app/KnoxAppsUpdateAgent
rm -rf /system/app/KnoxAttestationAgent
rm -rf /system/app/KnoxFolderContainer
rm -rf /system/app/KnoxSetupWizardClient
rm -rf /system/app/RCPComponents
rm -rf /system/app/SamsungIRMService
rm -rf /system/app/SecurityLogAgent
rm -rf /system/app/SwitchKnoxI
rm -rf /system/app/SwitchKnoxII
rm -rf /system/app/UniversalMDMClient
rm -rf /system/priv-app/AdaptClient
rm -rf /system/priv-app/DiagMonAgent
rm -rf /system/priv-app/FotaClient
rm -rf /system/priv-app/FWUpdateService
rm -rf /system/priv-app/KLMSAgent
rm -rf /system/priv-app/SPDClient
rm -rf /system/priv-app/SyncmlDM

