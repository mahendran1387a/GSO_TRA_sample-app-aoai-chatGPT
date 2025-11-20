# Complete Beginner's Guide to Deploying Azure OpenAI Chat App

**👋 Welcome!** This guide assumes you've never deployed to Azure before. I'll explain every single step.

---

## 📋 What You'll Need Before Starting

### 1. An Azure Account
- Go to [https://azure.microsoft.com/free/](https://azure.microsoft.com/free/)
- Click "Start free" or "Sign in"
- You'll need a Microsoft account (like Outlook, Hotmail, or work email)
- You may need a credit card (for verification), but we'll use free/cheap services

### 2. Azure OpenAI Access
- You need an Azure OpenAI resource already created
- If you don't have one, ask your Azure administrator
- You'll need:
  - The resource name (e.g., "my-openai-resource")
  - The API key (a long string of letters/numbers)
  - The model deployment name (e.g., "gpt-35-turbo")

### 3. Software on Your Computer
- **Node.js**: Download from [https://nodejs.org](https://nodejs.org) (choose LTS version)
- **Git**: Download from [https://git-scm.com/downloads](https://git-scm.com/downloads)
- **A text editor**: VS Code recommended from [https://code.visualstudio.com](https://code.visualstudio.com)

### 4. This Application Code
- Downloaded or cloned to your computer
- Open it in a folder (you should see files like `app.py`, `frontend/`, `README.md`)

---

## 🎯 Overview - What We'll Do

1. **Build the frontend** on your computer (5 minutes)
2. **Create a Web App** in Azure Portal (10 minutes)
3. **Configure settings** for Azure OpenAI (5 minutes)
4. **Upload your code** to Azure (10 minutes)
5. **Test your app** (5 minutes)

**Total time: About 35 minutes**

---

## PART 1: Build the Frontend on Your Computer

### Why do this?
The app has a React frontend that needs to be "compiled" into files that browsers can understand.

### Step 1.1: Open Terminal/Command Prompt

**On Windows:**
1. Press `Windows Key + R`
2. Type `cmd` and press Enter
3. A black window opens - this is Command Prompt

**On Mac:**
1. Press `Command + Space`
2. Type `terminal` and press Enter
3. A window opens - this is Terminal

**On Linux:**
1. Press `Ctrl + Alt + T`
2. Terminal opens

### Step 1.2: Navigate to Your Project Folder

In the terminal, type this (replace the path with where YOU saved the project):

**Windows example:**
```cmd
cd C:\Users\YourName\Downloads\GSO_TRA_sample-app-aoai-chatGPT
```

**Mac/Linux example:**
```bash
cd ~/Downloads/GSO_TRA_sample-app-aoai-chatGPT
```

**How to know you're in the right place?**
- Type `dir` (Windows) or `ls` (Mac/Linux) and press Enter
- You should see folders like: `frontend`, `backend`, `static`
- You should see files like: `app.py`, `README.md`

### Step 1.3: Install Frontend Dependencies

Type these commands exactly (press Enter after each):

```bash
cd frontend
```

**What you'll see:** The prompt changes to show you're in the frontend folder

```bash
npm install
```

**What you'll see:**
- Lots of text scrolling (packages being downloaded)
- Takes 1-2 minutes
- May show some warnings (that's OK)
- Ends with "added XXX packages"

**If you get an error** saying "npm is not recognized":
- You need to install Node.js first (see "What You'll Need" section)
- Restart your terminal after installing

### Step 1.4: Build the Frontend

Still in the frontend folder, type:

```bash
npm run build
```

**What you'll see:**
- Text saying "vite v..." and "building for production..."
- Takes 30-60 seconds
- Ends with "✓ built in XXs"

**What this creates:**
- A new folder called `static` in your main project folder
- This folder contains the compiled frontend files

### Step 1.5: Verify the Build

Go back to the main folder:

```bash
cd ..
```

Check that the static folder exists:

**Windows:**
```cmd
dir static
```

**Mac/Linux:**
```bash
ls -la static/
```

**You should see:**
- A file called `index.html`
- A folder called `assets`
- Some other files

✅ **If you see these files, you're done with Part 1!**

**Keep this terminal window open** - we'll use it later.

---

## PART 2: Create Azure Web App in the Portal

### Step 2.1: Open Azure Portal

1. Open your web browser (Chrome, Edge, Firefox, Safari)
2. Go to: [https://portal.azure.com](https://portal.azure.com)
3. Sign in with your Microsoft account
4. You'll see the Azure Portal home page (blue theme with tiles)

### Step 2.2: Start Creating a Web App

1. **Find the "Create a resource" button**
   - It's in the top-left area
   - Has a **+ (plus)** icon
   - Click it

2. **You'll see the Azure Marketplace**
   - At the top is a search box that says "Search services and marketplace"
   - Click in this search box

3. **Search for Web App**
   - Type: `web app`
   - You'll see suggestions appear below
   - Look for "**Web App**" (with a globe icon)
   - Published by "Microsoft"
   - Click on it

4. **Create Web App**
   - You'll see a page describing Web App
   - Click the blue "**Create**" button
   - A new page opens: "Create Web App"

### Step 2.3: Fill in Basic Settings

You'll see a form with several sections. Let's fill each one:

#### **Project Details Section:**

1. **Subscription**
   - Click the dropdown
   - Choose your subscription (you probably only have one)
   - This determines billing

2. **Resource Group**
   - This is like a folder for organizing Azure resources
   - Click the dropdown
   - If you have existing groups, you can choose one
   - **OR click "Create new":**
     - A small popup appears
     - Type a name: `rg-chatbot-app` (you can use any name)
     - Click "OK"

#### **Instance Details Section:**

1. **Name**
   - This is VERY important - it becomes your website address
   - Type a unique name (only letters, numbers, hyphens)
   - Examples: `my-ai-chatbot`, `johnsmith-chatapp`, `company-gpt-app`
   - As you type, Azure checks if it's available
   - ✅ Green checkmark = available
   - ❌ Red X = already taken, try another name
   - **Remember this name** - your app URL will be:
     `https://YOUR-NAME-HERE.azurewebsites.net`

2. **Publish**
   - You'll see radio buttons
   - Select: **Code** (not Docker Container)

3. **Runtime stack**
   - Click the dropdown
   - Scroll down and find: **Python 3.11**
   - Click it
   - (If you don't see 3.11, choose 3.10, but 3.11 is preferred)

4. **Operating System**
   - You'll see radio buttons
   - Select: **Linux** (not Windows)

5. **Region**
   - Click the dropdown
   - Choose a region close to you:
     - US East Coast → `East US`
     - US West Coast → `West US`
     - Europe → `North Europe` or `West Europe`
     - Asia → `Southeast Asia`
   - Closer = faster response times

#### **Pricing Plans Section:**

1. **Linux Plan**
   - If you already have an App Service Plan, you can choose it
   - OR it will create a new one automatically (that's fine)
   - The name doesn't matter much

2. **Pricing plan**
   - You'll see the current plan (might say "Basic B1" or "Free F1")
   - Click **"Explore pricing plans"** to see options
   - **For testing/learning**: Choose **Basic B1**
     - Costs about $0.018/hour (~$13/month)
     - Good performance
   - **For production**: Choose **Premium P1V2** or higher
   - Click on your choice, then click "**Select**" at the bottom

### Step 2.4: Skip Optional Sections (For Now)

You'll see tabs at the top:
- Basics (you just filled this)
- Deployment ← skip for now
- Networking ← skip for now
- Monitoring ← skip for now
- Tags ← skip for now

### Step 2.5: Create the Web App

1. Click the blue "**Review + create**" button at the bottom
2. Azure will validate your settings (takes 5 seconds)
3. You'll see a summary of what you're creating
4. Check:
   - App name is correct
   - Runtime is Python 3.11
   - Region looks right
5. Click the blue "**Create**" button at the bottom

**What happens now:**
- Azure says "Deployment is in progress"
- You'll see a progress bar
- Takes 1-2 minutes
- When done, you'll see "Your deployment is complete" ✅

6. Click the blue "**Go to resource**" button

**You're now on your Web App's page!** Bookmark this page or keep it open.

---

## PART 3: Configure Application Settings

Your app needs to know how to connect to Azure OpenAI. We'll add settings.

### Step 3.1: Open Configuration

1. **Look at the left side** of the screen
   - You'll see a menu with many options
   - This is called the "left navigation" or "sidebar"

2. **Find the "Settings" section**
   - Scroll down in the left menu
   - You'll see a section labeled "Settings"
   - Under it, find "**Configuration**"
   - Click on "**Configuration**"

3. **You'll see the Configuration page**
   - At the top are tabs: "Application settings", "General settings", "Default documents", etc.
   - You should be on "**Application settings**" (if not, click it)

### Step 3.2: Get Your Azure OpenAI Information

**Before adding settings, gather this information:**

You need to find your Azure OpenAI resource. Here's how:

1. **Open a new browser tab** (don't close this one)
2. Go to: [https://portal.azure.com](https://portal.azure.com)
3. In the top search bar (says "Search resources, services, and docs")
   - Type: `openai` or the name of your OpenAI resource
4. Click on your Azure OpenAI resource
5. **Get the Resource Name:**
   - Look at the top of the page
   - The name is shown in big text (e.g., "my-openai-resource")
   - **Write this down**
6. **Get the API Key:**
   - In the left menu, find "Resource Management"
   - Click "**Keys and Endpoint**"
   - You'll see "KEY 1" with a long string
   - Click the copy icon (📋) next to it
   - **Paste this into a notepad** - you'll need it in a moment
7. **Get the Model Deployment Name:**
   - In the left menu, find "**Deployments**" (or "Model deployments")
   - You'll see a list of deployed models
   - Find the model you want to use (e.g., "gpt-35-turbo-16k")
   - **Write down the "Deployment name"** (might be different from model name)

**Now return to your Web App's Configuration tab** (the first browser tab).

### Step 3.3: Add Settings One by One

We'll add settings by clicking the "+ New application setting" button for each one.

#### Setting 1: AZURE_OPENAI_RESOURCE

1. Click "**+ New application setting**" (near the top)
2. A popup window appears with two boxes
3. In the "**Name**" box, type exactly: `AZURE_OPENAI_RESOURCE`
4. In the "**Value**" box, paste your OpenAI resource name (e.g., `my-openai-resource`)
5. Click "**OK**" at the bottom

#### Setting 2: AZURE_OPENAI_MODEL

1. Click "**+ New application setting**" again
2. Name: `AZURE_OPENAI_MODEL`
3. Value: Your deployment name (e.g., `gpt-35-turbo-16k`)
4. Click "**OK**"

#### Setting 3: AZURE_OPENAI_KEY

1. Click "**+ New application setting**"
2. Name: `AZURE_OPENAI_KEY`
3. Value: Paste the API key you copied earlier (long string like `a1b2c3d4...`)
4. Click "**OK**"

#### Setting 4: AZURE_OPENAI_PREVIEW_API_VERSION

1. Click "**+ New application setting**"
2. Name: `AZURE_OPENAI_PREVIEW_API_VERSION`
3. Value: `2024-05-01-preview`
4. Click "**OK**"

#### Setting 5: AUTH_ENABLED (For Testing Only)

1. Click "**+ New application setting**"
2. Name: `AUTH_ENABLED`
3. Value: `False`
4. Click "**OK**"
5. **⚠️ Important:** This disables authentication for testing. For production, change this to `True` and set up authentication!

#### Setting 6: SCM_DO_BUILD_DURING_DEPLOYMENT

1. Click "**+ New application setting**"
2. Name: `SCM_DO_BUILD_DURING_DEPLOYMENT`
3. Value: `true`
4. Click "**OK**"

### Step 3.4: Save Settings

**Very Important - Don't Skip This!**

1. Look at the top of the Configuration page
2. You'll see a "**Save**" button (might be disabled/greyed out at first)
3. Click "**Save**"
4. A warning popup appears: "Changes will restart the app"
5. Click "**Continue**"
6. Wait 5-10 seconds for "Settings saved successfully" message

### Step 3.5: Set Startup Command

Still in Configuration, we need to tell Azure how to start the app.

1. **Click the "General settings" tab** (at the top, next to "Application settings")
2. Scroll down to find "**Startup Command**" section
3. You'll see a text box (might be empty)
4. Click in the text box
5. Type exactly: `python3 -m gunicorn app:app`
6. Click "**Save**" at the top
7. Click "**Continue**" on the warning popup

✅ **Configuration complete!**

---

## PART 4: Deploy Your Code to Azure

Now we'll upload your application code. We'll use the **Local Git** method (easiest for beginners).

### Step 4.1: Enable Local Git Deployment

1. **In the left menu of your Web App**, find "**Deployment**" section
2. Click "**Deployment Center**"
3. You'll see the Deployment Center page

4. **Click the "Settings" tab** (at the top)
5. Under "**Source**", click the dropdown
6. Select "**Local Git**"
7. Click "**Save**" at the top
8. Wait for "Settings saved successfully"

### Step 4.2: Get Git URL and Credentials

Still in Deployment Center:

1. **Get the Git Clone Uri:**
   - You'll see "Git Clone Uri" on the screen
   - It looks like: `https://your-app-name.scm.azurewebsites.net/your-app-name.git`
   - Click the copy icon (📋) next to it
   - **Paste this into your notepad** - we'll need it soon

2. **Get Deployment Credentials:**
   - Click the "**Local Git/FTPS credentials**" tab (at the top)
   - You'll see two sections: "Application scope" and "User scope"
   - Under "**User scope**":
     - If empty, enter a username (e.g., `deploy-user-yourname`)
     - Click "**Reset publish profile**" or create password
     - You'll see a Username (might include `$` sign)
     - **Copy the Username** (e.g., `your-app-name\$your-app-name`)
     - **Copy the Password** (or create one if needed)
   - **Write these down** - you'll need them in 2 minutes

### Step 4.3: Prepare Your Code for Deployment

**Go back to your terminal** (from Part 1). Make sure you're in the main project folder.

Check where you are:
```bash
pwd
```
Should show your project folder path.

If you're still in `frontend/`, go back:
```bash
cd ..
```

### Step 4.4: Initialize Git (If Not Already Done)

Check if git is initialized:
```bash
git status
```

**If you see:** "fatal: not a git repository"
Then run:
```bash
git init
```

**If you see:** A list of files or "nothing to commit"
Then git is already initialized (good!), continue to next step.

### Step 4.5: Add All Files to Git

```bash
git add .
```

**What this does:** Stages all your files for commit (like packing them up)

**You should see:** Nothing (no output is normal)

### Step 4.6: Commit Your Files

```bash
git commit -m "Initial deployment to Azure"
```

**What you'll see:**
- Text like "XXX files changed"
- "create mode" for many files
- This saves your changes to Git

**If you see:** "Nothing to commit"
- Your files might already be committed
- That's fine, continue to next step

### Step 4.7: Add Azure Remote

Now connect your local Git to Azure:

```bash
git remote add azure <PASTE-YOUR-GIT-CLONE-URI-HERE>
```

**Replace `<PASTE-YOUR-GIT-CLONE-URI-HERE>` with the Git Clone Uri you copied earlier!**

**Example (use YOUR url, not this):**
```bash
git remote add azure https://my-chatbot-app.scm.azurewebsites.net/my-chatbot-app.git
```

**If you get "remote azure already exists":**
```bash
git remote remove azure
```
Then try the `git remote add azure` command again.

### Step 4.8: Push Code to Azure

This is the big moment! Push your code:

```bash
git push azure main
```

**OR if you're on a branch called master:**
```bash
git push azure master
```

**What happens:**
1. You'll be prompted for username and password
2. Enter the deployment username (from Step 4.2)
3. Enter the deployment password (from Step 4.2)
4. **Lots of text will scroll!** This is Azure:
   - Receiving your files
   - Installing Python packages
   - Setting up the app
5. Takes 3-5 minutes
6. Ends with "remote: Deployment successful."

**Common Issues:**

- **"Authentication failed"**: Double-check username/password
- **"Does not appear to be a git repository"**: Check your Git Clone Uri
- **"Updates were rejected"**: Try `git push azure main --force`

✅ **If you see "Deployment successful", you did it!**

---

## PART 5: Test Your Application

### Step 5.1: Check the Logs

Let's verify the app started correctly:

1. **Go back to Azure Portal** (your Web App page)
2. **In the left menu**, under "**Monitoring**"
3. Click "**Log stream**"
4. Wait 10-30 seconds for logs to load

**What you should see:**
```
Starting gunicorn...
Booting worker with pid: 123
Application startup complete
```

**If you see errors:**
- Read the error message carefully
- Common issue: Missing environment variables
- Go back to Part 3 and double-check all settings

### Step 5.2: Open Your App

1. **In the left menu**, click "**Overview**" (at the very top)
2. You'll see your app's information
3. Find the "**URL**" (or "Default domain")
   - It looks like: `https://your-app-name.azurewebsites.net`
4. **Click the URL** (or copy and paste into a new browser tab)

### Step 5.3: Test the Chat

If everything worked, you should see:
- A chat interface
- An input box at the bottom
- Maybe a logo at the top

**Try it out:**
1. Type a message in the input box: "Hello, can you help me?"
2. Press Enter or click Send
3. Wait a few seconds
4. You should see a response from the AI!

🎉 **Congratulations! Your app is deployed and working!**

---

## PART 6: What to Do Next

### Enable Authentication (Important for Production!)

Your app currently allows anyone to use it. For production:

1. Go to your Web App in Azure Portal
2. Left menu → "**Authentication**"
3. Click "**Add identity provider**"
4. Choose "**Microsoft**"
5. Follow the wizard (mostly just click Next and Create)
6. Go back to Configuration → Application settings
7. Change `AUTH_ENABLED` to `True`
8. Save

Now users must log in with Microsoft account to use the app.

### Add Chat History (Optional)

To save conversation history:
1. Create a CosmosDB account (see full guide)
2. Add CosmosDB settings to your app
3. Restart the app

### Customize the UI

Change application settings:
- `UI_TITLE` - Change the app title
- `UI_LOGO` - Add your logo URL
- `UI_CHAT_TITLE` - Change chat window title

### Monitor Usage

1. Left menu → "**Metrics**" (under Monitoring)
2. Add charts for CPU, Memory, Requests
3. Set up alerts if you want

---

## 🆘 Troubleshooting Common Problems

### Problem: "Application Error" when opening URL

**Solution:**
1. Check Log stream for specific errors
2. Verify all application settings are correct
3. Make sure you ran `npm run build` before deployment

### Problem: Blank white page

**Cause:** Frontend wasn't built or deployed

**Solution:**
1. On your computer, verify `static/index.html` exists
2. Re-run deployment (Part 4)
3. Check that `static` folder uploaded:
   - Azure Portal → Your App → Development Tools → Advanced Tools → Go
   - Click Debug console → CMD
   - Navigate to `/home/site/wwwroot`
   - Verify `static` folder is there

### Problem: "OpenAI API key is invalid"

**Solution:**
1. Go to Configuration → Application settings
2. Check `AZURE_OPENAI_KEY` is correct
3. Regenerate key in Azure OpenAI if needed
4. Update the setting and Save

### Problem: Git push keeps asking for password

**Solution:**
1. Make sure you're entering the deployment credentials (not your Azure Portal password)
2. Find them in: Deployment Center → Local Git/FTPS credentials
3. Copy/paste exactly (don't type manually)

### Problem: App is slow or times out

**Solution:**
1. Your SKU might be too small
2. Upgrade: Left menu → Scale up (App Service plan)
3. Choose P1V2 or higher
4. Click Apply

---

## 📞 Getting Help

### Check These Resources:

1. **Azure App Service Documentation:**
   - [https://learn.microsoft.com/azure/app-service/](https://learn.microsoft.com/azure/app-service/)

2. **Azure OpenAI Documentation:**
   - [https://learn.microsoft.com/azure/ai-services/openai/](https://learn.microsoft.com/azure/ai-services/openai/)

3. **Project GitHub:**
   - [https://github.com/microsoft/sample-app-aoai-chatGPT](https://github.com/microsoft/sample-app-aoai-chatGPT)

### Enable Detailed Logging:

1. Azure Portal → Your Web App
2. Left menu → "App Service logs"
3. Turn everything to "On"
4. Set level to "Information"
5. Save
6. Check Log stream again

---

## ✅ Final Checklist

Before you finish, verify:

- [ ] You can access your app URL
- [ ] The chat interface loads
- [ ] You can send messages and get responses
- [ ] Application settings are all correct
- [ ] You've bookmarked your app URL
- [ ] You know where to find logs (Log stream)
- [ ] You've saved your Git deployment credentials

---

## 🎓 What You Learned

Congratulations! You've successfully:
✅ Built a React frontend
✅ Created an Azure Web App
✅ Configured environment variables
✅ Deployed code using Git
✅ Connected to Azure OpenAI
✅ Tested a live web application

You now have a working AI chatbot running in the cloud! 🚀

---

**Questions?** Review the troubleshooting section or check the full documentation in `DEPLOYMENT_GUIDE_PORTAL.md`.

**Want to go deeper?** Check out the advanced features:
- Chat history with CosmosDB
- Custom authentication
- Connecting to your own data sources
- Scaling and performance optimization
