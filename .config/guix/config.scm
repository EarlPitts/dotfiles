(use-modules (gnu))
(use-modules (gnu packages shells))
(use-modules (nongnu system linux-initrd))
(use-modules (nongnu packages linux))
(use-service-modules syncthing ssh desktop)
(use-package-modules backup suckless wm xorg certs emacs emacs-xyz)

(define %my-ssh-public-keys
  (string-join
    '("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG0I7mCXvflOhCgmdXxxH6rJfkFNM0Dk+BR53ivVuG80kwpiwZfWreuep9YxvK0Vt0uefEbzViDqKtLgGLN/7Z1iyHzeHt0tsdUBz7cyHq5ryF+rq0ANWvGCOKYnAkCvt3Vc7AmT3qSIHUFKpLyQD9Hs2IGrcYirHUNLOGncmaeGWPS35pLF0dG8I8WDZTKfOS5bf4a5Ux5X/XS8gep+pwZSEoBL+QB4rCTggbjB5Mjh4nG9Szc8jHj8Ml91r0g00HxQRRfIR70WZdDXEc4We/aXOFEytfjMoBJGD2uw/PCEbQ42glAl/CjhUyQmTsaawrS2KS5xoUX+slvbYSbcgqfmKQC5utsWrCIF1MsU7BjM8aZ3t7YX0kb5xyXFJBhg72FIi9zp+IVciVuvDAxv4pXI+RIH1GybXHTeqqFDkD/KPyxoQuIScaiOQHZkBuaJSvVtDtG4zP7TCd5b43QLfg7WTa2kv9aVSlQYugWEcPydMfrQSt0ssLdSPXqazXjXhRroFLuHlwajtRVg9MyRphULnC8AyRMYN1G8WKV/rLmN3Kuh/DTOh8m15ggFPc+mebq/rk6ujRS7IDfSEauyn4zGeqj2DAOP4FPwVSiOzn+FusXFoiYvl/hTH6hoHBHOmiJSQ3PrunjRm7DoduJmLnFJAFu1q+LQmjUTxrMIzngQ== k2sy12@inf.elte.hu"
      "\n")))

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (host-name "guix")
  (timezone "Europe/Budapest")
  (locale "en_US.utf8")

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets '("/dev/sda"))))
  (file-systems (cons (file-system
                        (device (file-system-label "root"))
                        (mount-point "/")
                        (type "ext4"))
                      %base-file-systems))

  ;; This is where user accounts are specified.  The "root"
  ;; account is implicit, and is initially created with the
  ;; empty password.
  (users (cons (user-account
                (name "obabo")
                (group "users")
		(shell (file-append zsh "/bin/zsh"))
                (supplementary-groups
		  '("wheel" "audio" "video")))
	       %base-user-accounts))

  (packages
    (cons* i3-wm i3status dmenu emacs st nss-certs borg %base-packages))

  (services
    (append (list (service openssh-service-type
			   (openssh-configuration
                 (permit-root-login 'without-password)
                 (password-authentication? #f)
                 (authorized-keys
                   `(("root", (plain-file "authorized_keys"
                                          %my-ssh-public-keys))
                     ("obabo", (plain-file "authorized_keys"
                                           %my-ssh-public-keys))))))
		  (service syncthing-service-type
			   (syncthing-configuration (user "obabo"))))
	    %desktop-services)))
