
from fastapi import FastAPI

app = FastAPI(title="AppStrap Registry Service")

@app.get("/health")
def health():
    return {"status": "ok"}
