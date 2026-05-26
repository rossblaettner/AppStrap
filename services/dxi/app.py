
from fastapi import FastAPI

app = FastAPI(title="AppStrap DXI Service")

@app.get("/health")
def health():
    return {"status": "healthy"}
