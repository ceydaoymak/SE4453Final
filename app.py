from flask import Flask
import psycopg2
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os


app = Flask(__name__)

vault_url = "https://se4453finalvault.vault.azure.net/"
credential = DefaultAzureCredential()
client = SecretClient(vault_url=vault_url, credential=credential)

db_host = client.get_secret("DBHOST").value
db_user = client.get_secret("DBUSER").value
db_pass = client.get_secret("DBPASS").value
db_name = client.get_secret("DBNAME").value

def get_connection():
    return psycopg2.connect(
        host=db_host,
        user=db_user,
        password=db_pass,
        dbname=db_name,
        sslmode='require'
    )

@app.route("/")
def index():
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()[0]
        cur.close()
        conn.close()
        return f"✅ CONNECTED. PostgreSQL VERSION: {version}"
    except Exception as e:
        return f"❌ ERROR: {str(e)}"

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    app.run(host="0.0.0.0", port=port)
