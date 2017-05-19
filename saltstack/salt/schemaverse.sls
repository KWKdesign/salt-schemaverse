
postgresql_apt_repo:
  pkgrepo.managed:
    - humanname: PostgreSQL
    - name: deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
    - dist: jessie
    - file: /etc/apt/sources.list.d/psotgresql.list
    - key_url: salt://postgresql/files/postgresql-keyring.gpg
    - gpg_check: True
    - require_in:
      - pkg: postgresql

postgresql:
  pkg.installed:
    - name: postgresql
  service.running:
    - enabled: True
    - restart: True
    - watch:
      - pkg: postgresql
