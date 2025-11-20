# 🚀 Quick Deployment Checklist - Azure Portal

## Before You Start
```bash
# 1. Build frontend locally (REQUIRED!)
cd frontend
npm install
npm run build
cd ..

# 2. Verify static folder exists
ls -la static/
```

## Azure Portal Steps

### 1️⃣ Create Web App
- Portal → Create Resource → Web App
- **Runtime:** Python 3.11 (Linux)
- **SKU:** B1 (Basic) for testing, P1V2 for production
- **Name:** Choose unique name (becomes your URL)

### 2️⃣ Required Settings (Configuration → Application settings)
```
AZURE_OPENAI_RESOURCE = your-resource-name
AZURE_OPENAI_MODEL = gpt-35-turbo-16k
AZURE_OPENAI_KEY = your-key-here
AZURE_OPENAI_PREVIEW_API_VERSION = 2024-05-01-preview
AUTH_ENABLED = False (for testing only!)
SCM_DO_BUILD_DURING_DEPLOYMENT = true
WEBSITE_WEBDEPLOY_USE_SCM = false
```

### 3️⃣ Set Startup Command (Configuration → General settings)
```
python3 -m gunicorn app:app
```

### 4️⃣ Deploy Code - Choose One Method:

**Option A: Local Git**
```bash
git init
git add .
git commit -m "Initial deployment"
git remote add azure <Git-Clone-Uri-from-Portal>
git push azure main
```

**Option B: ZIP Upload**
- Deployment Center → Advanced Tools → Go
- Tools → Zip Push Deploy
- Drag & drop zip file

**Option C: GitHub**
- Deployment Center → Source: GitHub
- Authorize & select repository

### 5️⃣ Verify
- Log Stream → Check for startup success
- Browse to URL → Test chat

### 6️⃣ Production Setup (Optional)
- Authentication → Add identity provider → Microsoft
- Change `AUTH_ENABLED = True`

## 🔥 Common Issues

| Problem | Solution |
|---------|----------|
| Blank page | Did you run `npm run build`? Check static/ folder |
| "Application Error" | Check Log Stream for details |
| OpenAI errors | Verify AZURE_OPENAI_KEY and MODEL name |
| 500 errors | Enable DEBUG=True, check logs |

## 📍 Where to Find Things in Portal

- **Configuration:** Settings → Configuration
- **Logs:** Monitoring → Log stream
- **Deploy:** Deployment → Deployment Center
- **Advanced:** Development Tools → Advanced Tools
- **Auth:** Settings → Authentication
- **Scale:** Settings → Scale up/out

## ⚡ Quick URLs

Your app: `https://YOUR-APP-NAME.azurewebsites.net`
Kudu console: `https://YOUR-APP-NAME.scm.azurewebsites.net`

## 🎯 Minimal Working Configuration

Just need 4 settings to get started:
1. `AZURE_OPENAI_RESOURCE`
2. `AZURE_OPENAI_MODEL`
3. `AZURE_OPENAI_KEY`
4. `AZURE_OPENAI_PREVIEW_API_VERSION`

Plus the startup command: `python3 -m gunicorn app:app`

---

**Time estimate:** 15-20 minutes for first deployment
