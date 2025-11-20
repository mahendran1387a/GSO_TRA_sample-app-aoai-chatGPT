# Azure Web App Deployment Guide - Azure Portal UI

This guide walks you through deploying the Azure OpenAI Chat application using the Azure Portal web interface.

---

## 📋 Prerequisites

Before starting, ensure you have:

1. ✅ **Azure subscription** with access to Azure Portal
2. ✅ **Azure OpenAI resource** with a deployed model (e.g., gpt-35-turbo, gpt-4)
3. ✅ **Node.js and npm** installed on your local machine
4. ✅ **Git** installed (for deployment)
5. ✅ This application code on your local machine

---

## 🔨 Step 1: Build the Frontend Locally

**⚠️ IMPORTANT:** You must build the frontend before deployment!

### On your local machine:

1. Open a terminal/command prompt in the project root directory

2. Navigate to frontend folder and install dependencies:
   ```bash
   cd frontend
   npm install
   ```

3. Build the frontend:
   ```bash
   npm run build
   ```

4. Verify the `static` folder was created in the root directory:
   ```bash
   cd ..
   ls -la static/
   ```

   You should see `index.html`, `assets/`, and other files.

5. **Keep this terminal open** - we'll use it later for deployment.

---

## 🌐 Step 2: Create Azure Web App

### 2.1 Navigate to Azure Portal

