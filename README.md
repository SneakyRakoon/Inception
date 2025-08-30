# Inception

## 📋 Description du projet

**Inception** est un projet d'administration système de l'école 42 qui consiste à créer une mini-infrastructure de services web en utilisant Docker et Docker Compose. Le projet met l'accent sur la containerisation, la virtualisation et la mise en place d'une architecture multi-services sécurisée.

## 🎯 Objectifs pédagogiques

- Approfondir les connaissances en **Docker** et **containerisation**
- Maîtriser **Docker Compose** pour l'orchestration de services
- Comprendre l'architecture **multi-services** et la communication inter-conteneurs
- Mettre en pratique les concepts de **virtualisation** et d'**isolation**
- Appliquer les bonnes pratiques de **sécurité** en infrastructure

## 🏗️ Architecture du projet

### Services obligatoires

| Service       | Container   | Description                                        |
| ------------- | ----------- | -------------------------------------------------- |
| **NGINX**     | `nginx`     | Serveur web avec TLS 1.2/1.3 uniquement (port 443) |
| **WordPress** | `wordpress` | CMS avec PHP-FPM (sans nginx)                      |
| **MariaDB**   | `mariadb`   | Base de données (sans nginx)                       |

### Infrastructure

- **Réseau Docker** personnalisé pour la communication inter-conteneurs
- **2 volumes persistants** :
  - Volume base de données WordPress
  - Volume fichiers du site WordPress
- **Domaine local** : `tsofien-.42.fr` pointant vers l'IP locale
- **Redémarrage automatique** des conteneurs en cas de crash

## 🛠️ Compétences mobilisées

### Technologies

- ![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white) **Docker & Docker Compose**
- ![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black) **Administration système Linux**
- ![NGINX](https://img.shields.io/badge/NGINX-009639?style=flat&logo=nginx&logoColor=white) **Configuration serveur web**
- ![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat&logo=mariadb&logoColor=white) **Gestion base de données**
- ![WordPress](https://img.shields.io/badge/WordPress-21759B?style=flat&logo=wordpress&logoColor=white) **Déploiement CMS**
- ![SSL](https://img.shields.io/badge/SSL/TLS-326CE5?style=flat&logo=letsencrypt&logoColor=white) **Sécurisation HTTPS**

### Concepts techniques

#### 🐳 Containerisation

- Création de **Dockerfiles** optimisés
- Images basées sur **Alpine/Debian** (avant-dernière version stable)
- Gestion des **processus** et **PID 1**
- **Bonnes pratiques** d'écriture Dockerfile

#### 🌐 Réseaux et sécurité

- Configuration **réseau Docker** personnalisé
- **Isolation** des services
- **Chiffrement TLS** 1.2/1.3
- Gestion des **certificats SSL**
- **Variables d'environnement** et secrets

#### 🗄️ Persistance des données

- **Volumes Docker** pour la persistance
- **Mapping** vers `/home/login/data/`
- Sauvegarde et restauration des données

#### ⚙️ Orchestration

- **Docker Compose** pour l'orchestration multi-services
- **Dépendances** entre services
- **Health checks** et redémarrage automatique
- **Makefile** pour l'automatisation

## 📁 Structure du projet

```
inception/
├── Makefile
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        └── bonus/
            └── [services supplémentaires]
```

## 🚀 Installation et utilisation

### Prérequis

- Machine virtuelle avec **Debian 12** ou **Ubuntu**
- **Docker** et **Docker Compose** installés
- Accès **sudo** sur le système

### Démarrage rapide

```bash
# Cloner le projet
git clone [repository] inception
cd inception

# Lancer l'infrastructure
make

# Arrêter les services
make down

# Nettoyer complètement
make fclean
```

### Accès aux services

- **Site WordPress** : `https://login.42.fr`
- **Interface d'administration** : `https://login.42.fr/wp-admin`

## 🎁 Bonus implémentés

- [ ] **Redis Cache** pour WordPress
- [ ] **Serveur FTP** vers le volume WordPress
- [ ] **Site statique** (non-PHP)
- [ ] **Adminer** pour l'administration base de données
- [ ] **Service personnalisé** au choix

## 🔐 Sécurité

### Bonnes pratiques appliquées

- ✅ **Aucun mot de passe** en dur dans les Dockerfiles
- ✅ **Variables d'environnement** pour la configuration
- ✅ **Fichier .env** pour les secrets
- ✅ **Docker secrets** pour les informations sensibles
- ✅ **Utilisateurs non-root** dans les conteneurs
- ✅ **Tag latest interdit**
- ✅ **Connexions chiffrées** uniquement

### Configuration réseau

- **Port 443** uniquement en point d'entrée
- **Protocole HTTPS** avec TLS 1.2/1.3
- **Réseau isolé** entre conteneurs
- **Pas de privilèges** étendus

## 📚 Apprentissages clés

### Administration système

- Configuration et sécurisation de services web
- Gestion des utilisateurs et permissions
- Automation avec Makefile
- Monitoring et logs des services

### DevOps

- Infrastructure as Code avec Docker Compose
- Déploiement reproductible et portable
- Séparation des environnements
- Gestion des secrets et configuration

### Architecture

- Design multi-services
- Communication inter-conteneurs
- Persistance et volumes
- Scalabilité horizontale

## 🎓 Compétences acquises

Ce projet permet de développer une expertise en :

- **🏗️ Architecture logicielle** : Conception d'infrastructures modulaires
- **🔧 Administration système** : Configuration avancée de services Linux
- **🐳 Containerisation** : Maîtrise de Docker et de l'écosystème
- **🔒 Sécurité** : Application des bonnes pratiques de sécurisation
- **⚡ Automatisation** : Scripts et outils de déploiement
- **📊 Monitoring** : Surveillance et debugging d'infrastructure

---

**Auteur** : [SneakyRakoon]
**École** : 42
**Projet** : Inception
**Date** : 2025
