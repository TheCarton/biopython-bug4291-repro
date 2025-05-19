from Bio import SeqIO
from BioSQL import BioSeqDatabase
import time
import os

# Wait for MySQL to be ready
time.sleep(10)

server = BioSeqDatabase.open_database(
    driver="pymysql",
    user="root",
    password="12345678",
    host=os.environ.get("MYSQL_HOST", "localhost"),
    db="biosqldb"
)

# Create database if needed
if "orchid" not in server:
    server.new_database("orchid")

db = server["orchid"]

# Load file
count = db.load(SeqIO.parse("ls_orchid.gbk", "gb"), True)

server.commit()
server.close()
