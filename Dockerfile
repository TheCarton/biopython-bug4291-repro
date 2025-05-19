# Required base image — this is your "build stage"
FROM python:3.9.7

# Set non-interactive for any installs
ENV DEBIAN_FRONTEND=noninteractive

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    default-libmysqlclient-dev \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy your local Biopython source into the container
COPY biopython /biopython
# ... We're using biopython-181 to reproduce https://github.com/biopython/biopython/issues/4291

# Copy BioSQL schema file
COPY biosql-schema.sql /biosql-schema.sql

# Install Biopython from local source
RUN pip install /biopython

# Install MySQL and PyMySQL Python dependencies
RUN pip install mysqlclient pymysql

# Set working directory for the test script
WORKDIR /app

# Copy test script and input file
COPY ls_orchid.gbk test.py ./

# Run: wait → load schema → run test
CMD ["sh", "-c", "sleep 10 && mysql -h mysql -u root -p12345678 biosqldb < /biosql-schema.sql && python /app/test.py"]
