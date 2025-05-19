# Biopython Bug #4291 Reproduction

This repo contains a minimal, Dockerized reproduction of [Biopython issue #4291](https://github.com/biopython/biopython/issues/4291), which triggers a SQL syntax error during BioSQL record loading.

## 🔧 Environment

- Biopython 1.81 (from source)
- Python 3.9.7
- MySQL 5.5.62
- BioSQL schema: `biosqldb-mysql.sql`

## 📦 Contents

- `Dockerfile` – sets up Python + Biopython + deps
- `docker-compose.yml` – starts MySQL + test container
- `biosql-schema.sql` – required schema
- `test.py` – minimal example script
- `ls_orchid.gbk` – example input file
- `biopython/` – local checkout at `biopython-181`

## 🚀 How to Use

```bash
git clone https://github.com/yourusername/biopython-bug4291-repro
cd biopython-bug4291-repro
docker-compose build --no-cache
docker-compose up
