
from fastapi import FastAPI

app = FastAPI(title="AppStrap Security Service")

@app.get("/health")
def health():
    return {"status": "healthy"}
