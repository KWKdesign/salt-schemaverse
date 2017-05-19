
postgresql_apt_repo:
  pkgrepo.managed:
    - humanname: PostgreSQL
    - name: "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main"
    - dist: jessie-pgdg
    - file: /etc/apt/sources.list.d/postgresql.list
    - key_url: salt://postgresql/files/postgresql-keyring.gpg
    - gpg_check: True
    - require_in:
      - pkg: postgresql

postgresql:
  pkg.installed:
    - name: postgresql
  service.running:
    - enable: True
    - restart: True
    - watch:
      - pkg: postgresql

/etc/postgresql/9.6/main/pg_hba.conf:
  file.managed:
    - contents: |
        local   all             postgres                                peer
        local   all             postgres                                md5
        host    schemaverse     schemaverse     ::1/128                 trust
        host    schemaverse     +players        0.0.0.0/0               md5
        host    schemaverse     +players        ::1/128                 trust

schemaverse_iptables_http:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - source: 0.0.0.0/0
    - dport: 5432
    - proto: tcp
    - save: True

github.com:
  ssh_known_hosts:
    - present
    - user: root
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

http://github.com/KWKdesign/Schemaverse.git:
  git.latest:
    - target: /srv/schemaverse
    - user: root
