import os
from datetime import timedelta

from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager

from dotenv import load_dotenv
from flasgger import Swagger
from app.swagger_config import SWAGGER_CONFIG
from app.routes import api
from app.auth import auth, bcrypt

load_dotenv()

app = Flask(__name__)

# JWT Configuration
app.config["JWT_SECRET_KEY"] = os.getenv(
    "JWT_SECRET_KEY",
    "development-secret-key"
)
swagger = Swagger(
    app,
    config=SWAGGER_CONFIG
)

app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=15)

# Extensions
JWTManager(app)
bcrypt.init_app(app)

# CORS
CORS(
    app,
    resources={
        r"/api/*": {
            "origins": os.getenv(
                "CORS_ORIGIN",
                "http://localhost:5173"
            )
        }
    }
)

# Blueprints
app.register_blueprint(api, url_prefix="/api")
app.register_blueprint(auth, url_prefix="/api/auth")


@app.route("/")
def home():
    return {
        "message": "AI Customer Support Agent API is running"
    }


@app.route("/health")
def health():
    return {
        "status": "healthy",
        "service": "AI Customer Support Agent"
    }


if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))

    app.run(
        host="0.0.0.0",
        port=port,
        debug=os.getenv("NODE_ENV") == "development"
    )