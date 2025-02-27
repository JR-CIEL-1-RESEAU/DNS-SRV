FROM debian:latest

# Mise à jour des paquets et installation de BIND9
RUN apt-get update && apt-get install -y bind9 bind9utils bind9-doc && rm -rf /var/lib/apt/lists

# Copie des fichiers de configuration
COPY named.conf /etc/bind/named.conf
COPY zones/ /etc/bind/zones/
COPY db.imss.org /etc/bind/db.imss.org
COPY db.imss.org.rev /etc/bind/db.imss.org.rev

# Exposition des ports pour le DNS
EXPOSE 53/udp 53/tcp

# Activation du forwarding et lancement du service
CMD ["named", "-g", "-c", "/etc/bind/named.conf"]
