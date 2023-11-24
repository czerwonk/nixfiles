{ pkgs, username, ... }:

{
  environment.systemPackages = [
    pkgs.aide
  ];

  environment.etc."aide.conf".text = ''
    database_in=file:/var/lib/aide/aide.db.gz
    database_out=file:/var/lib/aide/aide.db.new.gz

    gzip_dbout=yes

    report_url=stdout
    report_url=file:/var/log/aide.log

    FIPSR = p+i+n+u+g+s+m+c+acl+selinux+xattrs
    DEFAULT = FIPSR+sha512
    PERMS = p+i+u+g+acl+selinux

    /etc                               DEFAULT
    /bin                               DEFAULT
    /usr/bin                           DEFAULT
    /run/current-system/bin            DEFAULT
    /run/current-system/sw/bin         DEFAULT
    /home/${username}/.nix-profile/bin DEFAULT

    # excludes
    !/var/log/.*
    !/var/spool/.*
  '';
}