1. Go to [https://portal.azure.com](https://portal.azure.com)
2. Sign in with your Azure account

### 2.2 Create a New Web App

1. Click **"Create a resource"** (+ icon in top-left)
2. Search for **"Web App"**
3. Click **"Web App"** by Microsoft
4. Click **"Create"**

### 2.3 Configure Basic Settings

**Project Details:**
- **Subscription:** Select your subscription
- **Resource Group:**
  - Select existing OR click "Create new"
  - Name example: `rg-aoai-chatbot`

**Instance Details:**
- **Name:** Enter a unique name (e.g., `my-aoai-chatbot-app`)
  - This will be your URL: `https://my-aoai-chatbot-app.azurewebsites.net`
- **Publish:** Select **Code**
- **Runtime stack:** Select **Python 3.11**
- **Operating System:** Select **Linux**
- **Region:** Select your preferred region (e.g., East US)

**Pricing Plan:**
- **Linux Plan:** Create new or select existing
- **Pricing plan:**
  - For testing: **Basic B1** (click "Explore pricing plans" to see options)
  - For production: **Premium P1V2** or higher

### 2.4 Review and Create

1. Click **"Review + create"**
2. Verify your settings
3. Click **"Create"**
4. Wait 1-2 minutes for deployment to complete
5. Click **"Go to resource"**

---

## ⚙️ Step 3: Configure Application Settings

### 3.1 Navigate to Configuration

1. In your Web App page, find the left menu
2. Under **"Settings"**, click **"Configuration"**

### 3.2 Add Application Settings

Click **"+ New application setting"** for each of these (REQUIRED):

#### Required Settings:

| Name | Value | Description |
|------|-------|-------------|
| `AZURE_OPENAI_RESOURCE` | `your-openai-resource-name` | Your Azure OpenAI resource name |
| `AZURE_OPENAI_MODEL` | `gpt-35-turbo-16k` | Your deployment name in Azure OpenAI |
| `AZURE_OPENAI_KEY` | `your-key-here` | API key from Azure OpenAI resource |
| `AZURE_OPENAI_PREVIEW_API_VERSION` | `2024-05-01-preview` | API version |
| `SCM_DO_BUILD_DURING_DEPLOYMENT` | `true` | Enable build automation |
| `WEBSITE_WEBDEPLOY_USE_SCM` | `false` | Allow local deployment |

#### Optional Settings (Recommended):

| Name | Value | Description |
|------|-------|-------------|
| `AUTH_ENABLED` | `False` | Disable auth for testing (enable for production!) |
| `MS_DEFENDER_ENABLED` | `True` | Enable Microsoft Defender integration |
| `DEBUG` | `False` | Set to `True` for troubleshooting |
| `AZURE_OPENAI_TEMPERATURE` | `0` | Model temperature |
| `AZURE_OPENAI_MAX_TOKENS` | `1000` | Max tokens |
| `UI_TITLE` | `My AI Assistant` | Custom app title |

### 3.3 Save Configuration

1. Click **"Save"** at the top
2. Click **"Continue"** when warned about restart
3. Wait for the app to restart (30-60 seconds)

---

## 🚀 Step 4: Set Startup Command

### 4.1 Navigate to Configuration > General Settings

1. In **Configuration** page, click **"General settings"** tab
2. Find **"Startup Command"** field
3. Enter: `python3 -m gunicorn app:app`
4. Click **"Save"** at the top

---

## 📦 Step 5: Deploy Your Code

You have several deployment options. Choose one:

---

### **Option A: Deploy with Git (Recommended)**

#### 5.1 Enable Local Git

1. In left menu, under **"Deployment"**, click **"Deployment Center"**
2. Click **"Settings"** tab
3. Under **"Source"**, select **"Local Git"**
4. Click **"Save"**
5. Wait for settings to save
6. Copy the **Git Clone Uri** (looks like: `https://my-aoai-chatbot-app.scm.azurewebsites.net/my-aoai-chatbot-app.git`)

#### 5.2 Get Deployment Credentials

1. Click **"Local Git/FTPS credentials"** tab
2. Under **"User scope"**:
   - Note the **Username** (looks like: `my-aoai-chatbot-app\$my-aoai-chatbot-app`)
   - Click **"Reset password"** if needed
   - **Copy the password** (you'll need this)

#### 5.3 Deploy from Local Machine

In your terminal (in project root):

```bash
# Initialize git if not already
git init

# Add all files
git add .

# Commit
git commit -m "Initial deployment"

# Add Azure remote (use the Git Clone Uri from step 5.1)
git remote add azure https://my-aoai-chatbot-app.scm.azurewebsites.net/my-aoai-chatbot-app.git

# Push to Azure (you'll be prompted for username/password from step 5.2)
git push azure main
```

**Note:** If your branch is named `master` instead of `main`, use:
```bash
git push azure master
```

Wait 3-5 minutes for deployment to complete.

---

### **Option B: Deploy with ZIP File**

#### 5.1 Create a ZIP file

**On Windows:**
1. Select all files in project root (NOT the folder itself)
2. Right-click → Send to → Compressed (zipped) folder
3. Name it `app.zip`

**On Mac/Linux:**
```bash
zip -r app.zip . -x "*.git*" -x "*node_modules*" -x "*.venv*"
```

#### 5.2 Deploy via Azure Portal

1. In left menu, click **"Advanced Tools"** (under Development Tools)
2. Click **"Go →"** (opens Kudu console in new tab)
3. In Kudu, click **"Tools"** → **"Zip Push Deploy"**
4. Drag and drop your `app.zip` file to the `/home/site/wwwroot` area
5. Wait for upload and extraction to complete

---

### **Option C: Deploy with GitHub Actions**

If your code is in GitHub:

1. In **Deployment Center**, select **"GitHub"**
2. Click **"Authorize"** and sign in to GitHub
3. Select your **Organization**, **Repository**, and **Branch**
4. Click **"Save"**
5. Azure will automatically create a GitHub Actions workflow
6. Every push to the branch will auto-deploy

---

## 🔍 Step 6: Verify Deployment

### 6.1 Check Application Logs

1. In left menu, under **"Monitoring"**, click **"Log stream"**
2. Wait for logs to load (may take 30-60 seconds)
3. Look for:
   ```
   Starting gunicorn...
   Booting worker with pid: ...
   ```
4. If you see errors, troubleshoot in Step 8

### 6.2 Test the Application

1. In Web App **Overview** page, find your **URL**
2. Click the URL (e.g., `https://my-aoai-chatbot-app.azurewebsites.net`)
3. You should see the chat interface
4. Try sending a test message

---

## 🔐 Step 7: Enable Authentication (Production)

**⚠️ IMPORTANT:** For production, enable authentication!

### 7.1 Set Up Microsoft Entra ID

1. In left menu, under **"Settings"**, click **"Authentication"**
2. Click **"Add identity provider"**
3. Select **"Microsoft"**
4. Configure:
   - **App registration type:** Create new registration
   - **Name:** `my-aoai-chatbot-auth`
   - **Supported account types:** Choose your organization type
   - **Restrict access:** Yes
5. Click **"Add"**

### 7.2 Update Application Setting

1. Go back to **Configuration** → **Application settings**
2. Find `AUTH_ENABLED` and change to `True`
3. Click **"Save"**

### 7.3 Test Authentication

1. Open your app URL in an incognito/private window
2. You should be redirected to Microsoft login
3. After login, you should see the chat interface

---

## 💾 Step 8: Optional - Enable Chat History (CosmosDB)

### 8.1 Create CosmosDB Account

1. In Azure Portal, click **"Create a resource"**
2. Search for **"Azure Cosmos DB"**
3. Select **"Azure Cosmos DB for NoSQL"**
4. Click **"Create"**
5. Configure:
   - **Resource Group:** Same as your Web App
   - **Account Name:** `cosmos-aoai-chatbot`
   - **Location:** Same region as Web App
   - **Capacity mode:** Serverless (cheaper for testing)
6. Click **"Review + create"** → **"Create"**
7. Wait 3-5 minutes for deployment

### 8.2 Create Database and Container

1. Go to your CosmosDB account
2. In left menu, click **"Data Explorer"**
3. Click **"New Database"**
   - **Database id:** `db_conversation_history`
   - Click **"OK"**
4. Click **"New Container"**
   - **Database id:** Use existing `db_conversation_history`
   - **Container id:** `conversations`
   - **Partition key:** `/userId`
   - Click **"OK"**

### 8.3 Get Connection Details

1. In CosmosDB, go to **"Keys"** (under Settings)
2. Copy:
   - **URI** (e.g., `https://cosmos-aoai-chatbot.documents.azure.com:443/`)
   - **PRIMARY KEY**

### 8.4 Add CosmosDB Settings to Web App

1. Go back to your **Web App** → **Configuration**
2. Add these application settings:

| Name | Value |
|------|-------|
| `AZURE_COSMOSDB_ACCOUNT` | `cosmos-aoai-chatbot` |
| `AZURE_COSMOSDB_DATABASE` | `db_conversation_history` |
| `AZURE_COSMOSDB_CONVERSATIONS_CONTAINER` | `conversations` |
| `AZURE_COSMOSDB_ACCOUNT_KEY` | (paste PRIMARY KEY) |
| `AZURE_COSMOSDB_ENABLE_FEEDBACK` | `True` |

3. Click **"Save"**
4. Test: Chat history should now persist between sessions

---

## 🔧 Step 9: Troubleshooting

### Issue: App shows "Application Error"

**Solution:**
1. Go to **"Diagnose and solve problems"** (left menu)
2. Click **"Availability and Performance"**
3. Review identified issues
4. Check **Log stream** for detailed errors

### Issue: "No module named 'app'"

**Solution:**
1. Verify `app.py` is in the root directory
2. Check **Deployment Center** → **Logs** to see deployment status
3. Verify startup command: `python3 -m gunicorn app:app`

### Issue: Frontend not loading (blank page)

**Solution:**
1. Verify you ran `npm run build` locally before deployment
2. Check that `static/` folder exists in deployment:
   - Go to **Advanced Tools** → **Go**
   - Click **Debug console** → **CMD**
   - Navigate to `/home/site/wwwroot/static`
   - Verify `index.html` exists

### Issue: Azure OpenAI connection errors

**Solution:**
1. Go to **Configuration** → **Application settings**
2. Verify these are correct:
   - `AZURE_OPENAI_RESOURCE` (just the name, not full URL)
   - `AZURE_OPENAI_MODEL` (your deployment name)
   - `AZURE_OPENAI_KEY` (valid key)
3. Test connection in **Log stream**

### Enable Detailed Logging

1. Go to **App Service logs** (under Monitoring)
2. Enable:
   - **Application Logging (Filesystem):** On → Level: Information
   - **Detailed Error Messages:** On
   - **Failed Request Tracing:** On
3. Click **"Save"**
4. Check **Log stream** again

---

## 📊 Step 10: Monitoring and Scaling

### View Metrics

1. In left menu, click **"Metrics"** (under Monitoring)
2. Add charts for:
   - CPU Percentage
   - Memory Percentage
   - Response Time
   - Requests

### Scale Up (Better Performance)

1. In left menu, click **"Scale up (App Service plan)"**
2. Select a higher tier:
   - **P1V2** (Production - 1 core, 3.5GB RAM)
   - **P2V2** (High traffic - 2 cores, 7GB RAM)
3. Click **"Apply"**

### Scale Out (More Instances)

1. In left menu, click **"Scale out (App Service plan)"**
2. Manual scale: Set instance count (2-10)
3. Or enable **Automatic scaling** based on metrics
4. Click **"Save"**

---

## ✅ Deployment Checklist

- [ ] Frontend built locally (`npm run build`)
- [ ] Web App created with Python 3.11 runtime
- [ ] Application settings configured (Azure OpenAI keys)
- [ ] Startup command set (`python3 -m gunicorn app:app`)
- [ ] Code deployed (Git/ZIP/GitHub Actions)
- [ ] Application accessible via URL
- [ ] Chat functionality tested
- [ ] Authentication enabled (for production)
- [ ] Chat history configured (optional)
- [ ] Monitoring and alerts set up

---

## 🎯 Quick Reference

### Important URLs

- **Azure Portal:** https://portal.azure.com
- **Your App URL:** https://YOUR-APP-NAME.azurewebsites.net
- **Kudu Console:** https://YOUR-APP-NAME.scm.azurewebsites.net

### Key Configuration Files

- `app.py` - Main backend application
- `gunicorn.conf.py` - Production server configuration
- `requirements.txt` - Python dependencies
- `frontend/` - React frontend source
- `static/` - Built frontend files (created by `npm run build`)

### Support Resources

- [Azure App Service Documentation](https://learn.microsoft.com/azure/app-service/)
- [Azure OpenAI Documentation](https://learn.microsoft.com/azure/ai-services/openai/)
- [Project GitHub Issues](https://github.com/microsoft/sample-app-aoai-chatGPT/issues)

---

## 🚀 You're Done!

Your Azure OpenAI Chat application is now deployed and running on Azure Web App!

**Next Steps:**
- Customize the UI (update `UI_TITLE`, `UI_LOGO` settings)
- Add your data sources (Azure Search, CosmosDB, etc.)
- Set up continuous deployment with GitHub Actions
- Configure custom domain and SSL
- Enable Application Insights for monitoring

---

**Need help?** Check the troubleshooting section or review Azure App Service logs.
